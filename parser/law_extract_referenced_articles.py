"""
law_extract_referenced_articles.py — Annotate only the Criminal Code articles
that are actually referenced from our verdict XMLs.

Articles 416–425 are already annotated in
  legal-texts/akoma-ntoso/glava_34_krivicna_djela_protiv_sluzbene_duznosti.xml

This script extracts the remaining referenced articles from the PDF, sends them
to Claude in small batches for Akoma Ntoso annotation, caches each batch,
then writes a single merged file
  legal-texts/akoma-ntoso/krivicni_zakonik_referenced.xml

that contains Chapter 34 + a "Referenced articles" part with everything else.

Usage:
  python law_extract_referenced_articles.py                 # full run (cached)
  python law_extract_referenced_articles.py -w 2 --resume   # slower, reuse cache
"""

import argparse
import re
import subprocess
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parent.parent
PDF_PATH = PROJECT_ROOT / "data" / "laws" / "krivicni_zakonik.pdf"
OUTPUT_DIR = PROJECT_ROOT / "legal-texts" / "akoma-ntoso"
CACHE_DIR = OUTPUT_DIR / "_ref_article_cache"
CHAPTER_34_XML = OUTPUT_DIR / "glava_34_krivicna_djela_protiv_sluzbene_duznosti.xml"
OUTPUT_FILE = OUTPUT_DIR / "krivicni_zakonik_referenced.xml"

# Referenced articles collected from judgements/akoma-ntoso/ hrefs,
# minus 416-425 which are already annotated in chapter 34.
REFERENCED_ARTICLES = [
    2, 4, 5, 13, 15, 20, 25, 32, 33, 36, 42, 45, 46, 49, 51, 52, 53, 54, 75,
    117, 133, 142, 143, 152, 172, 196, 207, 216, 227, 240, 242, 244, 254, 272,
    300, 327, 339, 340, 347, 348, 375, 399, 401, 403, 412, 414,
]

BATCH_SIZE = 6


def extract_full_text(pdf_path: Path) -> str:
    import PyPDF2
    reader = PyPDF2.PdfReader(str(pdf_path))
    text = "\n".join((p.extract_text() or "") for p in reader.pages)
    # Strip Paragraf Lex page headers
    text = re.sub(
        r"\d+/\d+/\d+,\s+\d+:\d+\s+(AM|PM)\s+KRIVIČNI ZAKONIK.*?/\d+",
        "",
        text,
    )
    return text


def slice_articles(full_text: str) -> dict[str, str]:
    """Build {article_key -> text_slice} where key is e.g. '416' or '421a'."""
    pattern = re.compile(r"Član\s+(\d+[a-zA-Z]?)\b")
    matches = list(pattern.finditer(full_text))
    out: dict[str, str] = {}
    for i, m in enumerate(matches):
        key = m.group(1).lower()
        start = m.start()
        end = matches[i + 1].start() if i + 1 < len(matches) else len(full_text)
        slice_text = full_text[start:end].strip()
        # Stop at next chapter marker if any
        chap = re.search(r"\bGLAVA\s+[A-ZČĆŠĐŽ]+", slice_text)
        if chap and chap.start() > 20:
            slice_text = slice_text[: chap.start()].strip()
        # Prefer first occurrence (PDF has "Član N" repeated in ToC sometimes);
        # keep the longest candidate as the real article body
        if key not in out or len(slice_text) > len(out[key]):
            out[key] = slice_text
    return out


PROMPT_HEADER = (
    "Ti si stručnjak za pravnu informatiku. Konvertuješ tekst pojedinačnih "
    "članova Krivičnog zakonika Crne Gore u Akoma Ntoso 3.0 XML fragmente.\n\n"
    "Pravila:\n"
    "- Vrati ISKLJUČIVO niz <article>…</article> elemenata, bez <akomaNtoso>, "
    "<act>, <body>, <chapter>, i bez XML deklaracije, bez markdown fence-ova.\n"
    "- Svaki član ima eId='art_NNN' (npr. art_49, art_133, art_421a), "
    "<num>Član NNN</num>, <heading>…</heading>.\n"
    "- Stavovi koriste <paragraph eId='art_NNN_para_K'> sa <num>(K)</num> i "
    "<content><p>…</p></content>.\n"
    "- Članovi bez numerisanih stavova koriste <content><p>…</p></content> direktno.\n"
    "- Brisani članovi: <content><p>(brisano)</p></content>.\n\n"
    "Inline anotacije (OBAVEZNO):\n"
    "- Svaku referencu na član ili stav istog zakonika obuči u "
    "<ref href='#art_NNN'> ili <ref href='#art_NNN_para_K'>. "
    "Primjer: 'iz stava 1 ovog člana' -> <ref href='#art_XXX_para_1'>stava 1 ovog člana</ref> "
    "(gdje je XXX broj tekućeg člana); "
    "'iz člana 49 ovog zakonika' -> <ref href='#art_49'>člana 49</ref>.\n"
    "- Reference na druge zakone: puni FRBR path, "
    "npr. <ref href='/me/acts/2009/zakonik-o-krivicnom-postupku#art_362'>čl. 362 ZKP</ref>.\n"
    "- Datume obuči u <date date='YYYY-MM-DD'>…</date>.\n"
    "- Prava vlastita imena organizacija u <organization refersTo='#parliament'>…</organization>. "
    "Generičke termine (službeno lice, sud, državni organ) NE obmotavaj.\n\n"
    "Ulaz (više članova, odvojenih praznom linijom):\n\n"
)


def build_batch_prompt(batch: list[tuple[str, str]]) -> str:
    body = "\n\n".join(txt for _, txt in batch)
    return PROMPT_HEADER + body


def call_claude(prompt: str) -> str:
    result = subprocess.run(
        ["claude", "--print", "--output-format", "text"],
        input=prompt,
        capture_output=True,
        text=True,
        encoding="utf-8",
    )
    if result.returncode != 0:
        raise RuntimeError(f"Claude CLI failed: {result.stderr}")
    out = result.stdout.strip()
    out = re.sub(r"^```xml\s*", "", out)
    out = re.sub(r"^```\s*", "", out)
    out = re.sub(r"\s*```$", "", out)
    return out.strip()


def process_batch(batch_idx: int, batch: list[tuple[str, str]], resume: bool) -> tuple[int, str]:
    cache_file = CACHE_DIR / f"batch_{batch_idx:02d}.xml"
    if resume and cache_file.exists() and cache_file.stat().st_size > 0:
        print(f"[batch {batch_idx:02d}] cached")
        return batch_idx, cache_file.read_text(encoding="utf-8")
    print(f"[batch {batch_idx:02d}] sending {len(batch)} articles: "
          f"{[k for k, _ in batch]}")
    prompt = build_batch_prompt(batch)
    xml = call_claude(prompt)
    cache_file.parent.mkdir(parents=True, exist_ok=True)
    cache_file.write_text(xml, encoding="utf-8")
    print(f"[batch {batch_idx:02d}] done ({len(xml)} chars)")
    return batch_idx, xml


def extract_chapter_34_body() -> str:
    """Pull just the inner chapter element from the existing chapter 34 file."""
    xml = CHAPTER_34_XML.read_text(encoding="utf-8")
    m = re.search(r"<chapter\b[^>]*>.*?</chapter>", xml, re.DOTALL)
    if not m:
        raise RuntimeError("could not locate <chapter> in existing chapter 34 XML")
    return m.group(0)


OUTER_TEMPLATE = """<?xml version="1.0" encoding="UTF-8"?>
<akomaNtoso xmlns="http://docs.oasis-open.org/legaldocml/ns/akn/3.0/WD17">
  <act name="act" contains="originalVersion">
    <meta>
      <identification source="#decorruptify">
        <FRBRWork>
          <FRBRthis value="/me/acts/2003/krivicni-zakonik/!main"/>
          <FRBRuri value="/me/acts/2003/krivicni-zakonik"/>
          <FRBRalias value="Krivični zakonik Crne Gore"/>
          <FRBRdate date="2003-11-28" name="Generation"/>
          <FRBRauthor href="#parliament"/>
          <FRBRcountry value="me"/>
        </FRBRWork>
        <FRBRExpression>
          <FRBRthis value="/me/acts/2003/krivicni-zakonik/!main/sr@"/>
          <FRBRuri value="/me/acts/2003/krivicni-zakonik/sr@"/>
          <FRBRdate date="2003-11-28" name="Generation"/>
          <FRBRauthor href="#parliament"/>
          <FRBRlanguage language="sr"/>
        </FRBRExpression>
        <FRBRManifestation>
          <FRBRthis value="/me/acts/2003/krivicni-zakonik/!main/sr@.xml"/>
          <FRBRuri value="/me/acts/2003/krivicni-zakonik/sr@.xml"/>
          <FRBRdate date="2026-04-19" name="Generation"/>
          <FRBRauthor href="#decorruptify"/>
        </FRBRManifestation>
      </identification>
      <references source="#decorruptify">
        <TLCOrganization eId="parliament" href="/ontology/organization/me/skupstina" showAs="Skupština Crne Gore"/>
        <TLCOrganization eId="decorruptify" href="/ontology/organization/decorruptify" showAs="decorruptify"/>
      </references>
    </meta>
    <body>
{chapter_34}
      <part eId="part_referenced">
        <num>Dio</num>
        <heading>Ostali članovi referencirani iz presuda</heading>
{referenced_articles}
      </part>
    </body>
  </act>
</akomaNtoso>
"""


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("-w", "--workers", type=int, default=3)
    ap.add_argument("--resume", action="store_true")
    args = ap.parse_args()

    print(f"Extracting PDF text from {PDF_PATH}…")
    full_text = extract_full_text(PDF_PATH)
    print(f"Total chars: {len(full_text)}")

    articles = slice_articles(full_text)
    print(f"Indexed {len(articles)} article headers from PDF")

    targets: list[tuple[str, str]] = []
    missing: list[int] = []
    for n in REFERENCED_ARTICLES:
        key = str(n)
        if key in articles:
            targets.append((key, articles[key]))
        else:
            missing.append(n)
    if missing:
        print(f"WARNING: {len(missing)} referenced articles not found in PDF: {missing}")
    print(f"Will annotate {len(targets)} articles")

    batches = [targets[i:i + BATCH_SIZE] for i in range(0, len(targets), BATCH_SIZE)]
    print(f"Split into {len(batches)} batches of up to {BATCH_SIZE}")

    CACHE_DIR.mkdir(parents=True, exist_ok=True)

    results: dict[int, str] = {}
    with ThreadPoolExecutor(max_workers=args.workers) as ex:
        futures = {
            ex.submit(process_batch, i, b, args.resume): i
            for i, b in enumerate(batches, start=1)
        }
        for fut in as_completed(futures):
            i = futures[fut]
            try:
                idx, xml = fut.result()
                results[idx] = xml
            except Exception as e:
                print(f"[batch {i:02d}] FAILED: {e}")
                results[i] = f"<!-- batch {i} failed: {e} -->"

    ordered = "\n".join(results[i] for i in sorted(results))
    # Indent referenced articles block slightly
    indented_refs = "\n".join("        " + ln if ln.strip() else ln
                              for ln in ordered.splitlines())
    chapter_34 = extract_chapter_34_body()
    indented_ch = "\n".join("      " + ln if ln.strip() else ln
                            for ln in chapter_34.splitlines())

    out = OUTER_TEMPLATE.format(
        chapter_34=indented_ch,
        referenced_articles=indented_refs,
    )
    OUTPUT_FILE.write_text(out, encoding="utf-8")
    print(f"Saved merged law XML to {OUTPUT_FILE} ({len(out)} chars)")


if __name__ == "__main__":
    main()

"""
law_to_akoma_ntoso.py — Convert Criminal Code articles to Akoma Ntoso 3.0 XML.

Pipeline:
  1. Extract text of Chapter 34 (Articles 416–425) from the Criminal Code PDF
     using PyPDF2 (search pages for "GLAVA TRIDESET ČETVRTA")
  2. Send the extracted text to Claude (via Claude Code CLI) with a structured
     prompt and Akoma Ntoso formatting rules
  3. Claude returns valid Akoma Ntoso 3.0 XML with proper <act>, <chapter>,
     <article>, <paragraph> hierarchy
  4. Save to legal-texts/akoma-ntoso/

Source: Criminal Code of Montenegro ("Krivični zakonik Crne Gore"),
        Službeni list RCG 70/2003, as amended.
        PDF located at data/laws/krivicni_zakonik.pdf (public legal document).

Usage:
  python law_to_akoma_ntoso.py                          # full pipeline
  python law_to_akoma_ntoso.py -i chapter_text.txt      # skip PDF extraction
  python law_to_akoma_ntoso.py --extract-only            # only extract text from PDF
"""

import argparse
import re
import subprocess
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parent.parent
PDF_PATH = PROJECT_ROOT / "data" / "laws" / "krivicni_zakonik.pdf"
OUTPUT_DIR = PROJECT_ROOT / "legal-texts" / "akoma-ntoso"


def extract_chapter_34_from_pdf(pdf_path: Path) -> str:
    """Extract Chapter 34 text (Articles 416–425) from the Criminal Code PDF."""
    import PyPDF2

    reader = PyPDF2.PdfReader(str(pdf_path))
    full_text = ""
    for page in reader.pages:
        full_text += (page.extract_text() or "") + "\n"

    start = full_text.find("GLAVA TRIDESET ČETVRTA")
    if start == -1:
        raise ValueError("Chapter 34 not found in PDF")

    end = full_text.find("GLAVA TRIDESET PETA", start)
    if end == -1:
        end = full_text.find("Član 426", start)
    if end == -1:
        end = len(full_text)

    chapter_text = full_text[start:end].strip()

    chapter_text = re.sub(
        r"\d+/\d+/\d+,\s+\d+:\d+\s+(AM|PM)\s+KRIVIČNI ZAKONIK.*?/\d+",
        "",
        chapter_text,
    )

    return chapter_text


AKOMA_NTOSO_EXAMPLE = """\
<article eId="art_1">
  <num>Član 1</num>
  <heading>Naziv člana</heading>
  <paragraph eId="art_1_para_1">
    <num>(1)</num>
    <content><p>Tekst prvog stava.</p></content>
  </paragraph>
  <paragraph eId="art_1_para_2">
    <num>(2)</num>
    <content><p>Ako je usled djela iz <ref href="#art_1_para_1">stava 1 ovog člana</ref> pribavljena imovinska korist, učinilac će se kazniti.</p></content>
  </paragraph>
  <paragraph eId="art_1_para_3">
    <num>(3)</num>
    <content><p>Učinilac djela iz <ref href="#art_1_para_1">st. 1</ref> i <ref href="#art_1_para_2">2 ovog člana</ref> kazniće se zatvorom, a na osnovu <ref href="/me/acts/2009/zakonik-o-krivicnom-postupku#art_362">čl. 362 ZKP</ref>.</p></content>
  </paragraph>
</article>
<article eId="art_2">
  <num>Član 2</num>
  <heading>Član bez stavova</heading>
  <content><p>Odredbe ovog člana primjenjuje <organization refersTo="#parliament">Skupština Crne Gore</organization>, počev od <date date="2003-11-28">28. novembra 2003. godine</date>.</p></content>
</article>"""


def convert_to_akoma_ntoso(chapter_text: str) -> str:
    """Use Claude (via Claude Code CLI) to convert extracted chapter text to Akoma Ntoso 3.0 XML."""
    prompt = (
        "Ti si stručnjak za pravnu informatiku. Konvertuješ tekst zakona u "
        "Akoma Ntoso 3.0 XML format.\n\n"
        "Pravila:\n"
        "- Koristi namespace: http://docs.oasis-open.org/legaldocml/ns/akn/3.0/WD17\n"
        "- Struktura: <akomaNtoso><act><meta>...</meta><body><chapter><article>...\n"
        "- Svaki član (article) ima eId='art_NNN', <num>Član NNN</num>, <heading>\n"
        "- Stavovi koriste <paragraph> sa eId='art_NNN_para_N'\n"
        "- Članovi bez stavova koriste <content><p> direktno\n"
        "- Za članove sa oznakom 'a' (npr. 421a), koristi eId='art_421a'\n"
        "- Brisani članovi se označavaju sa <content><p>(brisano)</p></content>\n"
        "- Meta sekcija treba sadržati FRBRWork sa country='me', publication info, "
        "i references\n"
        "\n"
        "Inline anotacije unutar teksta članova (OBAVEZNO):\n"
        "- Svaku referencu na član ili stav ISTOG zakona obuči u "
        "<ref href='#art_NNN' > ili <ref href='#art_NNN_para_K'>. "
        "Primjeri: 'iz stava 1 ovog člana' -> <ref href='#art_XXX_para_1'>stava 1 ovog člana</ref> "
        "(gdje je XXX broj tekućeg člana); 'djela iz st. 1 i 2 ovog člana' -> "
        "<ref href='#art_XXX_para_1'>st. 1</ref> i <ref href='#art_XXX_para_2'>2 ovog člana</ref>; "
        "'iz člana 422 ovog zakonika' -> <ref href='#art_422'>člana 422</ref>. "
        "NIKAD ne ispuštaj ove reference — svako pominjanje stava ili člana mora biti anotirano.\n"
        "- Reference na DRUGE zakone koristi puni FRBR path, npr. "
        "<ref href='/me/acts/2009/zakonik-o-krivicnom-postupku#art_362'>čl. 362 ZKP</ref>.\n"
        "- Datume u tekstu obuči u <date date='YYYY-MM-DD'>...</date>.\n"
        "- Imena vlasti/organa (npr. 'Skupština Crne Gore') obuči u "
        "<organization refersTo='#parliament'>...</organization>. "
        "NE obmotavaj generičke termine poput 'službeno lice', 'državni organ', 'sud' — "
        "samo prava vlastita imena organizacija.\n"
        "- eId za ref NE mijenjaj — moraju odgovarati eId vrijednostima članova/stavova "
        "(art_416, art_416_para_1, art_421a, art_421a_para_2, itd).\n\n"
        f"Primjer strukture članova:\n\n{AKOMA_NTOSO_EXAMPLE}\n\n"
        "Vrati isključivo validan XML dokument, ništa drugo.\n\n"
        "Konvertuj sljedeći tekst Glave 34 Krivičnog zakonika Crne Gore u "
        f"Akoma Ntoso 3.0 XML:\n\n{chapter_text}"
    )

    result = subprocess.run(
        ["claude", "--print", "--output-format", "text"],
        input=prompt,
        capture_output=True,
        text=True,
        encoding="utf-8",
    )

    if result.returncode != 0:
        raise RuntimeError(f"Claude CLI failed: {result.stderr}")

    xml_content = result.stdout.strip()
    # Strip markdown code fences if present
    xml_content = re.sub(r"^```xml\s*", "", xml_content)
    xml_content = re.sub(r"^```\s*", "", xml_content)
    xml_content = re.sub(r"\s*```$", "", xml_content)

    return xml_content.strip()


def main():
    parser = argparse.ArgumentParser(
        description="Convert Criminal Code Chapter 34 to Akoma Ntoso XML"
    )
    parser.add_argument(
        "-i", "--input",
        help="Path to pre-extracted chapter text file (skips PDF extraction)",
    )
    parser.add_argument(
        "--extract-only",
        action="store_true",
        help="Only extract text from PDF, don't convert to XML",
    )
    parser.add_argument(
        "-o", "--output",
        default=str(OUTPUT_DIR / "glava_34_krivicna_djela_protiv_sluzbene_duznosti.xml"),
        help="Output XML file path",
    )
    args = parser.parse_args()

    # Step 1: Get the chapter text
    if args.input:
        chapter_text = Path(args.input).read_text(encoding="utf-8")
        print(f"Loaded chapter text from {args.input}")
    else:
        print(f"Extracting Chapter 34 from {PDF_PATH}...")
        chapter_text = extract_chapter_34_from_pdf(PDF_PATH)
        print(f"Extracted {len(chapter_text)} characters")

    if args.extract_only:
        out_path = Path(args.output).with_suffix(".txt")
        out_path.write_text(chapter_text, encoding="utf-8")
        print(f"Saved extracted text to {out_path}")
        return

    # Step 2: Convert to Akoma Ntoso via LLM
    print("Converting to Akoma Ntoso XML via Claude...")
    xml_content = convert_to_akoma_ntoso(chapter_text)

    # Step 3: Save
    output_path = Path(args.output)
    output_path.parent.mkdir(parents=True, exist_ok=True)
    output_path.write_text(xml_content, encoding="utf-8")
    print(f"Saved Akoma Ntoso XML to {output_path}")


if __name__ == "__main__":
    main()
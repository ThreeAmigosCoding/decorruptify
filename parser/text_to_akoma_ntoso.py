import pathlib
import re
import subprocess
import argparse
from concurrent.futures import ThreadPoolExecutor, as_completed

# Minimal inline example of an Akoma Ntoso 3.0 judgment document.
EXAMPLE_JUDGMENT = """<?xml version="1.0" encoding="UTF-8"?>
<akomaNtoso xmlns="http://docs.oasis-open.org/legaldocml/ns/akn/3.0">
  <judgment name="presuda">
    <meta>
      <identification source="#source">
        <FRBRWork>
          <FRBRthis value="/me/cgvs/2016-01-12/Kr-S.1-2016/main"/>
          <FRBRuri value="/me/cgvs/2016-01-12/Kr-S.1-2016"/>
          <FRBRdate date="2016-01-12" name="decision"/>
          <FRBRauthor href="#court"/>
          <FRBRcountry value="me"/>
        </FRBRWork>
        <FRBRExpression>
          <FRBRthis value="/me/cgvs/2016-01-12/Kr-S.1-2016/srp@/main"/>
          <FRBRuri value="/me/cgvs/2016-01-12/Kr-S.1-2016/srp@"/>
          <FRBRdate date="2016-01-12" name="decision"/>
          <FRBRauthor href="#court"/>
          <FRBRlanguage language="srp"/>
        </FRBRExpression>
        <FRBRManifestation>
          <FRBRthis value="/me/cgvs/2016-01-12/Kr-S.1-2016/srp@/main.xml"/>
          <FRBRuri value="/me/cgvs/2016-01-12/Kr-S.1-2016/srp@/.xml"/>
          <FRBRdate date="2016-01-12" name="decision"/>
          <FRBRauthor href="#court"/>
        </FRBRManifestation>
      </identification>
      <references source="#source">
        <TLCOrganization eId="court" href="/ontology/organization/me/VrhovniSudCrneGore" showAs="Vrhovni sud Crne Gore"/>
        <TLCPerson eId="judge1" href="/ontology/person/me/PetarStojanovic" showAs="Petar Stojanović"/>
      </references>
    </meta>
    <header>
      <courtType>Vrhovni sud Crne Gore</courtType>
      <docketNumber>Kr-S.br.1/16</docketNumber>
      <neutralCitation>Kr-S.br.1/16</neutralCitation>
      <docDate date="2016-01-12">12.01.2016.godine</docDate>
      <judge refersTo="#judge1">Petar Stojanović</judge>
    </header>
    <judgmentBody>
      <introduction>
        <p>VRHOVNI SUD CRNE GORE, u vijeću sastavljenom od sudija...</p>
      </introduction>
      <background>
        <p>Okrivljeni D.M. se sumnjiči za izvršenje krivičnog djela...</p>
      </background>
      <decision>
        <p>Pritvor se produžava za još jedan mjesec.</p>
      </decision>
      <conclusions>
        <p>Na osnovu
          <ref href="/me/acts/2003/krivicni-zakonik#art_416">
            čl. 416 Krivičnog zakonika Crne Gore
          </ref>
          sud donosi ovo rješenje.
        </p>
      </conclusions>
    </judgmentBody>
  </judgment>
</akomaNtoso>"""


def strip_css_artifacts(text: str) -> str:
    """Remove CSS/HTML styling artifacts that appear at the top of scraped texts."""
    lines = text.splitlines()
    for i, line in enumerate(lines):
        if re.match(r'Kr-S\.br\.|Kr\.br\.|Ks?\.\s*br\.|Ksž\s*\.?\s*br\.|Kž|K\.br\.|VRHOVNI SUD|Vrhovni sud|VIŠI SUD|Viši sud|APELACIONI SUD|Apelacioni sud|U IME NARODA', line.strip()):
            return '\n'.join(lines[i:])
    return text


def process_text(text: str, file_path: pathlib.Path) -> None:
    output_path = pathlib.Path(f"../judgements/akoma-ntoso/{file_path.stem}.xml")
    if output_path.exists():
        print(f"Skipping {file_path.stem} (already exists)")
        return

    clean_text = strip_css_artifacts(text)

    prompt = (
        "Ti konvertuješ tekstove sudskih presuda u Akoma Ntoso 3.0 XML dokumente. "
        "Ovi predmeti se odnose na krivična djela protiv službene dužnosti iz Krivičnog zakonika Crne Gore "
        "(član 416–425: zloupotreba službenog položaja, kršenje zakona od strane sudije, "
        "protivzakonita naplata i isplata, prevara u službi, nesavjestan rad u službi, "
        "protivzakoniti uticaj, primanje mita, davanje mita).\n\n"
        f"PRIMJER Akoma Ntoso 3.0 dokumenta:\n{EXAMPLE_JUDGMENT}\n\n"
        "Pravila:\n"
        "- Vrati SAMO validan XML dokument, bez ikakvog dodatnog teksta ili markdown oznaka.\n"
        "- Koristi namespace: xmlns=\"http://docs.oasis-open.org/legaldocml/ns/akn/3.0\"\n"
        "- Koristi <ref href=\"/me/acts/2003/krivicni-zakonik#art_NNN\"> kad se pominju članovi zakona.\n"
        "- Popuni meta/identification sa tačnim podacima iz dokumenta (sud, datum, broj predmeta).\n"
        "- Struktura: header (sud, broj, datum, sudije), judgmentBody (introduction, background, decision, conclusions).\n\n"
        f"TEKST PRESUDE:\n{clean_text}"
    )

    print(f"Processing {file_path.name}...")
    result = subprocess.run(
        ["claude", "--print", "--output-format", "text"],
        input=prompt,
        capture_output=True,
        text=True,
    )

    if result.returncode != 0:
        print(f"Error processing {file_path.name}: {result.stderr}")
        return

    content = result.stdout.strip()
    content = re.sub(r'^```xml\s*', '', content)
    content = re.sub(r'^```\s*', '', content)
    content = re.sub(r'\s*```$', '', content)

    output_path.parent.mkdir(parents=True, exist_ok=True)
    output_path.write_text(content, encoding="utf-8")
    print(f"Saved → {output_path}")


def _process_file(text_file: pathlib.Path) -> None:
    """Wrapper for ThreadPoolExecutor — reads the file and calls process_text."""
    process_text(text_file.read_text(encoding="utf-8"), text_file)


def main():
    parser = argparse.ArgumentParser(description="Convert judgment texts to Akoma Ntoso 3.0 XML")
    parser.add_argument("-i", help="Input file (omit to process all files in ../judgements/text/)")
    parser.add_argument("-w", "--workers", type=int, default=5,
                        help="Number of parallel workers (default: 5)")
    args = parser.parse_args()

    if args.i:
        file_path = pathlib.Path(args.i)
        process_text(file_path.read_text(encoding="utf-8"), file_path)
    else:
        text_files = sorted(pathlib.Path("../judgements/text").rglob("*.txt"))
        print(f"Found {len(text_files)} text files. Using {args.workers} workers.")
        with ThreadPoolExecutor(max_workers=args.workers) as executor:
            futures = {executor.submit(_process_file, tf): tf for tf in text_files}
            for future in as_completed(futures):
                exc = future.exception()
                if exc:
                    print(f"Error on {futures[future].name}: {exc}")


if __name__ == "__main__":
    main()

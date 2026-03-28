import subprocess
from pathlib import Path
import argparse
from concurrent.futures import ThreadPoolExecutor, as_completed

# Load all Java model classes so the LLM knows the exact field names and types
java_models_dir = Path("../backend/src/main/java/com/decorruptify/backend/model/")
models_string = ""
for model_path in java_models_dir.rglob("*.java"):
    models_string += model_path.read_text(encoding="utf-8")
    models_string += "\n"


def process_file(text: str, file_path: Path) -> None:
    output_path = Path(f"../judgements/metadata/{file_path.stem}.csv")
    if output_path.exists():
        print(f"Skipping {file_path.stem} (already in cache)")
        return

    prompt = (
        "Ti analiziraš sudske presude u Akoma Ntoso 3.0 XML formatu koje se odnose na krivična djela "
        "protiv službene dužnosti (korupcija, mito, zloupotreba položaja – članovi 416–425 Krivičnog zakonika Crne Gore). "
        "Zadatak ti je da izvučeš strukturirane metapodatke i vratiš validan CSV red.\n\n"
        f"JAVA MODELI (koristi nazive polja i redosljed striktno):\n{models_string}\n\n"
        "Pravila:\n"
        "- Vrati SAMO jedan CSV red (bez zaglavlja), vrijednosti odvojene zarezom.\n"
        "- Redosljed kolona: court, verdictNumber, date (ISO 8601: YYYY-MM-DD), judgeName, prosecutor, "
        "defendantName, criminalOffense, appliedProvisions (tačke-zarez odvojene ako ih ima više), "
        "verdict (PRISON/SUSPENDED/ACQUITTED/FINE), officialPosition, "
        "abuseOfAuthority (true/false), organizedGroup (true/false), "
        "materialGain (decimalni broj ili prazan), materialDamage (decimalni broj ili prazan), "
        "briberyAmount (decimalni broj ili prazan), previouslyConvicted (true/false), "
        "numDefendants (cijeli broj), voluntaryDisclosure (true/false), "
        "damageToPublicInterest (true/false), sentenceMonths (cijeli broj ili prazan).\n"
        "- Ako podatak nije dostupan u dokumentu, ostavi prazno polje.\n"
        "- Ne koristi navodnike osim ako vrijednost sadrži zarez.\n"
        "- Ne vraćaj nikakav tekst izvan CSV reda, bez markdown oznaka.\n\n"
        f"AKOMA NTOSO XML DOKUMENT:\n{text}"
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
    content = content.replace("```csv", "").replace("```", "").strip()

    output_path.parent.mkdir(parents=True, exist_ok=True)
    output_path.write_text(content, encoding="utf-8")
    print(f"Saved → {output_path}")


def _process_xml(xml_file: Path) -> None:
    """Wrapper for ThreadPoolExecutor."""
    process_file(xml_file.read_text(encoding="utf-8"), xml_file)


def main():
    parser = argparse.ArgumentParser(
        description="Extract metadata from Akoma Ntoso judgment XMLs into CSV"
    )
    parser.add_argument(
        "-i",
        help="Input file or directory (omit to process all XMLs in ../judgements/akoma-ntoso/)",
        type=Path,
    )
    parser.add_argument(
        "-w", "--workers", type=int, default=5,
        help="Number of parallel workers (default: 5)",
    )
    args = parser.parse_args()

    input_path: Path = args.i if args.i else Path("../judgements/akoma-ntoso/")

    if input_path.is_file():
        process_file(input_path.read_text(encoding="utf-8"), input_path)
    else:
        xml_files = sorted(input_path.rglob("*.xml"))
        print(f"Found {len(xml_files)} XML files. Using {args.workers} workers.")
        with ThreadPoolExecutor(max_workers=args.workers) as executor:
            futures = {executor.submit(_process_xml, xf): xf for xf in xml_files}
            for future in as_completed(futures):
                exc = future.exception()
                if exc:
                    print(f"Error on {futures[future].name}: {exc}")


if __name__ == "__main__":
    main()

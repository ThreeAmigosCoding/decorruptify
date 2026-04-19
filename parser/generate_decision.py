#!/usr/bin/env python3
"""
generate_decision.py — Generates a draft court decision as Akoma Ntoso 3.0 XML.

Reads JSON from stdin:
  {
    "verdictId": 42,
    "verdict": { ...all Verdict fields... },
    "similarCases": [ { "verdictNumber": ..., "court": ..., ... }, ... ],
    "ruleOutput": "Okrivljeni je počinio ...",
    "outputDir": "/abs/path/to/judgements/akoma-ntoso/generated"
  }

Writes XML to outputDir/{verdictId}.xml and prints XML to stdout.
Prints error to stderr and exits 1 on failure.
"""
import json
import pathlib
import re
import subprocess
import sys

# Reuse EXAMPLE_JUDGMENT constant from text_to_akoma_ntoso.py (same directory)
sys.path.insert(0, str(pathlib.Path(__file__).parent))
from text_to_akoma_ntoso import EXAMPLE_JUDGMENT

STYLE_SAMPLES_DIR = pathlib.Path(__file__).parent.parent / "judgements" / "text"
STYLE_SAMPLE_FILES = ["K-S_10-2010_art416.txt", "K-S_27-2010_art423.txt"]


def load_style_samples() -> str:
    samples = []
    for fname in STYLE_SAMPLE_FILES:
        p = STYLE_SAMPLES_DIR / fname
        if p.exists():
            lines = p.read_text(encoding="utf-8").splitlines()[:80]
            samples.append(f"--- {fname} ---\n" + "\n".join(lines))
    return "\n\n".join(samples)


def format_verdict_context(data: dict) -> str:
    v = data["verdict"]
    similar = data.get("similarCases", [])
    rule = data.get("ruleOutput", "")

    lines = [
        f"Sud: {v.get('court', '')}",
        f"Broj predmeta: {v.get('verdictNumber', '')}",
        f"Datum: {v.get('date', '')}",
        f"Sudija: {v.get('judgeName', '')}",
        f"Tužilac: {v.get('prosecutor', '')}",
        f"Okrivljeni: {v.get('defendantName', '')}",
        f"Krivično djelo: {v.get('criminalOffense', '')}",
        f"Službena pozicija: {v.get('officialPosition', '') or 'nije navedena'}",
        f"Vrsta presude: {v.get('verdict', '')}",
        f"Kazna (u mjesecima): {v.get('sentenceMonths', 'nije primjenljivo')}",
        f"Primjenjene odredbe: {', '.join(v.get('appliedProvisions') or [])}",
        "",
        "Okolnosti krivičnog djela:",
        f"  Zloupotreba službenog položaja: {v.get('abuseOfAuthority', False)}",
        f"  Organizovana kriminalna grupa: {v.get('organizedGroup', False)}",
        f"  Ranije osuđivan: {v.get('previouslyConvicted', False)}",
        f"  Dobrovoljno prijavljivanje: {v.get('voluntaryDisclosure', False)}",
        f"  Šteta javnom interesu: {v.get('damageToPublicInterest', False)}",
        f"  Pronevjera: {v.get('embezzlement', False)}",
        f"  Trgovina uticajem: {v.get('tradingInfluence', False)}",
        f"  Primanje mita: {v.get('bribeReceiver', False)}",
        f"  Imovinska korist: {v.get('materialGain') or 0} EUR",
        f"  Materijalna šteta: {v.get('materialDamage') or 0} EUR",
        f"  Iznos mita: {v.get('briberyAmount') or 0} EUR",
        f"  Broj okrivljenih: {v.get('numDefendants', 1)}",
    ]

    if similar:
        lines.append("\nSlični predmeti (CBR sistem):")
        for s in similar[:3]:
            lines.append(
                f"  - {s.get('verdictNumber', '')} ({s.get('court', '')}) — "
                f"{s.get('verdict', '')} — {s.get('sentenceMonths', '')} mj — "
                f"sličnost {s.get('similarity', 0) * 100:.1f}%"
            )

    if rule:
        lines.append(f"\nPreporuka sistema zasnovana na pravilima (DR-DEVICE): {rule}")

    return "\n".join(lines)


def build_prompt(data: dict, style_samples: str) -> str:
    verdict_context = format_verdict_context(data)
    return (
        "Ti si sistem za generisanje nacrta sudskih presuda crnogorskih sudova za krivična "
        "djela protiv službene dužnosti (korupcija, čl. 416–425 Krivičnog zakonika Crne Gore).\n\n"
        f"PRIMJER Akoma Ntoso 3.0 dokumenta:\n{EXAMPLE_JUDGMENT}\n\n"
        f"STILSKI UZORCI (stvarne presude crnogorskih sudova — koristi ovaj stil pisanja):\n{style_samples}\n\n"
        f"PODACI O PREDMETU:\n{verdict_context}\n\n"
        "ZADATAK:\n"
        "Na osnovu gore navedenih podataka o predmetu i stilskih uzoraka, generiši nacrt sudske "
        "presude kao validan Akoma Ntoso 3.0 XML dokument na srpskom jeziku.\n\n"
        "Pravila:\n"
        "- Vrati SAMO validan XML dokument, bez ikakvog dodatnog teksta ili markdown oznaka.\n"
        "- Koristi namespace: xmlns=\"http://docs.oasis-open.org/legaldocml/ns/akn/3.0\"\n"
        "- Koristi <ref href=\"/me/acts/2003/krivicni-zakonik#art_NNN\"> za sve pomene članova zakona.\n"
        "- Popuni meta/identification sa tačnim podacima predmeta (sud, datum, broj predmeta).\n"
        "- Struktura: header (sud, broj, datum, sudija) + judgmentBody (introduction, background, decision, conclusions).\n"
        "- Prati jezik i ton stvarnih presuda iz stilskih uzoraka.\n"
        "- U decision sekciji jasno navedi vrstu presude i kaznu.\n"
        "- Navedi 'NACRT PRESUDE' u zaglavlju dokumenta.\n"
    )


def main():
    raw = sys.stdin.read()
    data = json.loads(raw)

    verdict_id = data["verdictId"]
    output_dir = pathlib.Path(data["outputDir"])
    output_dir.mkdir(parents=True, exist_ok=True)
    output_path = output_dir / f"{verdict_id}.xml"

    style_samples = load_style_samples()
    prompt = build_prompt(data, style_samples)

    result = subprocess.run(
        ["claude", "--print", "--output-format", "text"],
        input=prompt,
        capture_output=True,
        text=True,
    )

    if result.returncode != 0:
        print(f"Claude CLI error: {result.stderr}", file=sys.stderr)
        sys.exit(1)

    content = result.stdout.strip()
    content = re.sub(r'^```xml\s*', '', content)
    content = re.sub(r'^```\s*', '', content)
    content = re.sub(r'\s*```$', '', content)

    output_path.write_text(content, encoding="utf-8")
    print(content)


if __name__ == "__main__":
    main()

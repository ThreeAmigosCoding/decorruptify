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
        f"STILSKI UZORCI (stvarne presude — koristi ovaj stil i jezički registar):\n{style_samples}\n\n"
        f"PODACI O PREDMETU:\n{verdict_context}\n\n"
        "ZADATAK: Generiši nacrt presude kao validan Akoma Ntoso 3.0 XML na srpskom jeziku.\n\n"
        "KRITIČNA PRAVILA — OBAVEZNO POŠTOVATI:\n"
        "1. ZABRANJENA IZMIŠLJOTINA: Strogo je zabranjeno izmišljati bilo šta što nije eksplicitno "
        "navedeno u podacima o predmetu. Ne smije se izmišljati: iskazi optuženog, svjedočenja svjedoka, "
        "detalji toka događaja, datumi konkretnih radnji, iznosi koji nisu navedeni, "
        "imena koja nisu navedena, ili bilo kakva narativna priča.\n"
        "2. SAMO IZ PODATAKA: Svaka rečenica mora biti direktno izvedena iz strukturiranih podataka "
        "(gore navedenih). Ako određeni podatak ne postoji, taj dio se izostavlja ili se formuliše "
        "kao opšta pravna konstatacija (npr. 'Sud je utvrdio da su ispunjeni zakonski uslovi...').\n"
        "3. FAKTIČKI OPIS: U sekcijama introduction i background navesti samo ono što je poznato "
        "iz podataka — sud, broj predmeta, optuženi, krivično djelo, primjenjene odredbe, "
        "i okolnosti koje su označene kao tačne (True). Ne navoditi okolnosti označene kao False.\n"
        "4. ODLUKA I KAZNA: U sekciji decision jasno navesti vrstu presude i kaznu iz podataka, "
        "pozivajući se na primjenjene zakonske odredbe.\n"
        "5. PRAVNE ODREDBE: Sve pomene članova zakona formatirati kao "
        "<ref href=\"/me/acts/2003/krivicni-zakonik#art_NNN\">čl. NNN KZ CG</ref>.\n\n"
        "TEHNIČKE SPECIFIKACIJE:\n"
        "- Vrati SAMO validan XML, bez markdown oznaka ili bilo kakvog teksta van XML-a.\n"
        "- Namespace: xmlns=\"http://docs.oasis-open.org/legaldocml/ns/akn/3.0\"\n"
        "- Popuni meta/identification sa podacima predmeta (sud, datum, broj).\n"
        "- Struktura: header + judgmentBody (introduction, background, decision, conclusions).\n"
        "- Navedi 'NACRT PRESUDE' u header sekciji.\n"
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

    try:
        result = subprocess.run(
            ["claude", "--print", "--output-format", "text"],
            input=prompt,
            capture_output=True,
            text=True,
            timeout=300,  # 5 minutes
        )
    except subprocess.TimeoutExpired:
        print("Claude CLI timed out after 300 seconds", file=sys.stderr)
        sys.exit(1)

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

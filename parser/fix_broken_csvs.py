"""
Fix CSV files that have wrong column counts:
- 19-column files: missing previouslyConvicted at index 15 -> insert empty value
- 24-column files: had extra empty column at index 16 + incorrectly placed migration columns
  -> remove migration cols, remove extra col, re-migrate

After fixing, all files should have exactly 23 columns matching VerdictDataLoader.COLUMNS:
  court(0), verdictNumber(1), date(2), judgeName(3), prosecutor(4),
  defendantName(5), criminalOffense(6), appliedProvisions(7), verdict(8),
  officialPosition(9), abuseOfAuthority(10), organizedGroup(11), materialGain(12),
  materialDamage(13), briberyAmount(14), previouslyConvicted(15), numDefendants(16),
  voluntaryDisclosure(17), damageToPublicInterest(18),
  embezzlement(19), tradingInfluence(20), bribeReceiver(21), sentenceMonths(22)

Usage:
    python fix_broken_csvs.py
"""

import csv
import os
import sys

METADATA_DIR = os.path.join(
    os.path.dirname(__file__), "..", "judgements", "metadata"
)

CRIMINAL_OFFENSE_IDX = 6


def infer_columns(criminal_offense: str) -> tuple:
    lower = criminal_offense.lower()
    embezzlement = "true" if ("pronevjer" in lower or "420" in lower) else "false"
    trading_influence = "true" if ("trgovin" in lower or "422" in lower) else "false"
    if "primanj" in lower or "423" in lower:
        bribe_receiver = "true"
    elif "davanj" in lower or "424" in lower:
        bribe_receiver = "false"
    else:
        bribe_receiver = "false"
    return embezzlement, trading_influence, bribe_receiver


def parse_csv_line(line: str) -> list:
    return next(csv.reader([line]))


def fields_to_csv_line(fields: list) -> str:
    parts = []
    for f in fields:
        if "," in f or '"' in f:
            parts.append('"' + f.replace('"', '""') + '"')
        else:
            parts.append(f)
    return ",".join(parts)


def fix_file(filepath: str) -> str:
    with open(filepath, "r", encoding="utf-8") as f:
        raw_lines = f.read().splitlines()

    if not raw_lines:
        return "empty"

    new_lines = []
    for line in raw_lines:
        if not line.strip():
            new_lines.append(line)
            continue

        fields = parse_csv_line(line)
        n = len(fields)

        if n == 23:
            return "already ok"

        if n == 19:
            # Missing previouslyConvicted at index 15
            # Insert empty value, then add 3 migration columns
            fields.insert(15, "")  # now 20 cols
            # Add migration columns at index 19
            emb, ti, br = infer_columns(fields[CRIMINAL_OFFENSE_IDX])
            fields.insert(19, emb)
            fields.insert(20, ti)
            fields.insert(21, br)
            # Now 23 cols

        elif n == 24:
            # Remove incorrectly placed migration columns at 19, 20, 21
            del fields[19:22]  # back to 21
            # Remove extra empty column at index 16
            del fields[16]  # back to 20
            # Re-add migration columns at correct position (index 19)
            emb, ti, br = infer_columns(fields[CRIMINAL_OFFENSE_IDX])
            fields.insert(19, emb)
            fields.insert(20, ti)
            fields.insert(21, br)
            # Now 23 cols

        else:
            return f"unexpected {n} columns"

        new_lines.append(fields_to_csv_line(fields))

    with open(filepath, "w", encoding="utf-8", newline="\n") as f:
        f.write("\n".join(new_lines))
        if new_lines:
            f.write("\n")

    return "fixed"


def main():
    metadata_dir = os.path.normpath(METADATA_DIR)
    if not os.path.isdir(metadata_dir):
        print(f"ERROR: Directory not found: {metadata_dir}")
        sys.exit(1)

    csv_files = sorted(f for f in os.listdir(metadata_dir) if f.endswith(".csv"))

    fixed = 0
    for filename in csv_files:
        filepath = os.path.join(metadata_dir, filename)
        with open(filepath, "r", encoding="utf-8") as f:
            line = f.readline().strip()
            if not line:
                continue
            fields = parse_csv_line(line)
            n = len(fields)

        if n != 23:
            result = fix_file(filepath)
            print(f"  {filename}: {n} cols -> {result}")
            if result == "fixed":
                fixed += 1

    print(f"\nFixed {fixed} files")


if __name__ == "__main__":
    main()

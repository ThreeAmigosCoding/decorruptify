"""
One-time migration: add embezzlement, tradingInfluence, bribeReceiver columns
to all verdict metadata CSVs.

Infers values from the criminalOffense field (column index 6):
  - Contains "pronevjer" or "420" -> embezzlement=true
  - Contains "trgovin"  or "422" -> tradingInfluence=true
  - Contains "primanj"  or "423" -> bribeReceiver=true
  - Contains "davanj"   or "424" -> bribeReceiver=false (giver, not receiver)
  - Otherwise defaults to false

New columns are inserted after damageToPublicInterest (index 18)
and before sentenceMonths (previously index 19, now index 22).

Usage:
    python migrate_csv_columns.py
"""

import csv
import os
import sys

METADATA_DIR = os.path.join(
    os.path.dirname(__file__), "..", "judgements", "metadata"
)

# Column index of criminalOffense (0-based, no header row)
CRIMINAL_OFFENSE_IDX = 6

# Insert position: after damageToPublicInterest (index 18), before sentenceMonths (index 19)
INSERT_AFTER = 19  # insert before this index


def infer_columns(criminal_offense: str) -> tuple[str, str, str]:
    """Return (embezzlement, tradingInfluence, bribeReceiver) as string booleans."""
    lower = criminal_offense.lower()

    embezzlement = "true" if ("pronevjer" in lower or "420" in lower) else "false"
    trading_influence = "true" if ("trgovin" in lower or "422" in lower) else "false"

    # bribeReceiver: true if receiving (primanje/423), false if giving (davanje/424)
    # Only set to true/false when bribery is actually involved
    if "primanj" in lower or "423" in lower:
        bribe_receiver = "true"
    elif "davanj" in lower or "424" in lower:
        bribe_receiver = "false"
    else:
        bribe_receiver = "false"

    return embezzlement, trading_influence, bribe_receiver


def parse_csv_line(line: str) -> list[str]:
    """Parse a CSV line respecting double-quoted fields with commas."""
    reader = csv.reader([line])
    return next(reader)


def fields_to_csv_line(fields: list[str]) -> str:
    """Convert fields back to CSV, quoting fields that contain commas."""
    parts = []
    for f in fields:
        if "," in f or '"' in f:
            parts.append('"' + f.replace('"', '""') + '"')
        else:
            parts.append(f)
    return ",".join(parts)


def migrate_file(filepath: str) -> bool:
    """Add 3 new columns to a CSV file. Returns True if modified."""
    with open(filepath, "r", encoding="utf-8") as f:
        raw_lines = f.read().splitlines()

    if not raw_lines:
        return False

    new_lines = []
    for line in raw_lines:
        if not line.strip():
            new_lines.append(line)
            continue

        fields = parse_csv_line(line)

        # Check if already migrated (has 23 columns instead of 20)
        if len(fields) >= 23:
            return False

        if len(fields) < 20:
            print(f"  WARNING: {os.path.basename(filepath)} has {len(fields)} columns, expected 20. Skipping.")
            return False

        criminal_offense = fields[CRIMINAL_OFFENSE_IDX]
        embezzlement, trading_influence, bribe_receiver = infer_columns(criminal_offense)

        # Insert 3 new columns at position INSERT_AFTER (before sentenceMonths)
        fields.insert(INSERT_AFTER, embezzlement)
        fields.insert(INSERT_AFTER + 1, trading_influence)
        fields.insert(INSERT_AFTER + 2, bribe_receiver)

        new_lines.append(fields_to_csv_line(fields))

    with open(filepath, "w", encoding="utf-8", newline="\n") as f:
        f.write("\n".join(new_lines))
        if new_lines:
            f.write("\n")

    return True


def main():
    metadata_dir = os.path.normpath(METADATA_DIR)
    if not os.path.isdir(metadata_dir):
        print(f"ERROR: Directory not found: {metadata_dir}")
        sys.exit(1)

    csv_files = sorted(f for f in os.listdir(metadata_dir) if f.endswith(".csv"))
    print(f"Found {len(csv_files)} CSV files in {metadata_dir}\n")

    modified = 0
    skipped = 0
    for filename in csv_files:
        filepath = os.path.join(metadata_dir, filename)
        if migrate_file(filepath):
            # Re-read to show inferred values
            with open(filepath, "r", encoding="utf-8") as f:
                fields = parse_csv_line(f.readline())
            emb, ti, br = fields[INSERT_AFTER], fields[INSERT_AFTER + 1], fields[INSERT_AFTER + 2]
            print(f"  OK  {filename}  ->  embezzlement={emb}, tradingInfluence={ti}, bribeReceiver={br}")
            modified += 1
        else:
            skipped += 1

    print(f"\nDone: {modified} modified, {skipped} skipped (already migrated or empty)")


if __name__ == "__main__":
    main()

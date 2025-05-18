#!/usr/bin/env bash
# preprocess.sh: Clean and normalize a semicolon-delimited boardgame dataset
# Usage: preprocess.sh <input-file>
# Output: Cleaned, tab-separated file to standard output with quoted Mechanics/Domains

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <input-file>" >&2
  exit 1
fi

input="$1"

# Temporary files
tmp1=$(mktemp)
tmp2=$(mktemp)

# Step 1: Convert Windows (CRLF) line endings to Unix (LF)
tr -d '\r' < "$input" > "$tmp1"

# Step 2: Convert semicolons to tabs
tr ';' '\t' < "$tmp1" > "$tmp2"

# Step 3: Replace decimal commas with dots (e.g., 8,79 -> 8.79)
sed -E 's/([0-9]),([0-9]+)/\1.\2/g' "$tmp2" > "$tmp1"

# Step 4: Remove non-ASCII characters (keep printable ASCII, tabs, newlines)
tr -cd '\11\12\15\40-\176' < "$tmp1" > "$tmp2"

# Step 5: Find max ID in first column (skip header)
maxid=$(awk -F'\t' 'NR>1 && $1 ~ /^[0-9]+$/ { if ($1>m) m=$1 } END { print m+0 }' "$tmp2")

# Step 6: Quote both Mechanics and Domains fields, fill IDs
awk -F'\t' -v OFS='\t' -v maxid="$maxid" '
NR==1 {
    mech_col = dom_col = 0
    for(i=1; i<=NF; i++) {
        if($i == "Mechanics") mech_col = i
        if($i == "Domains") dom_col = i
    }
    print
    next
}
{
    if ($1 == "" || $1 == "/ID") $1 = ++maxid
    if (mech_col > 0) $mech_col = "\"" $mech_col "\""
    if (dom_col > 0) $dom_col = "\"" $dom_col "\""
    print
}
' "$tmp2"

rm -f "$tmp1" "$tmp2"
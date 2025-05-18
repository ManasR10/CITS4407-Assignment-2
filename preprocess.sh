#!/usr/bin/env bash
# preprocess.sh: Clean a semicolon-delimited spreadsheet
# Usage: preprocess.sh <input-file>

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <input-file>" >&2
  exit 1
fi

input="$1"
# Temp files
tmp1=$(mktemp)
tmp2=$(mktemp)

# 1) CRLF → LF
tr -d '\r' < "$input" > "$tmp1"
# 2) ';' → tab
tr ';' '\t' < "$tmp1" > "$tmp2"
# 3) Decimal comma → dot
sed -E 's/([0-9]),([0-9]+)/\1.\2/g' "$tmp2" > "$tmp1"
# 4) Strip non-ASCII
tr -cd '\11\12\15\40-\176' < "$tmp1" > "$tmp2"

# 5) Fill empty IDs (col 1)
maxid=$(awk -F"\t" 'NR>1 && $1 ~ /^[0-9]+$/ { if($1>m) m=$1 } END { print m+0 }' "$tmp2")
awk -F"\t" -v OFS="\t" -v maxid="$maxid" '
NR==1 { print; next }
{ if($1==""||$1=="/ID") $1=++maxid; print }
' "$tmp2"

# Cleanup
echo "# Cleanup temp files" >&2
rm -f "$tmp1" "$tmp2"


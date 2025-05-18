#!/bin/bash
# empty_cells.sh: Counts empty cells in each column of a delimited text file.
# Usage: empty_cells.sh <input-file> <separator>
# Example: ./empty_cells.sh sample.txt ";"

# Check correct number of arguments
if [ $# -ne 2 ]; then
    echo "Usage: $0 <input-file> <separator>" >&2
    exit 1
fi

file="$1"
sep="$2"

# Use awk to count empty fields in each column
awk -v FS="$sep" '
NR == 1 {
    for (i = 1; i <= NF; i++) {
        header[i] = $i;
        count[i] = 0;
    }
    next
}
{
    for (i = 1; i <= NF; i++) {
        if ($i == "") count[i]++;
    }
}
END {
    for (i = 1; i <= length(header); i++) {
        print header[i] ": " count[i];
    }
}
' "$file"
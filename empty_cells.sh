#!/bin/bash
# empty_cells.sh: It measures and lists the count of empty (blank) cells in each column of a delimited text file.
    # You indicate the name of the input file and also choose the character to separate the data (; for CSV and \t for TSV).
    # The report gives a simple table listing every column, along with the number of empty cells.

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
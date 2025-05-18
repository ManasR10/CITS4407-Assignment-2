#!/usr/bin/env bash
# analysis.sh: Analyze cleaned board game data for mechanics, domain, and correlations.
# Usage: analysis.sh <cleaned-file>

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <cleaned-file>" >&2
  exit 1
fi

file="$1"

# 1. Dynamically get column indices (header)
read mech_col dom_col year_col rate_col comp_col < <(
  awk 'BEGIN{FS="\t"} NR==1{
    for(i=1;i<=NF;i++) {
      if($i=="Mechanics") m=i;
      if($i=="Domains") d=i;
      if($i=="Year Published") y=i;
      if($i=="Rating Average") r=i;
      if($i=="Complexity Average") c=i;
    }
    print m, d, y, r, c;
    exit;
  }' "$file"
)

# 2. Most popular mechanics
awk -v FS="\t" -v col="$mech_col" '
NR>1{
  n = split($col, arr, /, */);
  for(i=1;i<=n;i++) {
    if(arr[i] == "" || arr[i] == "-") continue;
    count[arr[i]]++;
    if(count[arr[i]] > max) { max = count[arr[i]]; mech = arr[i]; }
  }
}
END{
  printf "The most popular game mechanics is %s found in %d games\n", mech, max;
}' "$file"

# 3. Most popular domain
awk -v FS="\t" -v col="$dom_col" '
NR>1{
  n = split($col, arr, /, */);
  for(i=1;i<=n;i++) {
    if(arr[i] == "" || arr[i] == "-") continue;
    count[arr[i]]++;
    if(count[arr[i]] > max) { max = count[arr[i]]; dom = arr[i]; }
  }
}
END{
  printf "The most popular game domain is %s found in %d games\n", dom, max;
}' "$file"

# 4. Pearson correlation (year vs. rating)
awk -v FS="\t" -v xcol="$year_col" -v ycol="$rate_col" '
NR>1 && $xcol ~ /^[0-9]+$/ && $ycol ~ /^[0-9.]+$/ {
  x = $xcol; y = $ycol;
  n++; sx+=x; sy+=y; sxy+=x*y; sx2+=x*x; sy2+=y*y;
}
END{
  num = n*sxy - sx*sy;
  den = sqrt((n*sx2 - sx^2)*(n*sy2 - sy^2));
  r = (den>0 ? num/den : 0);
  printf "The correlation between the year of publication and the average rating is %.3f\n", r;
}' "$file"

# 5. Pearson correlation (complexity vs. rating)
awk -v FS="\t" -v xcol="$comp_col" -v ycol="$rate_col" '
NR>1 && $xcol ~ /^[0-9.]+$/ && $ycol ~ /^[0-9.]+$/ {
  x = $xcol; y = $ycol;
  n++; sx+=x; sy+=y; sxy+=x*y; sx2+=x*x; sy2+=y*y;
}
END{
  num = n*sxy - sx*sy;
  den = sqrt((n*sx2 - sx^2)*(n*sy2 - sy^2));
  r = (den>0 ? num/den : 0);
  printf "The correlation between the complexity of a game and its average rating is %.3f\n", r;
}' "$file"
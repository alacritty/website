#!/bin/sh

# Convert a changelog section to HTML

if [ "$#" -ne 2 ]; then
    echo "USAGE: convert_changelog.sh <INPUT> <VERSION>"
    exit 1
fi

infile="$1"
version="$2"


filename_version=$(echo "$version" | sed 's/\./_/g')
outfile="changelog_$filename_version.html"
cp "changelog_template.html" "$outfile"

# Replace version
sed -i "s/{{VERSION}}/$version/" "$outfile"

# Replace date
current_date=$(date "+%b %d, %Y")
sed -i "s/{{DATE}}/$current_date/" "$outfile"

# Replace list of changes
content=$(cat "$infile" \
    | sed 's/### \(.*\)/<\/ul><h2><a name="\1" href="#\1">\1<\/a><\/h2><ul>/' \
    | sed 's/- \(.*\)/<li>\1<\/li>/' \
    | tail -c +6)
content=$(printf "$content</ul>" | sed 's/\//\\\//g' | tr -d '\n')
sed -i "s/{{CONTENT}}/$content/" "$outfile"

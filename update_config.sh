#!/bin/sh

# Update the config documentation from its scdoc file.

if [ "$#" -ne 2 ]; then
    echo "USAGE: update_config.sh <MANPAGE_DIR> <VERSION>"
    exit 1
fi

manpage_dir=$(realpath "$1")
version="$2"

mkdir -p "./static/releases/$version"

for manpage in $(ls "$manpage_dir"/*.scd); do
    # Log operation.
    case "$manpage" in
        *.1.scd)
            outfile="./static/releases/$version/cmd-$(basename "$manpage" .1.scd).html"
            ;;
        *.5.scd)
            outfile="./static/releases/$version/config-$(basename "$manpage" .5.scd).html"
            ;;
    esac
    echo "Converting \"$manpage\" to \"$outfile\""

    # Convert from scd to roff.
    roff_name="$(basename "$manpage" .scd).roff"
    scdoc < "$manpage" > "$roff_name"

    # Convert from roff to html.
    pandoc --template "./manpage_template.html" -f man -t html -s "$roff_name" -o "$outfile"

    # Fix maintainers list.
    sed -zi 's/<p>·<\/p>\n *<p>/<p>· /g' "$outfile"

    # Automatically link other config pages.
    sed -zi 's/<strong>\([^<]*\)<\/strong>(5)/<strong><a href=".\/config-\1.html">\1(5)<\/a><\/strong>/g' "$outfile"
    sed -zi 's/<strong>\([^<]*\)<\/strong>(1)/<strong><a href=".\/cmd-\1.html">\1(1)<\/a><\/strong>/g' "$outfile"

    # Delete roff file.
    rm "$roff_name"
done

# Add version to JavaScript dropdown.
sed -i "s/const versions = \[/\0\n  '$version',/" ./static/select_release.js

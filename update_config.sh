#!/bin/sh

# Update the config documentation from its scdoc file.

if [ "$#" -ne 1 ]; then
    echo "USAGE: update_config.sh <MANPAGE_DIR>"
    exit 1
fi

manpage_dir=$(realpath "$1")

for manpage in $(ls "$manpage_dir"/*5.scd); do
    # Log operation.
    outfile="./static/config-$(basename "$manpage" .5.scd).html"
    echo "Converting \"$manpage\" to \"$outfile\""

    # Convert from scd to roff.
    roff_name="$(basename "$manpage" .scd).roff"
    scdoc < "$manpage" > "$roff_name"

    # Convert from roff to html.
    pandoc --template "./manpage_template.html" -f man -t html -s "$roff_name" -o "$outfile"

    # Fix maintainers list.
    sed -zi 's/<p>·<\/p>\n *<p>/<p>· /g' "$outfile"

    # Automatically link other config pages.
    sed -zi 's/<strong>\([^<]*\)<\/strong>(5)/<strong><a href=".\/config-\1.html">\1<\/strong>(5)<\/a>/g' "$outfile"

    # Delete roff file.
    rm "$roff_name"
done

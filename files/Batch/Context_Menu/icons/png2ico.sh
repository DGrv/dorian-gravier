#!/bin/bash
# Convert all PNGs in current folder to 16x16 ICOs

# Make sure ImageMagick 'magick' command is available
if ! command -v convert &> /dev/null
then
    echo "ImageMagick not found. Please install it first."
    exit 1
fi

# Loop through all PNG files
for pngfile in *.png; do
    # Skip if no PNG files
    [ -e "$pngfile" ] || continue

    # Get base filename without extension
    base="${pngfile%.*}"

    # Output ICO filename
    icofile="${base}.ico"

    # Convert to 16x16 ICO
    convert "$pngfile" -resize 16x16 "$icofile"

    echo "Converted $pngfile → $icofile"
done


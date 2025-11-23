#!/bin/bash

# Usage: ./make_tsv.sh <num_rows> <col1> <col2> <col3> ...
# Example: ./make_tsv.sh 15 rembg1 rembg2 rembg3

num_rows=$1
shift  # remove the first argument, now $@ contains column folder names

# Base path for images
base="/assets/images/pages/code/magick/Comparison"

# --- Print header ---
header="Original"
for col in "$@"; do
    header="$header\t$col"
done
echo -e "$header"

# --- Loop over rows ---
for i in $(seq -w 1 "$num_rows"); do
    # Start with the first column (original image)
    row="![]({{ \"$base/S$i.png\" | relative_url }})"
    
    # Loop over additional column folders
    for col in "$@"; do
        row="$row\t![]({{ \"$base/$col/S$i.png\" | relative_url }})"
    done

    # Print the row
    echo -e "$row"
done



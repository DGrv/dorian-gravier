#!/bin/bash -i

wd=$(pwd)
mkdir converted

for j in *epub; do

	# get the names from the loop needed
	filenameepub=$j
	filename=$(basename "$filenameepub" .epub)
	cp "$filenameepub" "${filename}.zip"     # rename the epub to zip
	unzip "${filename}.zip" -d "${filename}" # unzip it
	cd "${filename}/OEBPS/Images"            # go to the wanted directory where the pictures are

	for i in *jpg; do
		nname=$(basename "$i" .jpg)_temp.jpg
		mv "$i" "$nname"                                                    # rename the original picture
		convert "$nname" -background white -gravity south -splice 0x70 "$i" # use imagemagick to add 70px to the bottom
		rm "$nname"                                                         # remove the temp picture
	done

	cd "${wd}/${filename}"
	zip -r "../converted/${filename}_new.epub" "./" # rezip the epub
	cd "$wd"
	rm "${filename}.zip" # remove the temp files left
	rm -r "$filename"

done


--- 
title: "Add margin to epub manga images for the ebook Sony PRS-T2" 
date: "2024-12-19 10:54" 
--- 

I have an old Sony PRS-T2 which works perfectly. I wanted to put some manga on it but there is this bar on the bottom with the page number that is hidding part of the images ([sometimes also text](https://www.reddit.com/r/Calibre/comments/nyfyap/sony_prst2_space_in_top_missing_text_on_bottom/), so I am not the only one with this problem).

![]({{ '/assets/images/posts/2024/manga_prs-t2/20241219-105624_Prs-t2.png' | absolute_url }})

I think there is other possibilities like css but I did not succeed really and testing was pain.

My files are .cbz in really good quality. I used [KCC (a.k.a. Kindle Comic Converter)](https://github.com/ciromattia/kcc) to convert them in epub, crop them to a specific resolution to get the maximum of it ... here the parameters I used:

![]({{ '/assets/images/posts/2024/manga_prs-t2/20241219-105328__KCC.png' | absolute_url }})

What I did then was just add some pixel at the bottom of the pictures. I used bash via WSL.

*Steps:*

- rename the epub to zip
- unzip it
- add the 100 white pixel to the bottom of each pictures
- rezip in epub

Here the source code:

```sh
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
```




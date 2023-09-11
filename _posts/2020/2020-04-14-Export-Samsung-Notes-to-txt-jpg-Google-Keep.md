---
title: "Export Samsung Notes to txt, jpg, Google Keep"
date: "2020-04-14 13:00"
comments_id: 39
---

If you buy a new Handy which is not a Samsung and you wanna restore your notes on this one using Google Keep or either export them all in txt files and get the pictures. 

I built a small batch file using [ghostscript](https://www.ghostscript.com/), [iconv](https://sourceforge.net/projects/gnuwin32/files/libiconv/1.9.2-1/), [Gow](https://github.com/bmatzelle/gow) (with `sed`), [xpdf-tools](https://www.xpdfreader.com/download.html) with `pdfimages`, [ImageMagick](https://imagemagick.org/index.php) with `mogrify` and a [python script: txt-to-google-keep-notes.py](https://gist.github.com/sliceofbytes/f5eab8911c761ff6760362beb17e6477) from [sliceofbytes](https://gist.github.com/sliceofbytes).


The procedure is as follow:

- Export the notes from your handy in pdf (put them on Google Drive e.g.)
	- ![](../assets/2020-04-14-samsung-notes-to-keep_01.jpg)
- get it into txt file via [ghostscript](https://www.ghostscript.com/) **Follow what is selected on the left window and the content of the file on the right window**
	- ![](../assets/2020-04-14-samsung-notes-to-keep_02.jpg)
- remove last line and first spaces
	- ![](../assets/2020-04-14-samsung-notes-to-keep_03.jpg)
- delete accents and special characters
	- ![](../assets/2020-04-14-samsung-notes-to-keep_04.jpg)
- separate title and content
	- ![](../assets/2020-04-14-samsung-notes-to-keep_05.jpg)
	- ![](../assets/2020-04-14-samsung-notes-to-keep_06.jpg)
- extract pictures and convert them in jpg
	- ![](../assets/2020-04-14-samsung-notes-to-keep_07.jpg)
- remove all what is not needed
- Import txt in your Google keep via [txt-to-google-keep-notes.py]((https://gist.github.com/sliceofbytes/f5eab8911c761ff6760362beb17e6477))
	- <script src="https://gist.github.com/sliceofbytes/f5eab8911c761ff6760362beb17e6477.js"></script>
	- change the part for your username and password (**you do this at your own risk, I take no responsabilities that someone is stiling your password by doing this**)
	- run it with python installed and `python your-python-script.py`
- check your Google Keep
	- ![](../assets/2020-04-14-samsung-notes-to-keep_08.jpg)
- Import manually your pictures if needed (only big manual step, but pretty fast)
	- ![](../assets/2020-04-14-samsung-notes-to-keep_10.jpg) ![](../assets/2020-04-14-samsung-notes-to-keep_11.jpg)
	
	


All the source are present in the batch file below:

```shell
@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

	
for %%a in (*.pdf) do (

	REM Extract text from pdf in txt file
	gswin64c.exe -sDEVICE=txtwrite -o %%~na.txt %%a
		REM Source : https://stackoverflow.com/questions/3650957/how-to-extract-text-from-a-pdf
	
	REM Remove last line and remove all double spaces, remove first character if space
	sed "$ d" %%~na.txt | sed "s/  //g" | sed "s/^ //" > %%~na_clean1.txt
		REM rm space with sed : https://stackoverflow.com/questions/6534556/how-to-remove-and-all-of-the-escape-sequences-in-a-file-using-linux-shell-sc and  https://askubuntu.com/questions/537956/sed-to-delete-blank-spaces
		REM Remove first character if : https://superuser.com/questions/157344/delete-the-first-known-character-in-a-string-with-sed
		REM Other tips found
			REM use sed for special characters using coding hex in the table : https://en.wikipedia.org/wiki/ASCII#ASCII_control_characters
				REM e.g. replace SOH with LF sed "s/\x01/\x0A/g" 
				REM do not use ' but "
	
	
	REM special character like accent (I could not use sed with the cmd from windows)
	type %%~na_clean1.txt | iconv.exe -f utf-8 -t ascii//TRANSLIT | tr -d "'^`"> %%~na_noaccent.txt
		REM iconv to discociate the accent with letter : https://stackoverflow.com/questions/10207354/how-to-remove-all-of-the-diacritics-from-a-file - download : https://sourceforge.net/projects/gnuwin32/files/libiconv/1.9.2-1/
		REM only iconv functions on cmd, all of this does not: 
			REM sed -e 's/[àâ]/a/g;s/[ọõ]/o/g;s/[í,ì]/i/g;s/[ê,ệ]/e/g' 
			REM sed -i 'y/āáǎàēéěèīíǐìōóǒòūúǔùǖǘǚǜĀÁǍÀĒÉĚÈĪÍǏÌŌÓǑÒŪÚǓÙǕǗǙǛ/aaaaeeeeiiiioooouuuuüüüüAAAAEEEEIIIIOOOOUUUUÜÜÜÜ/' file
	
	REM Get first line to change filename
	sed -n 1p %%~na_noaccent.txt > %%~na_title
	set /p fn=<%%~na_title
	
	REM Remove first line 
	sed "1d" %%~na_noaccent.txt > %%~na_final.txt
	
	type %%~na_final.txt > !fn!.txt
	
	rm %%~na.txt
	rm %%~na_clean1.txt
	rm %%~na_noaccent.txt
	rm %%~na_final.txt
	rm %%~na_title
	
	
	REM EXTRACT PICTURES PDF
	pdfimages.exe -j "%%a" "!fn!"
		REM Tools here : https://www.xpdfreader.com/download.html
		REM https://stackoverflow.com/questions/17065274/how-to-extract-images-from-pdf-using-ghostscript-or-imagemagick
	magick mogrify -format jpg *.ppm
	del /S *.ppm
	
	
)

REM import in keep : https://gist.github.com/sliceofbytes/f5eab8911c761ff6760362beb17e6477



```



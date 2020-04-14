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



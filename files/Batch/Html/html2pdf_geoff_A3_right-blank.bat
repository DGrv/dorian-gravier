@echo off
SetLocal EnableDelayedExpansion


echo "--------------------------------------------------------------------------------"
echo "   _____             _                _____                 _                   "
echo "  |  __ \           (_)              / ____|               (_)                  "
echo "  | |  | | ___  _ __ _  __ _ _ __   | |  __ _ __ __ ___   ___  ___ _ __         "
echo "  | |  | |/ _ \| '__| |/ _` | '_ \  | | |_ | '__/ _` \ \ / / |/ _ \ '__|        "
echo "  | |__| | (_) | |  | | (_| | | | | | |__| | | | (_| |\ V /| |  __/ |           "
echo "  |_____/ \___/|_|  |_|\__,_|_| |_|  \_____|_|  \__,_| \_/ |_|\___|_|           "
echo "                                                                                "
echo "--------------------------------------------------------------------------------"
REM http://www.network-science.de/ascii/
echo.





echo Script allowing to transform a html file in pdf with blank pages in btw to make annotation.
echo.


set /p input="Give me the path where your html are. I will convert them all: "

cd %input%

for %%i in (*.html) do (

	echo %%i

	echo ^<html^> > output.html
	REM echo ^<head^> >> output.html
	sed -n "/<head>/,/<\/head>/p" %%i >> output.html
	REM echo ^<title^>Page Title^</title^> >> output.html
	REM echo ^</head^> >> output.html
	echo ^<body^> >> output.html
	sed -n "/<style>/,/<\/style>/p" %%i >> output.html
	sed -n "/section-post_body/,/<\/div>/p" %%i >> output.html
	echo ^<br^> >> output.html
	REM echo ^<br^> > output.html
	echo ^</body^> >> output.html
	echo ^</html^> >> output.html


	REM ------------- Change title of the file ---------------
	grep panel__title output.html | grep -Eo ">.*\<" >temp
	set /p title=<temp
	del temp
	set title="!title:<=!"
	set title="!title:>=!"
	set title=!title:"=!
	set title=!title:/=!
	set title=!title::=-!

	echo.
	echo !title!
	REM echo !title!
	REM sed -i "s/Geoff Lawton Permaculture Training – Permaculture, PDC, Online Courses/!title!/g" output.html

	C:\Users\doria\Downloads\Software_pcloud\PortableApps\LibreOfficePortable\App\libreoffice\program\soffice.exe --convert-to pdf --outdir . output.html
	del output.html

	C:\Users\doria\Downloads\Software_pcloud\PortableApps\PDFTKBuilderPortable\App\pdftkbuilder\pdftk.exe output.pdf dump_data | grep NumberOfPages > test2
	set /p pages=<test2
	set pages2=!pages:NumberOfPages: =!
	del test2



	FOR /L %%p IN (1, 1, !pages2!) DO (
		if %%p==1 (
			set list=A1 B1
		) else (
			set list=!list! A%%p B1 
		)
	)

	
	magick convert xc:none -page A4 blank.pdf
	
	C:\Users\doria\Downloads\Software_pcloud\PortableApps\PDFTKBuilderPortable\App\pdftkbuilder\pdftk.exe A=output.pdf B=blank.pdf cat !list! output combined.pdf

	C:\Users\doria\Downloads\Software_pcloud\PortableApps\Ghostscript\bin\gswin64c.exe -o combinedA3.pdf -sDEVICE=pdfwrite -sPAPERSIZE=a3 -dFIXEDMEDIA -dPDFFitPage -dCompatibilityLevel=1.4 combined.pdf

	C:\Users\doria\Downloads\Software_pcloud\winpdfnup\winpdfnup\PDFnUp.exe combinedA3.pdf combinedA3_2up.pdf -ab
	del output.pdf
	del blank.pdf
	del combined.pdf
	del combinedA3.pdf
	rename combinedA3_2up.pdf "!title!.pdf"

)

	REM https://stackoverflow.com/questions/1672580/get-number-of-pages-in-a-pdf-using-a-cmd-batch-file
	REM https://stackoverflow.com/questions/12942486/insert-a-blank-page-between-each-existing-page-in-a-pdf-document
	REM https://stackoverflow.com/questions/11568859/how-to-extract-text-from-a-string-using-sed
	REM https://unix.stackexchange.com/questions/277892/how-do-i-create-a-blank-pdf-from-the-command-line

@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

set /p input=Where is your file: 

for %%a in ("%input%") do (
	set filepathnoext=%%~dpna
	set filepath=%%~dpa
	set drive=%%~da
	set filename=%%~nxa
	set filenamenoext=%%~na
	set ext=%%~xa
)  


%dir%
cd %filepath%

H:\TEMP\Software\Pictures\ImageMagick-7.0.8-28-portable-Q16-x86\magick.exe convert "%input%" "%filepathnoext%.pdf"

echo .
echo filepathnoext: %filepathnoext%
echo filepath: %filepath%
echo drive %drive%
echo filename %filename%
echo filenamenoext: %filenamenoext%
echo ext: %ext%

pause
@echo off
SETLOCAL ENABLEDELAYEDEXPANSION


WHERE magick
IF %ERRORLEVEL% NEQ 0 (
	echo "[DEBUG] - ffmpeg command is unknown, please add it to the PATH
)


echo Will resize recursively all jpg and png to 1280px and delete the original.


set /p wd=Give me your path: 
for %%a in (%wd%) do (
	set pathh=%%~dpa
	set filename=%%~nxa
	set filenamenoext=%%~na
	set filepathnoext=%%~dpna
	set ext=%%~xa
	set drive=%%~da
)  
%drive%
cd "%wd%"


FOR /R %%i IN ("*.jpg") DO (
	echo %%i
	rename "%%i" "%%~ni_temp%%~xi"
	magick convert "%%~di%%~pi%%~ni_temp%%~xi" -resize 1280 "%%i"
	del "%%~di%%~pi%%~ni_temp%%~xi"
)

FOR /R %%i IN ("*.jpeg") DO (
	echo %%i
	magick convert "%%i" -resize 1280 "%%~di%%~pi%%~ni.jpg"
	del "%%i"
)

FOR /R %%i IN ("*.png") DO (
	echo %%i
	magick convert "%%i" -resize 1280 "%%~di%%~pi%%~ni.jpg"
	del "%%i"
)

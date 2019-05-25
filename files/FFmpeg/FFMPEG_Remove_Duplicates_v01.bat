@echo off


echo Batch file for binding all video together from 1 folder.
echo.
set /p input=Give me the path of the directory where your video are: 
 

:: get the last file in the list to get the ext
:: https://stackoverflow.com/questions/47450531/batch-write-output-of-dir-to-a-variable
for /f "delims=" %%a in ('dir /a-d /b /s %input%') do set "last=%%a"


:: extract filename no extension
:: https://stackoverflow.com/questions/15567809/batch-extract-path-and-filename-from-a-variable/15568171
for %%a in (%last%) do (
	set pathh=%%~dpa
    set filename=%%~nxa
	set filenamenoext=%%~na
    set filepathnoext=%%~dpna
	set ext=%%~xa
	set drive=%%~da
)  

echo pathh : %pathh%
echo filename : %filename%
echo filenamenoext : %filenamenoext%
echo filepathnoext : %filepathnoext%
echo ext : %ext%


cd %input%
(for %%i in (*%ext%) do @echo file '%%i') > list.txt
ffmpeg -f concat -i list.txt -c copy output%ext%
del list.txt
for %%i in (*.mp4) do (
	rename %%i %%~ni_temp.mp4
	ffmpeg -hide_banner -loglevel error -i %%~ni_tem2.mp4 -vf mpdecimate,setpts=N/FRAME_RATE/TB %%i
	del %%~ni_temp.mp4
)

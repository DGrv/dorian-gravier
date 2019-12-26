@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

set /p input=Choose where your files are (choose 1 file): 
set /p delay=Delay in ms: 

for /F %%i in ("%input%") do @set drive=%%~di

%drive%
cd "%input%"


H:\TEMP\Software\Pictures\ImageMagick-7.0.8-28-portable-Q16-x86\magick.exe convert -delay %delay% -loop 0 *.jpg Gif_%delay%.gif


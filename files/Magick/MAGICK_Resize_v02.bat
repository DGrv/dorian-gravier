@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

set /p input=Where are your files: 
set /p which="Do you want to resize jpg (type 1) or png (type 2) ? : "

if %which%==1 set format="jpg"
if %which%==2 set format="png"

set /p per=percent to resize (numeric) ?: 

for /F %%i in ("%input%") do @set drive=%%~di

%drive%
cd "%input%"

for %%p in (*.%format%) do H:\TEMP\Software\Pictures\ImageMagick-7.0.8-28-portable-Q16-x86\magick.exe convert %%p -resize %per%%% %%~np_%per%per.%format%


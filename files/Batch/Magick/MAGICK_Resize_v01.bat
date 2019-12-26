@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

set /p which="Do you want to resize jpg (type 1) or png (type 2) ? : "

if %which%==1 set format="jpg"
if %which%==2 set format="png"

set /p per=percent to resize (numeric) ?: 

echo Choose where your files are (choose 1 file):

:: file choose and get dir
set dialog="about:<input type=file id=FILE><script>FILE.click();new ActiveXObject
set dialog=%dialog%('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(FILE.value);
set dialog=%dialog%close();resizeTo(0,0);</script>"

for /f "tokens=* delims=" %%p in ('mshta.exe %dialog%') do set "input=%%p"
for /F %%i in ("%input%") do @set dir=%%~dpi
for /F %%i in ("%input%") do @set drive=%%~di

%drive%
cd "%dir%"

:: give info on what will be done
dir /a-d /b "*%format%" | find /c %format% > temp
set /p nfiles= < temp
::set /a nfiles=nfiles
del temp

for %%p in (*.%format%) do magick convert %%p -resize %per%%% %%~np_low.%format%


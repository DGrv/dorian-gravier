@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

echo Choose where your flex files are (choose 1 flex):

:: file choose and get dir
set dialog="about:<input type=file id=FILE><script>FILE.click();new ActiveXObject
set dialog=%dialog%('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(FILE.value);
set dialog=%dialog%close();resizeTo(0,0);</script>"

for /f "tokens=* delims=" %%p in ('mshta.exe %dialog%') do set "input=%%p"
for /F %%i in ("%input%") do @set dir=%%~dpi
for /F %%i in ("%input%") do @set drive=%%~di

%drive%
cd %dir%
mkdir TIFF

:: User input number of channel

set /p channel="How many Channel you have ? "
set /a channel=channel

:: give info on what will be done
dir /a-d /b "*flex" | find /c "flex" > temp
set /p nfiles= < temp
set /a nfiles=nfiles
set /a xfile=1
del temp

set /p tt=%nfiles% flex will be processed, type Enter to continue.
	
	
:: convert in tiff and rename it
FOR /F "delims=" %%a IN ('dir /a-d /b "*flex"') DO (
	H:\TEMP\Software\ImageMagick-7.0.8-Q16\magick.exe convert %%a -set filename:f "%%t_%%s" +adjoin "TIFF\%%[filename:f].tif"
	dir /b "*.tif" | find /c "%%~na" > temp
	set /p howmany= < temp
	set /a howmany=!howmany!
	del temp
	set /a loopfi=howmany/channel
	:: order dir by date /od
	cd TIFF
	FOR /F "delims=" %%b IN ('dir /a-d /b /od "%%~na*tif"') DO (
		FOR /l %%c IN (1, 1, !loopfi!) DO (
			FOR /l %%d IN (1, 1, %channel%) DO (
				ren %%b TIFF\%%~na_ch%%d_fi%%c.tif
				
			)
		)
	)
	cd ..
	echo !xfile! flex / !nfiles!
)	


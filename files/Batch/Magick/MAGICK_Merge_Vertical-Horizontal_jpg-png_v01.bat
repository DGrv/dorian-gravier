@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

set /p dir=Where are you file ? 
set /p which="Do you want to merge jpg (type 1) or png (type 2) ? : "

if %which%==1 set format="jpg"
if %which%==2 set format="png"

set /p resize="Do you want to resize them [y/n] ?  "
if %resize%==y (   
	set /p per="Percent to resize (numeric, 1 to 100) (make a copy it will overwrite your files)?: "
) else (
	set per=100
)
set /p ori="Which orientation [v/h] ? " 


for %%a in (%dir%) do (
	set drive=%%~da
)  
%drive%
cd "%dir%"

:: give info on what will be done
dir /a-d /b "*%format%" | find /c %format% > temp
set /p nfiles= < temp
::set /a nfiles=nfiles
del temp

echo [DEBUG] -------
echo resize=%resize%
echo ori=%ori%
echo nfiles=%nfiles%
echo drive=%drive%
echo dir=%dir%
echo.



:: resize
if %resize%==y (
	if NOT %per%==100 (
		for %%p in (*.%format%) do magick convert %%p -resize %per%%% %%p
	)
)


:: Merge
if %ori%==v (
	magick montage "*.%format%" -tile 1x%nfiles% -geometry +0+0 Merge.%format%
)
if %ori%==h (
	magick montage "*.%format%" -tile %nfiles%x1 -geometry +0+0 Merge.%format%
)
magick convert Merge.%format% Merge.pdf

::echo DEBUG --------------------------
::echo drive %drive%
::echo dir %dir% 
::echo which %which%
::echo format %format%
::echo H:\TEMP\Software\Pictures\ImageMagick-7.0.8-28-portable-Q16-x86\magick.exe montage *.%format% -tile 1x%nfiles% -geometry +0+0 Merge.%format%
::echo H:\TEMP\Software\Pictures\ImageMagick-7.0.8-28-portable-Q16-x86\magick.exe convert Merge.%format% Merge.pdf

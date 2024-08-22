@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

echo Will resize recursively all jpg and png to 600px and delete the original.
echo Where the bat is run !!!!!!!!!!!!!!!!!!!!!!!
REM pause
REM set /p path=Give me your path: 

REM cd %path%

:: Bar progress -----------------------------------
rem Fill "bar" variable with 70 characters
set "bar="
for /L %%i in (1,1,70) do set "bar=!bar!X"
rem Fill "space" variable with filler spaces
set "space="
for /L %%i in (1,1,110) do set "space=!space!_"
rem Count the number of files in this dir (just as an example)
set n=0
for /R %%f in ("*.jpg") do set /A n+=1
for /R %%f in ("*.jpeg") do set /A n+=1
for /R %%f in ("*.png") do set /A n+=1
for /R %%f in ("*.tif") do set /A n+=1
set i=0




FOR /R %%i IN ("*.jpg") DO (
	echo %%i
	magick identify -format "%%w" "%%i" > temp
	set /p wei=<temp
	REM del temp
	if NOT !wei!==600 (
		rename "%%i" "%%~ni_temp%%~xi"
		magick convert "%%~di%%~pi%%~ni_temp%%~xi" -resize 600^> -density 96 -units pixelsperinch "%%i"
		del "%%~di%%~pi%%~ni_temp%%~xi"
	)
	:: Process bar
	set /A i+=1, percent=!i!*100/!n!
	for %%a in (!percent!) do (
		set bar2=!bar:~0,%%a!
		set /a left=100-%%a
		for %%b in (!left!) do (
			set space2=!space:~-%%b!
			title %%a%% !bar2!!space2!
		)
	)
)

FOR /R %%i IN ("*.jpeg") DO (
	echo %%i
	magick convert "%%i" -resize 600^> -density 96 -units pixelsperinch "%%~di%%~pi%%~ni.jpg"
	del "%%i"
	:: Process bar
	set /A i+=1, percent=!i!*100/!n!
	for %%a in (!percent!) do (
		set bar2=!bar:~0,%%a!
		set /a left=100-%%a
		for %%b in (!left!) do (
			set space2=!space:~-%%b!
			title %%a%% !bar2!!space2!
		)
	)
)

FOR /R %%i IN ("*.png") DO (
	echo %%i
	magick convert "%%i" -resize 600^> -background white -flatten -density 96 -units pixelsperinch "%%~di%%~pi%%~ni.jpg"
	del "%%i"
	:: Process bar
	set /A i+=1, percent=!i!*100/!n!
	for %%a in (!percent!) do (
		set bar2=!bar:~0,%%a!
		set /a left=100-%%a
		for %%b in (!left!) do (
			set space2=!space:~-%%b!
			title !i! / !n!  -  %%a%%  -  !bar2!!space2!
		)
	)
)

FOR /R %%i IN ("*.tif") DO (
	echo %%i
	magick convert "%%i" -resize 600^>  "%%~di%%~pi%%~ni.jpg"
	del "%%i"
	:: Process bar
	set /A i+=1, percent=!i!*100/!n!
	for %%a in (!percent!) do (
		set bar2=!bar:~0,%%a!
		set /a left=100-%%a
		for %%b in (!left!) do (
			set space2=!space:~-%%b!
			title !i! / !n!  -  %%a%%  -  !bar2!!space2!
		)
	)
)

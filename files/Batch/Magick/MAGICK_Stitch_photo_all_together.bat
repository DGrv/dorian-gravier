@echo off
setlocal EnableDelayedExpansion


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

echo Will create a stitch matrix of picture that you have in one folder. 
echo.

where magick
IF %ERRORLEVEL% NEQ 0 (
	echo "[DEBUG] - Magick is missing !!!!!!!!"
	pause
)
for /f %%a in ('where sort ^| head -1 ^| grep "usr" ^| wc -l') do set so=%%a

IF not %so%==1 (
	echo "[DEBUG] - git does not seem to be installed"
)


set /p wd=Give your folder were your pictures are (only your pictures): 
set /p nw="How many picture you want as width ? "
REM set /p ext="Which extension file ? "
set /p resize="Width max after resizing of final picture (original will be kept) ? "
REM set nw=6
set /a nwn=nw
REM set ext=jpg
for %%a in (%wd%) do (
	REM set pathh=%%~dpa
	REM set filename=%%~nxa
	REM set filenamenoext=%%~na
	REM set filepathnoext=%%~dpna
	REM set ext=%%~xa
	set drive=%%~da
)  
%drive%
cd %wd%

for /f %%i in ('ls -1 ^| wc -l') do set numberoffile=%%i
set /a nhn=numberoffile/nwn
set /a repeatloop=numberoffile*4
set /a retry=5

echo [95m[DEBUG] --------------------------
echo %numberoffile% files
echo %nwn% w  x %nhn% h
echo will retry %retry% times
echo ----------------------------------[0m

pause



mkdir temp_stitch


for %%f in (*) do (
	set filenamenoext=%%~nf
	set ext=%%~xf
	copy "%%f" "%wd%\temp_stitch\!filenamenoext!_inbtw!ext!"
)
cd temp_stitch

REM Get minimum height and weight
for /f %%a in ('magick identify -format %%w\n * ^| sort -n ^| head -1') do set /a wmin=%%a
for /f %%a in ('magick identify -format %%w\n * ^| sort -n ^| head -1') do set /a hmin=%%a

REM :: test did not finish
REM for %%f in (*) do (
	REM for /f %%a in ('magick identify -format %%w %%f') do set /a w=%%a
	REM for /f %%a in ('magick identify -format %%h %%f') do set /a h=%%a
	REM set /a ratio=w*100/h
	REM echo !ratio!
REM )
	
mogrify -resize x%hmin% *
mogrify -crop %wmin%x+0+0 -gravity Center *


REM ((for %%f in (*.jpg) do @echo %%f) > list.files)
REM echo [DEBUG] - list.files done && pause

set n=0
for %%f in (*_inbtw*) do (
	set /A n+=1
	set "file[!n!]=%%f"
)

set /a nretry=0

:continue
echo.
echo Create random series nretry  --------------------


touch random
for /l %%f in (1,1,%repeatloop%) do (
	REM echo %%f
	set /A "rand=(n*!random!)/32768+1"
	for /f %%i in ('grep "s!rand!e" random ^| wc -l') do set check=%%i
	for /f %%i in ('cat random ^| wc -l') do set /a nlines=%%i+1
	if NOT !check!==1 (
		echo s!rand!e >> random
		REM echo [DEBUG] - wrote random
		echo !nlines!/%numberoffile%
	) else (
		REM echo [DEBUG] - DID NOT wrote random
	)
	for /f %%i in ('cat random ^| wc -l') do set check2=%%i
	if !check2!==!numberoffile! goto next
)

:next
copy random random2

for /L %%z in (1,1,%nhn%) do (

	REM :next
	REM echo [DEBUG] - went to next && pause
	FOR /L %%X IN (1,1,%nwn%) DO (
		set /p firstline=<random2
		set firstline=!firstline:s=!
		set firstline=!firstline:e=!
		rename random2 random2.temp
		more +1 random2.temp > random2
		del random2.temp
		REM echo firstline = !firstline!
		FOR %%h in (!firstline!) do rename "!file[%%h]!" "!file[%%h]!_ready.jpg"
	)
	magick convert +append *_ready.jpg outwidth%%z.jpg
	for %%i in (*_ready.jpg) do (
		set filenameold=%%i
		set filenamenew=!filenameold:_ready.jpg=!
		REM echo rename "!filenameold!" "!filenamenew!"
		rename "!filenameold!" "!filenamenew!"
	)
)
set /a nretry+=1
magick convert -append outwidth* OUTPUT_STITCH_%nretry%.jpg
magick convert OUTPUT_STITCH_%nretry%.jpg -resize %resize%x OUTPUT_STITCH_%nretry%_low.jpg
move OUTPUT_STITCH_%nretry%.jpg ..
move OUTPUT_STITCH_%nretry%_low.jpg ..
del random random2
for %%g in (outwidth*) do del "%%g"
if not %nretry%==%retry% goto :continue

for %%j in (*_inbtw.jpg) do del "%%j"
cd ..
rmdir /S /Q temp_stitch



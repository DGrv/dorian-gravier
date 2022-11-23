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


set /p wd=Give your folder were your pictures are: 
set /p nw="How many picture you want as width ? "
set /p ext="Which extension file ? "
set /p resize="Width max after resizing of final picture (original will be kept) ? "
REM set nw=6
set /a nwn=nw
REM set ext=jpg
for /f %%i in ('ls ^| grep %ext% ^| wc -l') do set nf=%%i
set /a nhn=nf/nwn
set /a repeatloop=nf*4

mkdir temp_stitch



for %%f in (*.%ext%) do (
	copy "%%f" "%wd%\temp_stitch\%%f_inbtw.%ext%"
)
cd temp_stitch


REM ((for %%f in (*.%ext%) do @echo %%f) > list.files)
REM echo [DEBUG] - list.files done && pause

set n=0
for %%f in (*_inbtw*) do (
	set /A n+=1
	set "file[!n!]=%%f"
)


for /l %%f in (1,1,%repeatloop%) do (
	echo %%f
	set /A "rand=(n*!random!)/32768+1"
	for /f %%i in ('grep "s!rand!e" random ^| wc -l') do set check=%%i
	if NOT !check!==1 (
		echo s!rand!e >> random
		echo [DEBUG] - wrote random
	) else (
		echo [DEBUG] - DID NOT wrote random
	)
	for /f %%i in ('cat random ^| wc -l') do set check2=%%i
	if !check2!==!nf! goto next
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
		echo firstline = !firstline!
		FOR %%h in (!firstline!) do rename "!file[%%h]!" "!file[%%h]!_ready.%ext%"
		pause
	)

	magick convert +append *_ready.%ext% outwidth%%z.%ext%

	for %%i in (*_ready.%ext%) do del "%%i"
)

magick convert -append outwidth* OUTPUT_STITCH.%ext%
for %%i in (*_inbtw.%ext%) do del "%%i"
for %%i in (outwidth*) do del "%%i"
move OUTPUT_STITCH.%ext% ..
del random random2
cd ..
rmdir /S /Q temp_stitch

 magick convert OUTPUT_STITCH.jpg -resize %resize%x OUTPUT_STITCH_low.jpg


@echo off
SetLocal EnableDelayedExpansion

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

echo Batch file for binding all video together from 1 folder (.ts extension) and convert them in low resolution. 
echo.
echo Take care of name of the files, should not contain strange characters (no paranthesis e.g.) !!!
echo.


if "%~1"=="" (
	set /p input=Give me the path of the directory where your video are: 
) else (
	set input=%~1
)

echo.
echo ------------- DEBUG ---------------
echo input: %input%
echo.


for %%i in ("%input%") do (
	set dir=%%~dpi
	set drive=%%~di
)
%drive%
cd "%input%"


REM FOR /d /r %%G in ("*") DO Echo We found %%~nxG
REM FOR /d /r %%G in ("*") DO Echo We found %%~nxG

for /d /r %%i in ("*") do (
	echo.
	echo.
	echo ----------------New item ------------
	echo "%%i"
	echo.
	echo.
	
	cd "%%i"
	for %%j in (*.ts) do (
		echo file '%%i\%%j' >> list.txt
		echo %%i\%%j >> list2rm.txt
	)
	
	echo.
	echo. 
	echo Concat
	echo. 
	echo. 
	ffmpeg -f concat -safe 0 -i list.txt -c copy output.ts
	
	echo.
	echo. 
	echo Conversion
	echo. 
	echo. 
	
	ffmpeg -i output.ts -vcodec libx265 -vf "scale=1024:-2" -preset slow -crf 30 -acodec aac "%%~nxi.mp4"
	
	for /F "usebackq tokens=*" %%A in ("list2rm.txt") do rm "%%A"
	
	rm list.txt list2rm.txt output.ts
	
)

echo goodbye















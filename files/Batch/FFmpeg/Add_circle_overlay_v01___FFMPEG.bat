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


if "%1"=="" (
	set /p input="Give me the path of your VIDEO file: "
) else (
	set input=%1
) 
set output=%input:.mp4=%


if q%2q==qq (
	set /p times1="At which time to start: "
) else (
	set times1=%2
) 
set times1=%times1:"=%

if q%3q==qq (
	set /p times2="At which time to stop: "
) else (
	set times2=%3
) 
set times2=%times2:"=%


if "%4"=="" (
	set /p xpos="xpos in pixel  [37m"
) else (
	set xpos=%4
) 

if "%5"=="" (
	set /p ypos="ypos in pixel  [37m"
) else (
	set ypos=%5
)




for %%a in (%input%) do (
	set pathh=%%~dpa
	set filename=%%~nxa
	set filenamenoext=%%~na
	set filepathnoext=%%~dpna
	set ext=%%~xa
	set drive=%%~da
)  
%drive%
cd "%pathh%"


FOR /F %%A IN ('WMIC OS GET LocalDateTime ^| FINDSTR \.') DO @SET time=%%A
set TIMESTAMP=%time:~0,8%-%time:~8,6%


set filenamenew=%filenamenoext%_old_%TIMESTAMP%.mp4
rename %filename% %filenamenew%

echo [95m[DEBUG] ---------------------
echo 1 = %1
echo 2 = %2
echo 3 = %3
echo 4 = %4
echo 5 = %5
echo times1 = %times1%
echo times2 = %times2%
echo set xpos=%xpos% 
echo set ypos=%ypos% 
echo filenamenew = %filenamenew%
echo filename = %filename%
echo cd = %cd%
echo ----------------------[37m




ffmpeg -stats -loglevel error -i "%filenamenew%" -ignore_loop 0 -i "D:\Pictures\Youtube\icon\Arrow\Circle.gif" -filter_complex "[1:v]setpts=PTS-STARTPTS+(1/TB)[1v];[0:v][1v] overlay=%xpos%-(w/2):%ypos%-(h/2):enable='between(t,%times1%,%times2%)':shortest=1" -c:a copy "%filename%"





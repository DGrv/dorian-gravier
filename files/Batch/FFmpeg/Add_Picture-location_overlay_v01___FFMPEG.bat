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

echo [91mIf call in batchfile please use the time in quotes "1,4"[37m
echo [91mIf call in batchfile please use the time in quotes "1,4"[37m
echo [91mIf call in batchfile please use the time in quotes "1,4"[37m
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
	set /p place2look="Which location to look for : "
) else (
	set place2look=%4
) 
echo.
echo.

Rscript --vanilla C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\R\gpx\Bike_map_location_choose_v01.R "%place2look%"



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

set position=0:0

FOR /F %%A IN ('WMIC OS GET LocalDateTime ^| FINDSTR \.') DO @SET time=%%A
set TIMESTAMP=%time:~0,8%-%time:~8,6%


set filenamenew=%filenamenoext%_old_%TIMESTAMP%.mp4
rename %filename% %filenamenew%

echo [95m[DEBUG] ---------------------
echo 1 = %1
echo 2 = %2
echo 3 = %3
echo 4 = %4
echo times1 = %times1%
echo times2 = %times2%
echo place2look = %place2look%
echo position = %position%
echo filenamenew = %filenamenew%
echo filename = %filename%
echo cd = %cd%
echo ----------------------[37m


ffmpeg -stats -loglevel error -i "%filenamenew%" -i "D:\Pictures\GoPro\Map_bike\Location_choose_white.png" -filter_complex "[1:v]setpts=PTS-STARTPTS+(1/TB)[1v];[0:v][1v] overlay=%position%:enable='between(t,%times1%,%times2%)'" -c:a copy "%filename%"









REM https://stackoverflow.com/questions/37144225/overlaying-alpha-images-on-a-video-using-ffmpeg
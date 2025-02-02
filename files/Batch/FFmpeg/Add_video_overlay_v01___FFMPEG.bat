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
	set /p input1="Give me the path video file below: "
) else (
	set input1=%1
) 

for %%a in (%input1%) do (
	set pathh=%%~dpa
	set filename=%%~nxa
	set filenamenoext=%%~na
	set filepathnoext=%%~dpna
	set ext=%%~xa
	set drive=%%~da
)  
%drive%
cd "%pathh%"

REM FOR /F %%A IN ('WMIC OS GET LocalDateTime ^| FINDSTR \.') DO @SET time=%%A
REM set TIMESTAMP=%time:~0,8%-%time:~8,6%
for /f %%p in ('bash -c "date +"%%Y%%m%%d-%%H%%M%%S""') do set TIMESTAMP=%%p

set filenamenew=%filenamenoext%_old_%TIMESTAMP%.mp4


if q%2q==qq (
	set /p times="At which time to start: "
) else (
	set times=%2
) 

set times=%times:"=%

if "%3"=="" (
	set /p input2="Give me the path video file on top: "
) else (
	set input2=%3
) 

for /f %%j in ('ffprobe -v error -show_entries format^=duration -of default^=noprint_wrappers^=1:nokey^=1 "%input2%"') do set dd=%%j










echo [95m[DEBUG] ---------------------
echo 1 = %1
echo 2 = %2
echo 3 = %3
echo 4 = %4
echo times = %times%
echo dd = %dd%
echo filenamenew = %filenamenew%
echo filename = %filename%
echo cd = %cd%
echo ----------------------[37m



rename %filename% %filenamenew%

ffmpeg -stats -loglevel error -i "%filenamenew%" -i "%input2%" -filter_complex "[1]setpts=PTS-STARTPTS+%times%/TB[top];[0][top]overlay=enable='between(t,%times%,%dd%+%times%)'" -c:a copy "%filename%"


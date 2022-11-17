@echo off
set local
REM SetLocal EnableDelayedExpansion


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

echo This will get the first <time> balise to use the date as name in your file with a prefix that you set


if "%1"=="" (
	set /p pathfile="Give me the gpx path: "
) else (
	set pathfile=%1
) 

REM set /p name="Give a prefix name to your gpx file: "
set name=BT22

echo %pathfile%
REM The first <time> is wro´ng so use the first one
REM Use a ^to use a pipe
for /f "tokens=*" %%i in ('sed -nr "s/.*<time>(.*)<\/time>/\1/p" %pathfile% ^| head -2 ^| tail -1') do set dayy=%%i
set dayy=%dayy:~0,10%
set newname=%name%_%dayy%.gpx

rename %pathfile% "%newname%"




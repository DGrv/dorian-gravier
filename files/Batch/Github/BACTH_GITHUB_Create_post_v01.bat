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


set wd="C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\_posts\2022"
cd %wd%

set /p title=Give me a small title for the filename: 

:: ---------- Find Time ----------
set hour=%time:~0,2%
if "%hour:~0,1%" == " " set hour=0%hour:~1,1%
set min=%time:~3,2%
if "%min:~0,1%" == " " set min=0%min:~1,1%
::set secs=%time:~6,2%
::if "%secs:~0,1%" == " " set secs=0%secs:~1,1%

set year=%date:~-4%
set month=%date:~-7,2%
if "%month:~0,1%" == " " set month=0%month:~1,1%
set day=%date:~-10,2%
if "%day:~0,1%" == " " set day=0%day:~1,1%


set datetimef=%year%-%month%-%day%
set datetimehour=%year%-%month%-%day% %hour%:%min%

set title=%title: =_%
set filename=%datetimef%-%title%.md


echo --- >> %filename%
echo layout: "post" >> %filename%
echo title: "-----------------" >> %filename%
echo date: "%datetimehour%" >> %filename%
echo comments_id: --------------------- >> %filename%
echo --- >> %filename%
echo.>> %filename%
echo.>> %filename%
echo.>> %filename%
echo **Create issue with:**>> %filename%
echo cd C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io>> %filename%
echo gh issue create --title "[Comment] xxxxxx" --body "" --label Comments>> %filename%
echo.>> %filename%
echo.>> %filename%



%wd%\%filename%

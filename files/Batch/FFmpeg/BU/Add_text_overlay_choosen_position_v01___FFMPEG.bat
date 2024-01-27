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

echo Will add text overlay where you want on your video
echo [91mYou can use  in your string to create new line !!!![37m

echo.
echo Your ffmpeg is here:
WHERE ffmpeg
IF %ERRORLEVEL% NEQ 0 (
	echo [DEBUG] - ffmpeg command is unknown, please add it to the PATH
)
echo.

if "%1"=="" (
	set /p pathfile="Give me the Video path: "
) else (
	set pathfile=%1
) 
 
for %%a in (%pathfile%) do (
	set pathh=%%~dpa
	set filename=%%~nxa
	set filenamenoext=%%~na
	set filepathnoext=%%~dpna
	set ext=%%~xa
	set drive=%%~da
)  
%drive%
cd "%pathh%"




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
	set /p fontsize="Give me your fontsize (Try big first, maybe 50, nothing will be 50): "
) else (
	set fontsize=%4
) 
if [%fontsize%]==[] (
	set fontsize=50
)


if "%~7"=="" (
	echo [91m
	set /p text="Give me you text: You can use \n in your string to create new line:  [37m"
	echo [37m
) else (
	set text=%~7
) 



:: use %~1 instead of %1 if you have space in the text
:: use %~1 instead of %1 if you have space in the text
:: use %~1 instead of %1 if you have space in the text
:: use %~1 instead of %1 if you have space in the text

set ft1=%filenamenoext%_old_temp.txt
if "%text%"=="" (
	touch %ft1%
	GOTO continue1
)

:: do not know why but I can not put this in a if so I used GOTO
set "text=%text:!=^!%"
set "text=%text:(=^(%"
set "text=%text:)=^)%"
set "text=%text:\n\n= & echo. & echo %"
set "text=%text:\n= & echo %"
set "text=%text:"=%"
REM if exist "%ft1%" rm %ft1%
(echo %text%) > %ft1%
truncate -s -2 %ft1%





if "%5"=="" (
	set /p xpos="xpos in pixel  [37m"
) else (
	set xpos=%5
) 

if "%6"=="" (
	set /p ypos="ypos in pixel  [37m"
) else (
	set ypos=%6
)







FOR /F %%A IN ('WMIC OS GET LocalDateTime ^| FINDSTR \.') DO @SET time=%%A
set TIMESTAMP=%time:~0,8%-%time:~8,6%

set filenamenew=%filenamenoext%_old_%TIMESTAMP%.mp4

echo.
echo.

echo [95m[DEBUG] ---------------------
echo 1 = %1
echo 2 = %2
echo 3 = %3
echo 4 = %4
echo 5 = %5
echo 6 = %6
echo 7 = %7
echo set cd=%cd%
echo set pathfile=%pathfile%
echo set pathh=%pathh%
echo set times1=%times1%
echo set times2=%times2%
echo set fontsize=%fontsize%
echo set xpos=%xpos% 
echo set ypos=%ypos% 
echo set filename=%filename%
echo set filenamenew=%filenamenew%
echo set rename "%filename%" "%filenamenew%"
echo.
echo cat %ft1%
cat %ft1%
echo.
echo ----------------------[37m



rename "%filename%" "%filenamenew%"

ffmpeg -stats -loglevel error -i "%filenamenew%" -vf "drawtext=textfile=%ft1%: fontcolor=white: fontfile='C\:\\Windows\\Fonts\\calibri.ttf': fontsize=%fontsize%:  x=!xpos!:y=!ypos!:enable='between(t,%times1%,%times2%)'" -c:a copy "%filename%"


del %ft1%



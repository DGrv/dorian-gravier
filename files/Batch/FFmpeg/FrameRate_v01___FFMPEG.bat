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

WHERE ffmpeg
IF %ERRORLEVEL% NEQ 0 (
	echo "[DEBUG] - ffmpeg command is unknown, please add it to the PATH
)
WHERE ffprobe
IF %ERRORLEVEL% NEQ 0 (
	echo "[DEBUG] - ffprobe command is unknown, please add it to the PATH
)
WHERE exiftool
IF %ERRORLEVEL% NEQ 0 (
	echo "[91m[DEBUG] - exiftool is missing  !!!!!!!!" [37m
	pause
)
echo.
echo.
	

if "%~1"=="" (
	set /p filepath="Give me the path of your file: "
) else (
	set filepath=%~1
)

for %%a in ("%filepath%") do (
	set pathh=%%~dpa
	set filename=%%~nxa
	set filenamenoext=%%~na
	set filepathnoext=%%~dpna
	set ext=%%~xa
	set drive=%%~da
)  


for /f %%j in ('exiftool "%filepath%" ^| grep "Video Frame Rate" ^| perl -pe "s|.*\: (.*)|\1|g"') do set RV=%%j



REM FOR /F %%A IN ('WMIC OS GET LocalDateTime ^| FINDSTR \.') DO @SET time=%%A
REM set TIMESTAMP=%time:~0,8%-%time:~8,6%
for /f %%p in ('bash -c "date +"%%Y%%m%%d-%%H%%M%%S""') do set TIMESTAMP=%%p

set renamefile=%filenamenoext%_old_fr%RV%_%TIMESTAMP%%ext%




echo [95m[DEBUG] - pathh = %pathh%
echo [DEBUG] - filename = %filename%
echo [DEBUG] - filenamenoext = %filenamenoext%
echo [DEBUG] - filepathnoext = %filepathnoext%
echo [DEBUG] - drive = %drive%
echo [DEBUG] - ext = %ext%
echo. 
echo [DEBUG] - filepath=%filepath%
echo renamefile = %renamefile% [0m
%drive%
cd %pathh%


if "%~2"=="" (
	set /p kfi="Frame rate wanted (if nothing it will be 24) your video is %RV%: "
) else (
	set kfi=%~2
)

if "%kfi%"=="" (
	set kfi=24
)





rename "%filepath%" "%renamefile%"
ffmpeg -stats -loglevel error -i "%renamefile%" -r %kfi% "%filepath%"




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
	echo "[DEBUG] - exiftool command is unknown, please add it to the PATH
)
WHERE perl
IF %ERRORLEVEL% NEQ 0 (
	echo "[DEBUG] - perl command is unknown, please add it to the PATH
)
WHERE bc
IF %ERRORLEVEL% NEQ 0 (
	echo "[DEBUG] - bc command is unknown, please add it to the PATH
)
	
echo.
echo -------------------------------------------------
echo INFO -
echo.

if "%~1"=="" (
	set /p wd="Give me the path of your files: "
) else (
	set wd=%~1
)

for %%a in (%wd%) do (
	set pathh=%%~dpa
	set filename=%%~nxa
	set filenamenoext=%%~na
	set filepathnoext=%%~dpna
	set ext=%%~xa
	set drive=%%~da
)  
echo drive=%drive%
echo wd=%wd%
%drive%
cd %wd%
echo.

set /a da=0
for /f %%j in ('exiftool -n -T -duration -s3 *mp3 ^| awk "{s+=$1}END{print s}" ^| perl -pe "s|(.*)\..*|\1|g"') do set da=%%j

echo.
echo Processing the videos ...
echo.


set /a dv=0
for /f %%j in ('exiftool -n -T -duration -s3 *mp4 ^| awk "{s+=$1}END{print s}" ^| perl -pe "s|(.*)\..*|\1|g"') do set dv=%%j

	
	
set /a dv2=dv+12+12+12
set /a daM=da/60
set /a dvM=dv/60
set /a dv2M=dv2/60
set /a ddiff=dv-da
	
echo.
echo --------------------------------------------
echo [93mRESULTS:
echo Mp4 : %dv% s  -  %dvM%min
echo Mp4 : %dv2% s  -  %dv2M%min with extra title and end
echo Mp3 : %da% s  -  %daM%min
echo diff = %ddiff%[37m
echo --------------------------------------------
echo.
	

pause

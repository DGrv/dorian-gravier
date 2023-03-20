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

REM # old -------------------
REM set /a TTmp4=0
REM for %%i in (*.mp4) do (
	REM ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "%%i" > tempfile2
	REM set /p lengthvideo=<tempfile2
	REM REM set /a lengthvideo2=!lengthvideo!
	REM set /a TTmp4+=lengthvideo
	REM del tempfile2
REM )

REM set /a TTmp3=0
REM for %%i in (*.mp3) do (
	REM ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "%%i" > tempfile2
	REM set /p lengthvideo=<tempfile2
	REM REM set /a lengthvideo2=!lengthvideo!
	REM set /a TTmp3+=lengthvideo
	REM echo !lengthvideo! = %%i
	REM del tempfile2
REM )


REM # new 
(for %%i in (*.mp4) do @echo file '%%i') > listmp4.txt
(for %%i in (*.mp3) do @echo file '%%i') > listmp3.txt
for %%i in (*.mp3) do (
	ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "%%i" > tempfile2
	set /p lengthvideo=<tempfile2
	set /a lengthvideo=lengthvideo
	echo [93m!lengthvideo! = %%i[37m
	del tempfile2
)
	
	
echo.
echo.

ffmpeg -stats -loglevel error -f concat -i listmp4.txt -c copy allv.mp4
ffmpeg -stats -loglevel error -safe 0 -f concat -i listmp3.txt -c copy alla.mp3
del listmp4.txt
del listmp3.txt

ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 alla.mp3 > tempfile
set /p duraa=<tempfile
ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 allv.mp4 > tempfile
set /p durav=<tempfile
del alla.mp3 allv.mp4 tempfile
set /a duraa=duraa
set /a durav=durav
set /a duraaM=duraa/60
set /a duravM=durav/60
set /a duradiff=durav-duraa

echo.
echo --------------------------------------------
echo [93mRESULTS:
echo Mp4 : %durav% s  -  %duravM%min
echo Mp3 : %duraa% s  -  %duraaM%min
echo diff = %duradiff%[37m
echo --------------------------------------------
echo.

pause


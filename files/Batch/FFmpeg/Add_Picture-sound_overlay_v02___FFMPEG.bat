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
:: if gif using times3 and will be only 2 seconds (for arrow)
set /a times3=times1+2



if "%4"=="" (
	set /p inputp="Give me the path of your picture file (if only sound type enter): "
) else (
	set inputp=%4
) 
set inputpext=%inputp:~-3%


echo inputp = %inputp%
if NOT "%inputp%"=="" (
	if q%5q==qq (
		where ffmpeg
		if errorlevel 0 (
			echo.
			echo.
			for /f %%i in ('ffprobe -v error -select_streams v^:0 -show_entries stream^="width,height" -of csv^=s^=x^:p^=0 "%input%"') do set reso=%%i
			echo Your video resolution is !reso!
			echo.
		)
		set /p position="At which position (e.g. '25:25' meaning 25 pixel from each side, left top corner, if you need right bottom use 'W-w:H-h', with W width of video and w width of image, you can also use e.g. 1350-(w/2):300-(h/2) ): "
	) else (
		set position=%5
	) 
	echo position = !position!
	set position=!position:"=!
) else (
	set position="none"
)

if q%6q==qq (
	set /p choicesound="If you wanna add a sound add it here (path - otherwise type enter): "
) else (
	set choicesound=%6
) 



REM for /f %%i in ('echo %times% ^| perl -pe "s/(.*),.*/\1/p"') do set delaysound=%%i
set delaysound=%times1%
for /f %%i in ('wsl  echo "%delaysound%*1000/1" ^^^| bc') do set delaysound2=%%i




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


REM FOR /F %%A IN ('WMIC OS GET LocalDateTime ^| FINDSTR \.') DO @SET time=%%A
REM set TIMESTAMP=%time:~0,8%-%time:~8,6%
for /f %%p in ('bash -c "date +"%%Y%%m%%d-%%H%%M%%S""') do set TIMESTAMP=%%p

set filenamenew=%filenamenoext%_old_%TIMESTAMP%.mp4
rename %filename% %filenamenew%

echo [95m[DEBUG] ---------------------
echo 1 = %1
echo 2 = %2
echo 3 = %3
echo 4 = %4
echo 5 = %5
echo 6 = %6
echo times1 = %times1%
echo times2 = %times2%
echo times3 = %times3%
echo position = %position%
echo filenamenew = %filenamenew%
echo filename = %filename%
echo delaysound = %delaysound%
echo delaysound2 = %delaysound2%
echo choicesound = %choicesound%
echo cd = %cd%
echo ----------------------[37m







if NOT "%inputp%"=="" (
	if "%inputpext%"=="gif" (
		echo ffmpeg -stats -loglevel error -i "%filenamenew%" -stream_loop -1 -i "%inputp%" -filter_complex "[1:v]setpts=PTS-STARTPTS+(1/TB)[1v];[0:v][1v] overlay=%position%:enable='between(t,%times1%,%times3%)':shortest=1" -c:a copy "%filename%"
		REM pause
		ffmpeg -stats -loglevel error -i "%filenamenew%" -stream_loop -1 -i "%inputp%" -filter_complex "[1:v]setpts=PTS-STARTPTS+(1/TB)[1v];[0:v][1v] overlay=%position%:enable='between(t,%times1%,%times3%)':shortest=1" -c:a copy "%filename%"
	) else (
		ffmpeg -stats -loglevel error -i "%filenamenew%" -i "%inputp%" -filter_complex "[1:v]setpts=PTS-STARTPTS+(1/TB)[1v];[0:v][1v] overlay=%position%:enable='between(t,%times1%,%times2%)'" -c:a copy "%filename%"
	)
)

if NOT q%choicesound%q==qq (
	if NOT "%inputp%"=="" (
		rename "%filename%" temp.mp4
	) else (
		copy "%filenamenew%" temp.mp4
	)
	ffmpeg -stats -loglevel error -y -i temp.mp4 -i "%choicesound%" -filter_complex "[0:a]volume=1[a1];[1:0]volume=1[a2];[a2]adelay=%delaysound2%:all=1[a3];[a1][a3]amix=inputs=2[a]" -map "[a]" -map 0:v -c:v copy "%filename%"
	del temp.mp4
)

REM https://stackoverflow.com/questions/37144225/overlaying-alpha-images-on-a-video-using-ffmpeg
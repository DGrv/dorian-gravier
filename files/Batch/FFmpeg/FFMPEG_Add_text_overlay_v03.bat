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

echo Will add text overlay where you want on your video


	echo.
	echo Your ffmpeg is here:
	WHERE ffmpeg
	IF %ERRORLEVEL% NEQ 0 (
		echo "[DEBUG] - ffmpeg command is unknown, please add it to the PATH
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
REM echo pathh=%pathh%
REM echo filename=%filename%
REM echo filenamenoext=%filenamenoext%
REM echo filepathnoext=%filepathnoext%
REM echo drive=%drive%
REM echo wd=%wd%
%drive%
cd "%pathh%"

if %2=="" (
	set /p time="At which time to start and stop (in form of 'start,stop', e.g '0,20'): "
) else (
	set time=%2
) 
set time=%time:"=%
echo %time%

if "%5"=="" (
	set /p text="Give me you text: "
) else (
	set text=%5
) 


echo|set /p=%text%>temp.txt

if "%3"=="" (
	set /p fontfile='Arial': fontsize="Give me your fontfile='Arial': fontsize (Try big first, maybe 50, nothing will be 50): "
) else (
	set fontfile='Arial': fontsize=%3
) 

if "%fontfile='Arial': fontsize%"=="" (
	set fontfile='Arial': fontsize=50
)

REM echo filenamenoext : %filenamenoext%

echo.
echo "--------------------------------"
echo "| TL          TC            TR |"
echo "|                              |"
echo "| LC          C             RC |"
echo "|                              |"
echo "| BL          BC            BR |"
echo "--------------------------------"
echo.

echo Give a x position (0.1 will be on the left, 0.9 will be on the right)
if "%4"=="" (
	set /p xpos="Or give BL (bottom right), TR (top left) ... (nothing will be TR): "
) else (
	set xpos=%4
) 

if %xpos%=="" (
	set xpos="TR"
)

echo.
echo xpos %xpos% 

rename "%filename%" "%filenamenoext%_old.mp4"


if %xpos%=="TL" (
	set xpos=0.05
	set ypos=0.05
	ffmpeg -stats -loglevel error -i "%filenamenoext%_old.mp4" -vf "drawtext=textfile=temp.txt: fontcolor=white: fontfile='Arial': fontsize=%fontfile='Arial': fontsize%: box=1: boxcolor=Black@0.5:boxborderw=5: x=w*!xpos!:y=h*!ypos!:enable='between(t,%time%)'" -vcodec libx264 -x264-params keyint=24:scenecut=0 -c:a copy "%filename%"
	GOTO :end
)
if %xpos%=="TC" (
	set xpos=0.5
	set ypos=0.05
	ffmpeg -stats -loglevel error -i "%filenamenoext%_old.mp4" -vf "drawtext=textfile=temp.txt: fontcolor=white: fontfile='Arial': fontsize=%fontfile='Arial': fontsize%: box=1: boxcolor=Black@0.5:boxborderw=5: x=((w-text_w)/2):y=h*!ypos!:enable='between(t,%time%)'" -vcodec libx264 -x264-params keyint=24:scenecut=0 -codec:a copy "%filename%"
	GOTO :end
)
if %xpos%=="TR" (
	set xpos=0.95
	set ypos=0.05
	ffmpeg -stats -loglevel error -i "%filenamenoext%_old.mp4" -vf "drawtext=textfile=temp.txt: fontcolor=white: fontfile='Arial': fontsize=%fontfile='Arial': fontsize%: box=1: boxcolor=Black@0.5:boxborderw=5: x=w*!xpos!-text_w:y=h*!ypos!:enable='between(t,%time%)'" -vcodec libx264 -x264-params keyint=24:scenecut=0 -codec:a copy "%filename%"
	GOTO :end
)
if %xpos%=="LC" (
	set xpos=0.05
	set ypos=0.5
	ffmpeg -stats -loglevel error -i "%filenamenoext%_old.mp4" -vf "drawtext=textfile=temp.txt: fontcolor=white: fontfile='Arial': fontsize=%fontfile='Arial': fontsize%: box=1: boxcolor=Black@0.5:boxborderw=5: x=w*!xpos!:y=h*!ypos!:enable='between(t,%time%)'" -vcodec libx264 -x264-params keyint=24:scenecut=0 -codec:a copy "%filename%"
	GOTO :end
)
if %xpos%=="C" (
	set xpos=0.5
	set ypos=0.5
	ffmpeg -stats -loglevel error -i "%filenamenoext%_old.mp4" -vf "drawtext=textfile=temp.txt: fontcolor=white: fontfile='Arial': fontsize=%fontfile='Arial': fontsize%: box=1: boxcolor=Black@0.5:boxborderw=5: x=((w-text_w)/2):y=h*!ypos!:enable='between(t,%time%)'" -vcodec libx264 -x264-params keyint=24:scenecut=0 -codec:a copy "%filename%"
	GOTO :end
)
if %xpos%=="RC" (
	set xpos=0.95
	set ypos=0.5
	ffmpeg -stats -loglevel error -i "%filenamenoext%_old.mp4" -vf "drawtext=textfile=temp.txt: fontcolor=white: fontfile='Arial': fontsize=%fontfile='Arial': fontsize%: box=1: boxcolor=Black@0.5:boxborderw=5: x=w*!xpos!-text_w:y=h*!ypos!:enable='between(t,%time%)'" -vcodec libx264 -x264-params keyint=24:scenecut=0 -codec:a copy "%filename%"
	GOTO :end
)
if %xpos%=="BL" (
	set xpos=0.05
	set ypos=0.95
	ffmpeg -stats -loglevel error -i "%filenamenoext%_old.mp4" -vf "drawtext=textfile=temp.txt: fontcolor=white: fontfile='Arial': fontsize=%fontfile='Arial': fontsize%: box=1: boxcolor=Black@0.5:boxborderw=5: x=w*!xpos!:y=h*!ypos!:enable='between(t,%time%)'" -vcodec libx264 -x264-params keyint=24:scenecut=0 -codec:a copy "%filename%"
	GOTO :end
)
if %xpos%=="BC" (
	set xpos=0.5
	set ypos=0.95
	ffmpeg -stats -loglevel error -i "%filenamenoext%_old.mp4" -vf "drawtext=textfile=temp.txt: fontcolor=white: fontfile='Arial': fontsize=%fontfile='Arial': fontsize%: box=1: boxcolor=Black@0.5:boxborderw=5: x=((w-text_w)/2):y=h*!ypos!:enable='between(t,%time%)'" -vcodec libx264 -x264-params keyint=24:scenecut=0 -codec:a copy "%filename%"
	GOTO :end
)
if %xpos%=="BR" (
	set xpos=0.95
	set ypos=0.95
	ffmpeg -stats -loglevel error -i "%filenamenoext%_old.mp4" -vf "drawtext=textfile=temp.txt: fontcolor=white: fontfile='Arial': fontsize=%fontfile='Arial': fontsize%: box=1: boxcolor=Black@0.5:boxborderw=5: x=w*!xpos!-text_w:y=h*!ypos!:enable='between(t,%time%)'" -vcodec libx264 -x264-params keyint=24:scenecut=0 -codec:a copy "%filename%"
	GOTO :end
) else (
	set /p ypos="Give me your y position (0.1 will be on the top, 0.9 will be on the bottom): "
)




ffmpeg -stats -loglevel error -i "%filenamenoext%_old.mp4" -vf "drawtext=textfile=temp.txt: fontcolor=white: fontfile='Arial': fontsize=%fontfile='Arial': fontsize%: box=1: boxcolor=Black@0.5:boxborderw=5: x=w*0.5:y=h*0.5:enable='between(t,%time%)'" -vcodec libx264 -x264-params keyint=24:scenecut=0 -codec:a copy "%filename%"


:end

del temp.txt


:: souLCe https://stackoverflow.com/questions/17623676/text-on-video-ffmpeg
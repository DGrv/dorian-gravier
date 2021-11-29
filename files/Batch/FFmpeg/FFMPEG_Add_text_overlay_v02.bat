@echo off
SeTRocal EnableDelayedExpansion

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


set /p pathfile="Give me the Video path: "
set pathnew=%pathfile:.mp4=%

set /p time="At which time to start and stop (in form of 'start,stop', e.g '0,20'): "
set /p text="Give me you text: "
set /p fontsize="Give me your fontsize (TLy big first, maybe 50): "

REM echo pathnew : %pathnew%

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
set /p xpos="Or give BL (bottom right), TR (top left) ... : "

echo.
echo xpos %xpos% 


if "%xpos%"=="TL" (
	set xpos=0.05
	set ypos=0.05
	ffmpeg -stats -loglevel error -i "%pathfile%" -vf drawtext="text='%text%': fontcolor=white: fontsize=%fontsize%: box=1: boxcolor=Black@0.5:boxborderw=5: x=w*!xpos!:y=h*!ypos!:enable='between(t,%time%)'" -c:a copy "%pathnew%_new.mp4"
	GOTO :EOF
)
if "%xpos%"=="TC" (
	set xpos=0.5
	set ypos=0.05
	ffmpeg -stats -loglevel error -i "%pathfile%" -vf drawtext="text='%text%': fontcolor=white: fontsize=%fontsize%: box=1: boxcolor=Black@0.5:boxborderw=5: x=((w-text_w)/2):y=h*!ypos!:enable='between(t,%time%)'" -codec:a copy "%pathnew%_new.mp4"
	GOTO :EOF
)
if "%xpos%"=="TR" (
	set xpos=0.95
	set ypos=0.05
	ffmpeg -stats -loglevel error -i "%pathfile%" -vf drawtext="text='%text%': fontcolor=white: fontsize=%fontsize%: box=1: boxcolor=Black@0.5:boxborderw=5: x=w*!xpos!-text_w:y=h*!ypos!:enable='between(t,%time%)'" -codec:a copy "%pathnew%_new.mp4"
	GOTO :EOF
)
if "%xpos%"=="LC" (
	set xpos=0.05
	set ypos=0.5
	ffmpeg -stats -loglevel error -i "%pathfile%" -vf drawtext="text='%text%': fontcolor=white: fontsize=%fontsize%: box=1: boxcolor=Black@0.5:boxborderw=5: x=w*!xpos!:y=h*!ypos!:enable='between(t,%time%)'" -codec:a copy "%pathnew%_new.mp4"
	GOTO :EOF
)
if "%xpos%"=="C" (
	set xpos=0.5
	set ypos=0.5
	ffmpeg -stats -loglevel error -i "%pathfile%" -vf drawtext="text='%text%': fontcolor=white: fontsize=%fontsize%: box=1: boxcolor=Black@0.5:boxborderw=5: x=((w-text_w)/2):y=h*!ypos!:enable='between(t,%time%)'" -codec:a copy "%pathnew%_new.mp4"
	GOTO :EOF
)
if "%xpos%"=="RC" (
	set xpos=0.95
	set ypos=0.5
	ffmpeg -stats -loglevel error -i "%pathfile%" -vf drawtext="text='%text%': fontcolor=white: fontsize=%fontsize%: box=1: boxcolor=Black@0.5:boxborderw=5: x=w*!xpos!-text_w:y=h*!ypos!:enable='between(t,%time%)'" -codec:a copy "%pathnew%_new.mp4"
	GOTO :EOF
)
if "%xpos%"=="BL" (
	set xpos=0.05
	set ypos=0.95
	ffmpeg -stats -loglevel error -i "%pathfile%" -vf drawtext="text='%text%': fontcolor=white: fontsize=%fontsize%: box=1: boxcolor=Black@0.5:boxborderw=5: x=w*!xpos!:y=h*!ypos!:enable='between(t,%time%)'" -codec:a copy "%pathnew%_new.mp4"
	GOTO :EOF
)
if "%xpos%"=="BC" (
	set xpos=0.5
	set ypos=0.95
	ffmpeg -stats -loglevel error -i "%pathfile%" -vf drawtext="text='%text%': fontcolor=white: fontsize=%fontsize%: box=1: boxcolor=Black@0.5:boxborderw=5: x=((w-text_w)/2):y=h*!ypos!:enable='between(t,%time%)'" -codec:a copy "%pathnew%_new.mp4"
	GOTO :EOF
)
if "%xpos%"=="BR" (
	set xpos=0.95
	set ypos=0.95
	ffmpeg -stats -loglevel error -i "%pathfile%" -vf drawtext="text='%text%': fontcolor=white: fontsize=%fontsize%: box=1: boxcolor=Black@0.5:boxborderw=5: x=w*!xpos!-text_w:y=h*!ypos!:enable='between(t,%time%)'" -codec:a copy "%pathnew%_new.mp4"
	GOTO :EOF
) else (
	set /p ypos="Give me your y position (0.1 will be on the top, 0.9 will be on the bottom): "
)




ffmpeg -stats -loglevel error -i "%pathfile%" -vf drawtext="text='%text%': fontcolor=white: fontsize=%fontsize%: box=1: boxcolor=Black@0.5:boxborderw=5: x=w*%xpos%:y=h*%ypos%:enable='between(t,%time%)'" -codec:a copy "%pathnew%_new.mp4"

:end


:: souLCe https://stackoverflow.com/questions/17623676/text-on-video-ffmpeg
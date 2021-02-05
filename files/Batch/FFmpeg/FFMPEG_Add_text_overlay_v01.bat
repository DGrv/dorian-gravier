@echo off
SetLocal EnableDelayedExpansion

echo Created by Dorian Gravier
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

echo pathnew : %pathnew%

set /p xpos="Give me your x position in fraction (0.1 will be on the left, 0.9 will be on the right): "
set /p ypos="Give me your y position in fraction (0.1 will be on the top, 0.9 will be on the bottom): "


set /p text="Give me you text: "
set /p fontsize="Give me your fontsize (try big first, maybe 50): "


ffmpeg -i %pathfile% -vf drawtext="text='%text%': fontcolor=white: fontsize=%fontsize%: box=1: boxcolor=black@0.5:boxborderw=5: x=w*%xpos%:y=h*%ypos%" -codec:a copy %pathnew%_new.mp4


:: source https://stackoverflow.com/questions/17623676/text-on-video-ffmpeg
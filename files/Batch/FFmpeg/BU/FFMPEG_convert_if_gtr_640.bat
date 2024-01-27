@echo off
SetLocal EnableDelayedExpansion

set widthuser=640


for /r %%p in (*mp4) do (
	for /f %%g in ('ffprobe -v error -select_streams v -show_entries stream^=width -of csv^=p^=0:s^=x "%%p"') do set /a width=%%g
	echo [91mSkip %%p  [37m
	if !width! GTR %widthuser% (
		rename %%p %%~np_temp.mp4
		echo [94mConvert %%p  [37m
		REM echo %%p
		REM echo %%~dp%%~pp%%~np
		ffmpeg -stats -loglevel error  -i "%%~dp%%~pp%%~np_temp.mp4" -vcodec libx264 -vf "scale=%widthuser%:-2" -preset slow "%%p"
		del "%%~dp%%~pp%%~np_temp.mp4"
	)
)

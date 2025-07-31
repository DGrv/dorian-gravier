@echo off
SetLocal EnableDelayedExpansion

:: Loop over video files

set cdd=%CD%

REM Start.mp4 Countdown.mp4 GetReady.mp4
for %%F in (Start1.mp4 Start2.mp4 Countdown.mp4 GetReady.mp4) do (

	set newdir=%%~nF
    set outmp4=%%~nF_crop.mp4
    set outgif=%%~nF_crop.gif
	
	:: CROP ----------------------------------------------------------------------------------------------------------------------------------------
	ffmpeg -i "%%F" -vf "crop=3840:551:0:805" -c:a copy -y "!outmp4!"
   
)





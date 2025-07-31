@echo off
SetLocal EnableDelayedExpansion

:: Loop over video files

set cdd=%CD%

for %%F in (Start1.mp4 Start2.mp4 Countdown.mp4 GetReady.mp4) do (
REM for %%F in (Countdown.mp4) do (

	set newdir=%%~nF
    set outmp4=%%~nF_crop.mp4
    set outgif=%%~nF.gif
	
	pushd "!newdir!"
	
	echo %%F
	:: Create the gif  ----------------------------------------------------------------------------------------------------------------------------------------
	magick -delay 4 -loop 0 -dispose previous frame_*.png !outgif!
	copy /Y !outgif! %cdd%
	
	popd
   
)





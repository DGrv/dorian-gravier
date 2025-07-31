@echo off
SetLocal EnableDelayedExpansion

:: Loop over video files

set cdd=%CD%

REM Start.mp4 Countdown.mp4 GetReady.mp4
for %%F in (Start1.mp4 Start2.mp4 Countdown.mp4 GetReady.mp4) do (

	set newdir=%%~nF
	mkdir !newdir!
    set outmp4=%%~nF_crop.mp4
    set outgif=%%~nF_crop.gif
	
	:: CROP ----------------------------------------------------------------------------------------------------------------------------------------
	REM ffmpeg -i "%%F" -vf "crop=3840:549:0:805" -c:a copy "!outmp4!"
	
	:: Export 25 fps png  ----------------------------------------------------------------------------------------------------------------------------------------
	ffmpeg -stats -loglevel error -i "!outmp4!" -vf "fps=25,format=yuva420p" "!newdir!\frame_%%03d.png"

   
)





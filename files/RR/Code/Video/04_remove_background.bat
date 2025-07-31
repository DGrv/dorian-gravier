@echo off
SetLocal EnableDelayedExpansion

:: Store current directory
set cdd=%CD%

REM Loop over video files Start1.mp4 and Start2.mp4
for %%F in (Start1.mp4 Start2.mp4) do (

    set newdir=%%~nF
    set outmp4=%%~nF_crop.mp4
    set outgif=%%~nF_crop.gif

    pushd "!newdir!"

    :: Remove black background from each PNG in the folder
    for %%D in (*.png) do (
        echo Processing %%D ...
        magick "%%D" ^( -clone 0 -fill black -colorize 100 ^) ^
               ^( -clone 0,1 -compose difference -composite -separate +channel -evaluate-sequence max -auto-level ^) ^
               -delete 1 -alpha off -compose copy_opacity -composite "%%D"
    )

    popd
)

EndLocal

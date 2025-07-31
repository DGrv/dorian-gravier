@echo off
SetLocal EnableDelayedExpansion

:: Loop over video files

set "cdd=%CD%"

REM Start1.mp4 Start2.mp4 Countdown.mp4 GetReady.mp4
for %%F in (Start1.mp4 Start2.mp4 Countdown.mp4 GetReady.mp4) do (

    set "newdir=%%~nF"
    set "outmp4=%%~nF_crop.mp4"
    set "outgif=%%~nF_crop.gif"

    pushd "!newdir!"

    REM Example call
    REM python ...\remove_duplicates_pictures_in_folder_v02.py

    :: Manual filtering of frames
    if "%%F"=="Start1.mp4" (
        for %%G in (frame_*.png) do (
            set "g=%%~nG"
            call set "num=%%g:~6%%"
            if !num! gtr 047 del "%%G"
        )

        for %%G in (frame_*.png) do (
            set "g=%%~nG"
            call set "num=%%g:~6%%"
            if !num! lss 009 del "%%G"
        )
    )

    if "%%F"=="Start2.mp4" (
        for %%G in (frame_*.png) do (
            set "g=%%~nG"
            call set "num=%%g:~6%%"
            if !num! gtr 022 del "%%G"
        )
    )

    if "%%F"=="GetReady.mp4" (
        for %%G in (frame_*.png) do (
            set "g=%%~nG"
            call set "num=%%g:~6%%"
            if !num! gtr 025 del "%%G"
        )
    )

    if "%%F"=="Countdown.mp4" (
        for %%G in (frame_*.png) do (
            set "g=%%~nG"
            call set "num=%%g:~6%%"
            if !num! gtr 253 del "%%G"
        )
    )

    popd
)


---
title: "ffmpeg"
permalink: /code/ffmpeg/
toc: true
layout: code
author_profile: false
---


# Record screen and audio

```batchfile
ffmpeg -list_devices true -f dshow -i dummy
```

You will get information on your micro e.g.:

``` console
[dshow @ 0000023325be21c0] DirectShow video devices (some may be both video and audio devices)
[dshow @ 0000023325be21c0]  "Integrated Camera"
[dshow @ 0000023325be21c0]     Alternative name "@device_pnp_\\?\usb#vid_0bda&pid_5719&mi_00#6&2f2aea22&0&0000#{65e8773d-8f56-11d0-a3b9-00a0c9223196}\global"
[dshow @ 0000023325be21c0] DirectShow audio devices
[dshow @ 0000023325be21c0]  "Internal Microphone (Conexant 20751 SmartAudio HD)"
[dshow @ 0000023325be21c0]     Alternative name "@device_cm_{33D9A762-90C8-11D0-BD43-00A0C911CE86}\wave_{282C5434-3354-4349-88E3-F7A5AD9ABD8B}"
```

Copy the \*\*@device_cm\_{33D9A762-90C8-11D0-BD43-00A0C911CE86}\_{282C5434-3354-4349-88E3-F7A5AD9ABD8B}\*\*

```batchfile
ffmpeg -f gdigrab -framerate 24 -i desktop -f dshow -i audio="@device_cm_{33D9A762-90C8-11D0-BD43-00A0C911CE86}\wave_{282C5434-3354-4349-88E3-F7A5AD9ABD8B}" output.mp4
```

Stop with ctrl-c.

Batch file to automate it : *v02*

```batchfile
@echo off






:: ---------- User input ----------

set /p xp=Are you on XP ? (0: NO, 1: Yes) :
set /p audio=Do you want to record audio ? (0: NO, 1: Yes) :




:: ---------- Find Time ----------
set hour=%time:~0,2%
if "%hour:~0,1%" == " " set hour=0%hour:~1,1%
set min=%time:~3,2%
if "%min:~0,1%" == " " set min=0%min:~1,1%
::set secs=%time:~6,2%
::if "%secs:~0,1%" == " " set secs=0%secs:~1,1%

set year=%date:~-4%
set month=%date:~-7,2%
if "%month:~0,1%" == " " set month=0%month:~1,1%
set day=%date:~-10,2%
if "%day:~0,1%" == " " set day=0%day:~1,1%


set datetimef=%year%%month%%day%%hour%%min%

:: ---------- Start ----------
echo Batch script to record screen and audio

if %audio%==1  (
    ffmpeg -list_devices true -f dshow -i dummy
    echo.
    echo.
    echo Copy the alternative name of your microphone:
    echo Example : @device_cm_{33D9A762-90C8-11D0-BD43-00A0C911CE86}\wave_{4286150F-8585-41D6-BA56-49CFB8009DDA}
    echo.
    set /p micro="Paste it here : "
    echo.
)


set /p framer="Which frame rate per second do you want ? "


echo.
echo.
echo Type CTRL-C to stop the recording.
echo The recording will be stop and you will be asked if you want to terminate the batch job Y/N, choose N.
echo The video will be created in the same folder as the batch file and a reduze resolution will be created.
echo.
set /p info=Type Enter to continue



if %audio%==1  (
    if %xp%==1 (
        ffmpeg -f gdigrab -framerate %framer% -i desktop -f dshow -i audio="%micro%" %datetimef%_ScreenCapture.mkv
        ffmpeg -i %datetimef%_ScreenCapture.mkv -vbr 3 -vf "scale=720:-2" -preset slow -crf 18 %datetimef%_ScreenCapture_low.mkv
    ) ELSE (
        ffmpeg -f gdigrab -framerate %framer% -i desktop -f dshow -i audio="%micro%" %datetimef%_ScreenCapture.mp4
        ffmpeg -i %datetimef%_ScreenCapture.mp4 -vcodec libx264 -vbr 3 -vf "scale=720:-2" -preset slow -crf 18 %datetimef%_ScreenCapture_low.mp4
    )
) else (
    if %xp%==1 (
        ffmpeg -f gdigrab -framerate %framer% -i desktop %datetimef%_ScreenCapture.mkv
        ffmpeg -i %datetimef%_ScreenCapture.mkv -vbr 3 -vf "scale=720:-2" -preset slow -crf 18 %datetimef%_ScreenCapture_low.mkv
    ) ELSE (
        ffmpeg -f gdigrab -framerate %framer% -i desktop %datetimef%_ScreenCapture.mp4
        ffmpeg -i %datetimef%_ScreenCapture.mp4 -vcodec libx264 -vbr 3 -vf "scale=720:-2" -preset slow -crf 18 %datetimef%_ScreenCapture_low.mp4
    )
)
```

# Record screen and convert into gif

Here a small example of how to record your screen, resize the video and create from it a gif.

```batchfile
    ffmpeg -f gdigrab -framerate 24 -i desktop screen.mp4
    ffmpeg -i screen.mp4 -vcodec libx264 -vbr 3 -vf "scale=640:-2" -preset fast -crf 23 screen640.mp4
    ffmpeg -y -i screen640.mp4 -vf palettegen palette.png
    ffmpeg -y -i screen640.mp4 -i palette.png -filter_complex paletteuse -r 20 screen640.gif
```

Via a batch file (you will have to modify it depending on your needs): *v02*

```batchfile
    @echo off

    :: ---------- Find Time ----------
    set hour=%time:~0,2%
    if "%hour:~0,1%" == " " set hour=0%hour:~1,1%
    set min=%time:~3,2%
    if "%min:~0,1%" == " " set min=0%min:~1,1%
    ::set secs=%time:~6,2%
    ::if "%secs:~0,1%" == " " set secs=0%secs:~1,1%

    set year=%date:~-4%
    set month=%date:~-7,2%
    if "%month:~0,1%" == " " set month=0%month:~1,1%
    set day=%date:~-10,2%
    if "%day:~0,1%" == " " set day=0%day:~1,1%

    set datetimef=%year%%month%%day%%hour%%min%

    :: ---------- Start ----------
    echo Batch script to record screen and create a gif

    set framer=24

    ffmpeg -f gdigrab -framerate %framer% -i desktop %datetimef%_ScreenCapture.mp4
    ffmpeg -i %datetimef%_ScreenCapture.mp4 -vcodec libx264 -vbr 3 -vf "scale=640:-2" -preset fast -crf 23 %datetimef%_ScreenCapture640.mp4
    ffmpeg -y -i %datetimef%_ScreenCapture640.mp4 -vf palettegen palette.png
    ffmpeg -y -i %datetimef%_ScreenCapture640.mp4 -i palette.png -filter_complex paletteuse -r 20 %datetimef%_ScreenCapture640.gif
    del palette.png
    del %datetimef%_ScreenCapture.mp4

```

# Add variable to system variable PATH (Windows)

The first version of this batch file was pretty simple:

- ask user which path to add
- add it

The problem is that I realized that it was creating duplicates, and rapidly your system variable PATH is full. I then created a version which would delete duplicated lines.

Version: *v04*

```batchfile
:: Code ----------------------------------------------------------------------------
@echo off
setlocal enableDelayedExpansion


set /p pathwanted="Path you wanna add to the PATH variable: "

echo Do you really want this path added : %pathwanted% ?
echo.
echo To this actual path :
echo. %path%
pause


:: get path and write file with replace ; as LF
set path2=%path%;%pathwanted%
echo %path% > BUpath.txt
for %%a in ("%path2:;=" "%") do echo %%~a >> temp2.txt


:: sort files
setlocal disableDelayedExpansion
set "file=temp2.txt"
set "sorted=%file%.sorted"
set "deduped=%file%.deduped"
::Define a variable containing a linefeed character
set LF=^


::The 2 blank lines above are critical, do not remove
sort "%file%" > "%sorted%"
>"%deduped%" (
  set "prev="
  for /f usebackq^ eol^=^%LF%%LF%^ delims^= %%A in ("%sorted%") do (
    set "ln=%%A"
    setlocal enableDelayedExpansion
    if /i "!ln!" neq "!prev!" (
      endlocal
      (echo %%A)
      set "prev=%%A"
    ) else endlocal
  )
)
>nul move /y "%deduped%" "%file%"
del "%sorted%"
:: end sort file


(set all=)
FOR /f "delims=" %%x IN (temp2.txt) DO call SET all=%%all%%;%%x
set all="%all%;"
set all=%all: ;=;%
set all=%all:~1,20000%

:: remove the '%all%; in the string
echo %all% > NEWpath.txt
echo %all%

setx path %all%
del temp2.txt

```

# Right click delete fast a folder (do not have to wait to continue to work)

Copy those lines in a .txt file and save it as a .reg. Run it to add this Registry key. This key will allow you to have a new menu when you right click on a folder to delete it fast. The advantage is that is faster that the normal deleting method from windows and it will keep your explorer free to be used (useful for huge folder).

![](/files/gif/Fast_delete.gif)

```
    Windows Registry Editor Version 5.00

    [HKEY_CLASSES_ROOT\Directory\shell\Fast_delete\command]
    @="cmd /c \"cd \"%1\" && DEL /F/Q/S \"%1\" > NUL && RMDIR /Q/S \"%1\"\""
```

Source :

- [ghacks](https://www.ghacks.net/2017/07/18/how-to-delete-large-folders-in-windows-super-fast/#comment-4408088)
- [superuser](https://superuser.com/questions/19762/mass-deleting-files-in-windows/289399#289399)

# Record from Camera


```sh
@echo off

FOR /F %%A IN ('WMIC OS GET LocalDateTime ^| FINDSTR \.') DO @SET time=%%A
set TIMESTAMP=%time:~0,8%-%time:~8,6%


REM start "Camera recording" cmd /k "echo Recording camera in C:\Users\BernhardSchad\Desktop\Camera\Camera_192.168.1.207__%TIMESTAMP%.mp4 && echo Use ctrl+c 2 times to stop recording or close the window && echo. && ffmpeg -stats -loglevel error -y -i "rtsp://root:system@192.168.1.207/axis-media/media.amp" -vcodec libx264 C:\Users\BernhardSchad\Desktop\Camera\Camera_192.168.1.207__%TIMESTAMP%.mp4"


mpv rtsp://root:system@192.168.1.207/axis-media/media.amp --stream-record="C:\Users\...\Desktop\Camera\Camera_192.168.1.207_____%TIMESTAMP%.mp4" --osd-msg1="\n\nRecording .... close window to stop\nShift+T to keep on top" --force-seekable=yes --hr-seek=yes --hr-seek-framedrop=yes --cache=no

```



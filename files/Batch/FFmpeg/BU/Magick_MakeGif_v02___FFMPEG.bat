@echo off

systeminfo | findstr /B /C:"OS Name" /C:"OS Version" | find /i "XP" > NUL && set ver=XP || set ver=other

:: ---------- User input ----------

set audio=0

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

if exist H:\ (
	H:
	set drive=H:
) else (
	X:
	set drive=X:
)
if %ver%==XP (
	set ffmpegpath=%drive%\TEMP\Software\FFmpeg\ffmpeg-3.4.1\ffmpeg.exe
	set ext=mkv
) else (
	set ffmpegpath=%drive%\TEMP\Software\FFmpeg\ffmpeg-4.0.2-win32-static\bin\ffmpeg.exe
	set ext=mp4
)

echo .
echo ----------------------------------------------------
echo DEBUG variable
echo ----------------------------------------------------
echo drive %drive%
echo ext %ext%
echo ffmpegpath %ffmpegpath%
echo .
echo ----------------------------------------------------

%ffmpegpath% -f gdigrab -framerate %framer% -i desktop %datetimef%_ScreenCapture.%ext%
%ffmpegpath% -i %datetimef%_ScreenCapture.%ext% -vcodec libx265 -vbr 3 -vf "scale=640:-2" -preset fast -crf 23 %datetimef%_ScreenCapture640.%ext%
%ffmpegpath% -y -i %datetimef%_ScreenCapture640.%ext% -vf palettegen palette.png
%ffmpegpath% -y -i %datetimef%_ScreenCapture640.%ext% -i palette.png -filter_complex paletteuse -r 20 %datetimef%_ScreenCapture640.gif
del palette.png
del %datetimef%_ScreenCapture.%ext%







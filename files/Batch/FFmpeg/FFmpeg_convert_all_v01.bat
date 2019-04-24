@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

set ffmpegpath=H:\TEMP\Software\FFmpeg\ffmpeg-4.0.2-win32-static\bin\ffmpeg.exe

set /p reso=Which resolution do you want ? (480, 640, 720, 1024 ...) ? 

:: file choose and get dir
set dialog="about:<input type=file id=FILE><script>FILE.click();new ActiveXObject
set dialog=%dialog%('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(FILE.value);
set dialog=%dialog%close();resizeTo(0,0);</script>"

for /f "tokens=* delims=" %%p in ('mshta.exe %dialog%') do set "input=%%p"
for /F %%i in ("%input%") do @set dir=%%~dpi
for /F %%i in ("%input%") do @set drive=%%~di

echo [DEBUG] - Drive: %drive%, Dir: %dir%


%drive%
pwd
cd "%dir%"
pwd

for %%i in (*.mp4) do (
	%ffmpegpath% -i %%i -vcodec libx264 -vbr 3 -vf "scale=%reso%:-2" -preset fast -crf 23 %%~ni_low.mp4
)


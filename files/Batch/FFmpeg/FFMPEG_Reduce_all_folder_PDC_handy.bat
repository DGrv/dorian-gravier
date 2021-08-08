@echo off
SetLocal EnableDelayedExpansion

::set ffmpegpath=H:\TEMP\Software\FFmpeg\ffmpeg-4.0.2-win32-static\bin\ffmpeg.exe
set /p folder="Where are your mp4 ?   " 
echo %folder%
cd "%folder%"

for %%i in (*.mp4) do (
	ffmpeg -stats -loglevel error -i "%%i" -vcodec libx264 -vf "scale=480:-2" -preset slow -crf 30 -acodec aac -ar 48000 -video_track_timescale 24000 "%%~ni_Handy.mp4"
)

@echo off
SetLocal EnableDelayedExpansion

echo Created by Dorian Gravier
echo Will create a title clip for your video depending on how many lines you wish.

echo.
set /p sec="How many seconds should be the clip: "

ffmpeg -stats -loglevel error  -f lavfi -i color=c=black:s=2704x1520:d=%sec% -video_track_timescale 24000 temp.mp4
ffmpeg -stats -loglevel error  -i temp.mp4 -f lavfi -i aevalsrc=0 -shortest -y temp2.mp4
ffmpeg -stats -loglevel error  -i temp2.mp4 -ar 48000 -video_track_timescale 24000 black_title_clip_%sec%sec.mp4

del temp.mp4
del temp2.mp4

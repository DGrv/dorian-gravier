@echo off
SetLocal EnableDelayedExpansion

echo Created by Dorian Gravier
echo Will create a title clip for your video depending on how many lines you wish.

echo.
set /p sec="How many seconds should be the clip: "

ffmpeg -stats -loglevel error  -f lavfi -i color=c=black:s=2704x1520:d=%sec% -video_track_timescale 24000 temp.mp4
ffmpeg -stats -loglevel error  -i temp.mp4 -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=48000 -video_track_timescale 24000 -shortest -y black_title_clip_%sec%sec.mp4

del temp.mp4

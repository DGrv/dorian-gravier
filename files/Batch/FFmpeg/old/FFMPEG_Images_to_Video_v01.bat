@echo off
::SetLocal EnableDelayedExpansion


echo "--------------------------------------------------------------------------------"
echo "   _____             _                _____                 _                   "
echo "  |  __ \           (_)              / ____|               (_)                  "
echo "  | |  | | ___  _ __ _  __ _ _ __   | |  __ _ __ __ ___   ___  ___ _ __         "
echo "  | |  | |/ _ \| '__| |/ _` | '_ \  | | |_ | '__/ _` \ \ / / |/ _ \ '__|        "
echo "  | |__| | (_) | |  | | (_| | | | | | |__| | | | (_| |\ V /| |  __/ |           "
echo "  |_____/ \___/|_|  |_|\__,_|_| |_|  \_____|_|  \__,_| \_/ |_|\___|_|           "
echo "                                                                                "
echo "--------------------------------------------------------------------------------"
REM http://www.network-science.de/ascii/
echo.


echo Script which will create from images a video.
echo Please prepare the images that they are 'jpg' format and rename in order: pic001.jpg bis number you want.
echo Make a backup of those images because they will be modified to fit the resolution you want.
echo Move them in a folder with only those images.
echo.
echo.

set /p pathfiles="Where are your images (give me a folder - then check standard name or give me a jpg path): "
set /p reso="Which resolution do you want (e.g. give 1920x1080 or type y to choose the default one (this one)): "
set /p fr="How many seconds each image should be shown (e.g. 5): "

if "%reso%"=="y" (
	set reso=1920x1080
)

if "%pathfiles:~-3%"=="jpg" GOTO singlefile
if "%pathfiles:~-3%"=="peg" GOTO singlefile



cd "%pathfiles%"

mogrify -resize %reso% -extent %reso% -gravity Center -background black *.jpg

REM DO NOT USE :
REM ffmpeg -r 1/%fr% -f image2 -i pic%%03d.jpg -vf "scale=2*trunc(iw/2*3):-2,format=yuv420p" -video_track_timescale 24000 -vcodec libx264 -crf 25  temp.mp4
REM ffmpeg -r 1/%fr% -f image2 -i pic%%03d.jpg -vf "scale=1920:-1,format=yuv420p" -video_track_timescale 24000 -vcodec libx264 -crf 25 temp.mp4
REM ffmpeg -f lavfi -i aevalsrc=0 -i temp.mp4 -c:v copy -c:a aac -map 0 -map 1:v -shortest -ar 48000 -video_track_timescale 24000 output_img_to_video_%fr%sec.mp4


ffmpeg -r 1/%fr% -f image2 -i pic%%03d.jpg -vcodec libx264 -vf "fps=25,format=yuv420p" temp.mp4
REM Add silence
ffmpeg -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=48000 -i temp.mp4 -c:v copy -c:a aac -video_track_timescale 24000 -shortest output_img_to_video_%fr%sec.mp4

GOTO end

:singlefile

mogrify -resize %reso% -extent %reso% -gravity Center -background black *.jpg
ffmpeg -r 1/%fr% -f image2 -i "%pathfiles%" -vcodec libx264 -vf "fps=25,format=yuv420p" temp.mp4
ffmpeg -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=48000 -i temp.mp4 -c:v copy -c:a aac -video_track_timescale 24000 -shortest output_img_to_video_%fr%sec.mp4



:end
del temp.mp4

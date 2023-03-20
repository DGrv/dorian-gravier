@echo off
SetLocal EnableDelayedExpansion


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

where mogrify
IF %ERRORLEVEL% NEQ 0 (
	echo "[DEBUG] - mogrify is unknown, please add it to the PATH
)
where ffmpeg
IF %ERRORLEVEL% NEQ 0 (
	echo "[DEBUG] - ffmpeg is unknown, please add it to the PATH
)

echo.
echo.

echo [INFO] Please prepare the images that they are 'jpg' format and rename in order: pic001.jpg bis number you want.
echo Are you sure you pictures are well orientated (take care it will resize your original images) ?
echo.

if "%~1"=="" (
	set /p pathfiles="Where are your images (give me a folder or a single file - then check standard name or give me a jpg path): "
) else (
	set pathfiles=%~1
)

if "%~2"=="" (
	set /p reso="Which resolution do you want (e.g. give 1920x1080 or type y to choose the default one (this one)): "
) else (
	set reso=%~2
)

if "%~3"=="" (
	set /p fr="How many seconds each image should be shown (e.g. 5): "
) else (
	set fr=%~3
)




if "%reso%"=="y" (
	set reso=1920x1080
)


cd "%pathfiles%"

:: if a single pathfile 
if "%pathfiles:~-3%"=="jpg" GOTO singlefile
if "%pathfiles:~-3%"=="peg" GOTO singlefile




magick mogrify -resize %reso% -extent %reso% -gravity Center -background black *.jpg
:: detect if landscape 
:: BUT magick does not recognize the real width and height
REM for %%A in (*.jpg) do (
	REM magick convert %%A -format "%%[fx:w/h]" info: > temp
	REM set port =< temp
	REM echo port=!port!
	REM echo.
	REM echo.
	REM echo.
	REM echo.
	REM if !port! LSS 1 (
		REM magick convert -rotate "90" %%A
	REM )
REM )

REM DO NOT USE :
REM ffmpeg -r 1/%fr% -f image2 -i pic%%03d.jpg -vf "scale=2*trunc(iw/2*3):-2,format=yuv420p" -video_track_timescale 24000 -vcodec libx265 -crf 25  temp.mp4
REM ffmpeg -r 1/%fr% -f image2 -i pic%%03d.jpg -vf "scale=1920:-1,format=yuv420p" -video_track_timescale 24000 -vcodec libx265 -crf 25 temp.mp4
REM ffmpeg -f lavfi -i aevalsrc=0 -i temp.mp4 -c:v copy -c:a aac -map 0 -map 1:v -shortest -ar 48000 -video_track_timescale 24000 output_img_to_video_%fr%sec.mp4


ffmpeg -r 1/%fr% -f image2 -i pic%%3d.jpg -vcodec libx265 -vf "fps=25,format=yuv420p" temp.mp4
REM Add silence
ffmpeg -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=48000 -i temp.mp4 -c:v copy -c:a aac -video_track_timescale 24000 -shortest output_img_to_video_%fr%sec.mp4
del temp.mp4

GOTO end

:singlefile

magick mogrify -resize %reso% -extent %reso% -gravity Center -background black "%pathfiles%"
ffmpeg -r "1/%fr%" -f image2 -i "%pathfiles%" -vcodec libx265 -vf "fps=25,format=yuv420p" "%pathfiles%.mp4"
echo dasfsdf

ffmpeg -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=48000 -i "%pathfiles%.mp4" -c:v copy -c:a aac -video_track_timescale 24000 -shortest "%pathfiles%_new.mp4"

del "%pathfiles%.mp4"


:end

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

echo Will add text overlay where you want on your video


	echo.
	echo Your ffmpeg is here:
	WHERE ffmpeg
	IF %ERRORLEVEL% NEQ 0 (
		echo "[DEBUG] - ffmpeg command is unknown, please add it to the PATH
	)
	echo.


set /p pathfolder="Give me the folder where the pictures are (jpg): "
set /p info="Please rename them with 4 digits : 0001.jpg and so on... Should also start at 1 !!! (type enter to continue)"
echo.

set /p fps="How much frame per second do you want (usually 20 to 100): "
echo.
echo ---- Resize -----
set /p resize="Do you want to resize it [y/n]: "
if "%resize%"=="y" (
	echo.
	echo Common resolution in	16:9:
	echo      1920x1080 Full HD
	echo      1280x720 HD
	echo      1024x576 Pall
	echo      720x405
	echo      480x270 
	echo.
	set /p w="Which width (1024, 1920 ...): 
	echo.
	echo ---- Crop -----
	set /p crop="Do you wanna crop to a certain height [y/n]: "
	if "!crop!"=="y" (
		set /p h="Which height: "
	)
)
echo.
echo.



cd %pathfolder%

REM Keyframes are Adjusted every 2 seconds
if "%resize%"=="y" (
	ffmpeg -stats -loglevel error -f image2 -i "%%04d.jpg" -r %fps% -vf "scale=%w%:-2" -vcodec libx264 -x264-params keyint=48:scenecut=0 -vprofile baseline -level 3.0 -pix_fmt yuv420poutput1.mp4
	if "%crop%"=="y" (
		ffmpeg -i output1.mp4 -filter:v "crop=%w%:%h%" output2.mp4
	) else (
		rename output1.mp4 output2.mp4
	)
) else (
	ffmpeg -stats -loglevel error -f image2 -i "%%04d.jpg" -r %fps% -vcodec libx264 -x264-params keyint=48:scenecut=0 -vprofile baseline -level 3.0 -pix_fmt yuv420p output2.mp4
)
echo.
echo.
echo You can check the first step !
echo.
echo.
REM Add silence
ffmpeg -stats -loglevel error -i output2.mp4 -f lavfi -i aevalsrc=0 -shortest -y -ar 48000 -vcodec libx264 -x264-params keyint=48:scenecut=0 -video_track_timescale 24000 output3.mp4
REM if not working remove this part -vcodec libx264 -x264-params keyint=48:scenecut=0 


:end



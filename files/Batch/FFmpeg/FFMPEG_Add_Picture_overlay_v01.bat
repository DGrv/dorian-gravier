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



set /p input="Give me the path of your VIDEO file: "
set output=%input:.mp4=%
set /p inputp="Give me the path of your picture file: "
set /p time="At which time to start and stop (in form of 'start,stop', e.g '0,20'): "

where ffmpeg
if errorlevel 0 (
	echo.
	echo.
	ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 "%input%" > temp
	set /p reso=<temp
	del temp
	echo Your video resolution is !reso!
	echo.
)

set /p position="At which position (e.g. '25:25' meaning 25 pixel from each side, left top corner, if you need right bottom use 'W-w:H-h', with W width of video and w width of image, you can also use e.g. 1350-(w/2):300-(h/2) ): "

echo.
echo.
echo ffmpeg -stats -loglevel error -i "%input%" -i "%inputp%" -filter_complex "[1:v]setpts=PTS-STARTPTS+(1/TB)[1v];[0:v][1v] overlay=%position%:enable='between(t,%time%)'" -c:a copy "%output%_pic.mp4"
echo.
echo.

ffmpeg -stats -loglevel error -i "%input%" -i "%inputp%" -filter_complex "[1:v]setpts=PTS-STARTPTS+(1/TB)[1v];[0:v][1v] overlay=%position%:enable='between(t,%time%)'" -c:a copy "%output%_pic.mp4"

REM https://stackoverflow.com/questions/37144225/overlaying-alpha-images-on-a-video-using-ffmpeg
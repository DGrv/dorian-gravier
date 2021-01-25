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

	
echo.
echo -------------------------------------------------
echo INFO - Start Fade in and out, need re-encoding
echo.

set /p input="Give me the path of your VIDEO file: "
set output=%input:.mp4=%
set /p inputa="Give me the path of your AUDIO file: "

ffmpeg -stats -loglevel error -i %input% -i %inputa% -filter_complex "[0:a]volume=2[a1];[1:a]volume=0.5[a2];[a1][a2]amerge=inputs=2[a]" -map 0:v -map "[a]" -c:v copy -ac 2 %output%_audio.mp4

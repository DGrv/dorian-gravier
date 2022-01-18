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

echo Script to round corner of images
echo.
echo.

set /p input=Where are your files: 
set /p size=How many pixel do you wanna round (just try depend on your input): 

for /F %%i in ("%input%") do @set drive=%%~di

%drive%
cd "%input%"


for /r %%p in (*) do (
	set name=%%~np
	echo "  magick convert "%%p" ( +clone  -alpha extract -draw "fill black polygon 0,0 0,%size% %size%,0 fill white circle %size%,%size% %size%,0" ( +clone -flip ) -compose Multiply -composite ( +clone -flop ) -compose Multiply -composite ) -alpha off -compose CopyOpacity -composite  "!name!_rounded.png""  >temp.bat
	sed -i "s/\"  /  /g" temp.bat 
	call temp.bat
	del temp.bat
)


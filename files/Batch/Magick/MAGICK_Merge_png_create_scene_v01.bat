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

echo Script to combine a list of png together in order to create a scene for videos.
echo Steps:
echo - Prepare all layers on Krita
echo - export all layers in png
echo - rename them in order to have them alphabetically ordered
echo - use this script
echo.
echo It will combine layer1 with layer2 and create Scene_1
echo Combine Scene_1 with layer 3 and create Scene_2
echo Combine Scene_2 with layer 4 and create Scene_3
echo ...

set /p input=Where are your files: 

for /F %%i in ("%input%") do @set drive=%%~di

%drive%
cd "%input%"


set /a cnt=1
for %%j in (*.png) do (
	copy "%%j" "!cnt!.png"
	set /a cnt=!cnt!+1
)


magick composite 2.png 1.png Scene_1.png
FOR /L %%p IN (3,1,%cnt%) DO (
	set /a cntnew=%%p-1
	set /a cntold=%%p-2
	magick composite %%p.png Scene_!cntold!.png Scene_!cntnew!.png
)

FOR /L %%p IN (1,1,%cnt%) DO (
	del %%p.png
)




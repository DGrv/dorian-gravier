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
echo Your ffmpeg is here:
WHERE ffmpeg
IF %ERRORLEVEL% NEQ 0 (
	echo "[DEBUG] - ffmpeg command is unknown, please add it to the PATH
)
echo.


echo Batch file for changing the speed of a video (remove audio as well). Value range is 0 to n (btw 0 and 1 it will slow down your video). mpv will be used to check but you will not be able to go higher than 100 during checking (use [ or ] to increase speed during reading). Will create a new file where the video is with a extra 'f'.
echo.
echo Choose your files to speed up:  
 
 
set listfiles=powershell -NoP -C "[System.Reflection.Assembly]::LoadWithPartialName('System.windows.forms')|Out-Null;$OFD = New-Object System.Windows.Forms.OpenFileDialog;$OFD.Multiselect = $True;$OFD.InitialDirectory = '%mypath%';$OFD.ShowDialog()|out-null;$OFD.FileNames"

rem exec commands powershell and get result in FileName variable
for /f "delims=" %%i in ('%listfiles%') do (
	set dir=%%~dpi
	set drive=%%~di
	%%~di
	cd %%~dpi
	echo %%i >> list.txt
)


%drive%
cd %dir%
set file=%dir%list.txt
echo file %file% 

set /p speed=How much do you wanna speed up: 


for /F "usebackq tokens=*" %%p in (%file%) do (
	set filepathnoext=%%~dpnp
    set filename=%%~nxp
	set filenamenoext=%%~np
	set ext=%%~xp
	call ffmpeg -stats -loglevel error -i "%%p" -af "atempo=%speed%" -vf "setpts=PTS/%speed%" "%%~np_f%speed%%%~xp"
	rename "%%p" "!filenamenoext!__old!ext!"
	REM ffmpeg -i "%%p" -af "atempo=%speed%" -vf "setpts=PTS/%speed%" -r 24 "%%~np_f%speed%%%~xp"
)

REM ffmpeg -y -i 105.mp4 -an  -filter:v "setpts=PTS/6" new.mp4
REM ffmpeg -y -i 105.mp4 -af "atempo=6" -vf "setpts=PTS/6,fps=24" new.mp4
REM ffmpeg -y -i 105.mp4 -vf "minterpolate='mi_mode=mci:mc_mode=aobmc:vsbmc=1:fps=24*6'" new.mp4


del list.txt

REM echo.
REM echo All DONE :)
REM echo.

REM pause
 
 
 
 
 
 
 
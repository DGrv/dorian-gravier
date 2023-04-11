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

if exist List.txt del List.txt

echo.
echo Your ffmpeg is here:
WHERE ffmpeg
IF %ERRORLEVEL% NEQ 0 (
	echo "[DEBUG] - ffmpeg command is unknown, please add it to the PATH
)
echo.

echo Batch to create a zoom in effect
echo.
echo Choose your files to zoom in:  


if "%1"=="" (
	set listfiles=powershell -NoP -C "[System.Reflection.Assembly]::LoadWithPartialName('System.windows.forms')|Out-Null;$OFD = New-Object System.Windows.Forms.OpenFileDialog;$OFD.Multiselect = $True;$OFD.InitialDirectory = '%mypath%';$OFD.ShowDialog()|out-null;$OFD.FileNames"
	rem exec commands powershell and get result in FileName variable
	for /f "delims=" %%i in ('!listfiles!') do (
		set dir=%%~dpi
		set drive=%%~di
		%%~di
		cd %%~dpi
		echo %%i >> list.txt
	)
) else (
	set file=%1
	for %%i in (!file!) do (
		set dir=%%~dpi
		set drive=%%~di
		%%~di
		cd %%~dpi
		echo %%i >> list.txt
	)
)

echo. 
echo [95m[DEBUG] ---------------------
%drive%
cd %dir%
set file=%dir%list.txt
echo file %file% 
cat %file%
echo ----------------------[0m
echo. 

if "%2"=="" (
	set /p speed="How much do you  have the zoom (max zoom is here set to 1.5), try btw 0.0001 and 0.001: "
) else (
	set speed=%2
) 
 

set /p maxzoom=How much should be the maxzoom (1.5 e.g.): 


for /F "usebackq tokens=*" %%p in (%file%) do (
	set filepathnoext=%%~dpnp
    set filename=%%~nxp
	set filenamenoext=%%~np
	set ext=%%~xp
	:: check rate video
	for /f %%i in ('ffprobe -v error -select_streams v:0 -show_entries stream^=time_base -of default^=noprint_wrappers^=1:nokey^=1 "%%p"') do set RVdt=%%i
	set RVfile=!RVdt:1/=!
	for /f %%i in ('ffprobe -v error -select_streams v:0 -show_entries stream^=r_frame_rate -of default^=noprint_wrappers^=1:nokey^=1 "%%p"') do set frd=%%i
	set fr=!frd:/1=!
	rename "%%p" "!filenamenoext!__old!ext!"
	echo ffmpeg -stats -loglevel error -y -i "!filenamenoext!__old!ext!" -vf "[0:v]scale=7680:4320,zoompan=z='min(max(zoom,pzoom)+%speed%,%maxzoom%)':d=1:x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)',scale=1920:1080" -vcodec libx264 -r !fr! -video_track_timescale !RVfile! "!filenamenoext!_z%speed%!ext!"
	REM echo ffmpeg -stats -loglevel error -y -i "!filenamenoext!__old!ext!" -vf "[0:v]scale=7680:4320,zoompan=z='min(max(zoom,pzoom)+%speed%,%maxzoom%)':d=1:x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)',scale=1920:1080" "!filenamenoext!_z%speed%!ext!"
)

pause

del list.txt

 
 
 
 
 
 
 
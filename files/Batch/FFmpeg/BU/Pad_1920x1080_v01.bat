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
	set /p size=Which size [1 for 1920, 2 for 1920/2 and so on]:
) else (
	set size=%2
) 
 


for /F "usebackq tokens=*" %%p in (%file%) do (
	set filepathnoext=%%~dpnp
    set filename=%%~nxp
	set filenamenoext=%%~np
	set ext=%%~xp
	rename "%%p" "!filenamenoext!__old!ext!"
	ffmpeg -stats -loglevel error -y -i "!filenamenoext!__old!ext!" -vf "scale=1920/%size%:1080:force_original_aspect_ratio=decrease,pad=1920/%size%:1080:(ow-iw)/2:(oh-ih)/2,setsar=1" "%%p"
)

del list.txt

 
 
 
 
 
 
 
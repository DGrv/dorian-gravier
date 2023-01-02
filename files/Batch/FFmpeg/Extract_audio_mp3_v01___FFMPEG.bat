@echo off

echo.
echo Your ffmpeg is here:
WHERE ffmpeg
IF %ERRORLEVEL% NEQ 0 (
	echo "[DEBUG] - ffmpeg command is unknown, please add it to the PATH
)
echo.


echo Batch file to extract audio from video
echo.
echo Choose your files :  
 
 
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



for /F "usebackq tokens=*" %%p in (%file%) do (
	set filepathnoext=%%~dpnp
    set filename=%%~nxp
	set filenamenoext=%%~np
	set ext=%%~xp
	call ffmpeg -i "%%p" "%%~np.mp3"
)


del list.txt

REM echo.
REM echo All DONE :)
REM echo.

REM pause
 
 
 
 
 
 
 
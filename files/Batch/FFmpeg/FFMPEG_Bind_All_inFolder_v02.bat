@echo off
Setlocal EnableDelayedExpansion


echo Batch file for binding all video together from 1 folder.
echo.
set /p info=Take care of name of the files, should not contain strange characters !!!
echo Choose your files:

rem preparation command
set listfiles=powershell -NoP -C "[System.Reflection.Assembly]::LoadWithPartialName('System.windows.forms')|Out-Null;$OFD = New-Object System.Windows.Forms.OpenFileDialog;$OFD.Multiselect = $True;$OFD.InitialDirectory = '%mypath%';$OFD.ShowDialog()|out-null;$OFD.FileNames"

rem exec commands powershell and get result in FileName variable
for /f "delims=" %%i in ('%listfiles%') do (
	set dir=%%~dpi
	set drive=%%~di
    set filename=%%~nxi
	set filenamenoext=%%~ni
    set filepathnoext=%%~dpni
	set ext=%%~xi
	!drive!
	cd !dir!
	echo file '!filename!' >> list.txt
)

del output.mp*


echo.
echo.
echo.
echo [DEBUG] Start -----------------------------------
echo          dir : %dir%
echo          drive : %drive%
echo          filename : %filename%
echo          filenamenoext : %filenamenoext%
echo          filepathnoext : %filepathnoext%
echo          ext : %ext%
echo [DEBUG] End -----------------------------------
echo.
echo.
echo.

REM if exist ffmpeg ffmpeg -f concat -safe 0 -i list.txt -c copy output%ext%
ffmpeg -f concat -safe 0 -i list.txt -c copy output%ext%
REM if NOT exist ffmpeg H:\TEMP\Software\FFmpeg\ffmpeg-4.0.2-win32-static\bin\ffmpeg.exe -f concat -safe 0 -i list.txt -c copy output%ext%
del list.txt

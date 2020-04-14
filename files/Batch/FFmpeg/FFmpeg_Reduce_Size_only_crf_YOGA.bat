@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

::set ffmpegpath=H:\TEMP\Software\FFmpeg\ffmpeg-4.0.2-win32-static\bin\ffmpeg.exe
echo.
echo Script to convert all video from Youtube channel (e.g. Yoga) to reduce their size but still have them in a satisfying quality.
echo.

rem preparation command
set listfiles=powershell -NoP -C "[System.Reflection.Assembly]::LoadWithPartialName('System.windows.forms')|Out-Null;$OFD = New-Object System.Windows.Forms.OpenFileDialog;$OFD.Multiselect = $True;$OFD.InitialDirectory = '%mypath%';$OFD.ShowDialog()|out-null;$OFD.FileNames"

rem exec commands powershell and get result in FileName variable
for /f "delims=" %%i in ('%listfiles%') do (
	set dir=%%~dpi
	set drive=%%~di
	!drive!
	cd !dir!
	echo %%i >> list.txt
)

%drive%
cd %dir%
set file=%dir%list.txt

for /F "usebackq tokens=*" %%i in (%file%) do (
		ffmpeg -i "%%i" -vcodec libx264 -crf 30 -acodec mp3 "%%~ni_low.mp4"
)

del list.txt

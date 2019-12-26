@echo off
SETLOCAL ENABLEDELAYEDEXPANSION



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


echo [DEBUG] - Drive: %drive%, Dir: %dir%

for /F "usebackq tokens=*" %%i in (%file%) do (
	ffmpeg -i %%i -acodec mp3 -vcodec copy %%~ni_mp3.mp4
)

del list.txt



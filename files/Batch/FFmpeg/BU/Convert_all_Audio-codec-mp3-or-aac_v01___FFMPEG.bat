@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

set /p choice="Do you wanna to have mp3 [1] (Samsung TV ...) or aac audio [2] (Handy and usually normal) ? :  " 

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
	if %choice%==1 (
		ffmpeg -i %%i -acodec mp3 -vcodec copy %%~ni_mp3.mp4
	) else (
		ffmpeg -i %%i -acodec aac -vcodec copy %%~ni_aac.mp4
	)
)

del list.txt



@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

::set ffmpegpath=H:\TEMP\Software\FFmpeg\ffmpeg-4.0.2-win32-static\bin\ffmpeg.exe

set /p reso=Which resolution do you want ? (480, 640, 720, 1024 ... 1920 (full HD))) ?  
set /p aud=Do you want to use mp3 codec (samsung TV e.g. ...)  [y/n] ?  

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
	if %aud%==y (
		ffmpeg -i %%i -vcodec libx264 -vbr 3 -vf "scale=%reso%:-2" -preset fast -crf 23 -acodec mp3 %%~ni_TV.mp4
	) else (
		ffmpeg -i %%i -vcodec libx264 -vbr 3 -vf "scale=%reso%:-2" -preset fast -crf 23 %%~ni_TV.mp4
	)
	
	
	
	del %%i
	
	
	
)

del list.txt

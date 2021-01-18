@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

WHERE magick
IF %ERRORLEVEL% NEQ 0 (
	set run=H:\TEMP\Software\Pictures\ImageMagick-7.0.8-28-portable-Q16-x86\magick.exe
) else (
	set run=magick
)




echo.
echo Batch script to resize pictures (created by Dorian Gravier)
echo.
echo.

echo Where are you files ?
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

set /p per=Percent to resize (numeric) ?: 


for /F "usebackq tokens=*" %%p in (%file%) do (
	set ext=%%~xp
	start /wait %run% convert "%%p" -resize %per%%% "%%~np_%per%per!ext!"
)

del list.txt
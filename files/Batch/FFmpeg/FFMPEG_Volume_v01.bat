@echo off
SetLocal EnableDelayedExpansion

echo.
echo Your ffmpeg is here:
WHERE ffmpeg
IF %ERRORLEVEL% NEQ 0 (
	echo "[DEBUG] - ffmpeg command is unknown, please add it to the PATH
)
echo.


echo Batch file for changing for changing the volume of a mp3. 1 means 100%, if you wanna reduce by half use 0.5, increase by half, 1.5.
echo.
 
if "%1"=="" (
	echo Choose your files :  
	set listfiles=powershell -NoP -C "[System.Reflection.Assembly]::LoadWithPartialName('System.windows.forms')|Out-Null;$OFD = New-Object System.Windows.Forms.OpenFileDialog;$OFD.Multiselect = $True;$OFD.InitialDirectory = '%mypath%';$OFD.ShowDialog()|out-null;$OFD.FileNames"
	rem exec commands powershell and get result in FileName variable
	for /f "delims=" %%i in ('%listfiles%') do (
		set dir=%%~dpi
		set drive=%%~di
		cd %%~dpi
		echo %%i >> list.txt
	)
) else (
	for /f %%i in (%1) do (
		set dir=%%~dpi
		set drive=%%~di
		echo !drive!
		echo !dir!
		cd !dir!
		echo %%i> list.txt
	)
)


%drive%
cd %dir%
set file=%dir%list.txt
echo file %file% 

if "%2"=="" (
	set /p per=How much do you wanna modify the volume (reduce is btw 0 and 1, increase more than 1, to increase you can go high, try 10 or more)  
) else (
	set per=%2
	set per=!per:"=!
)

for /F "usebackq tokens=*" %%p in (%file%) do (
	set filepathnoext=%%~dpnp
    set filename=%%~nxp
	set filenamenoext=%%~np
	set ext=%%~xp
	set newname=!filenamenoext!_old!ext!
	rename "%%p" "!newname!"
	echo ffmpeg -i "!newname!" -filter:a "volume=%per%" -c:v copy "%%p"
	ffmpeg -i "!newname!" -filter:a "volume=%per%" -c:v copy "%%p"
)

del list.txt

REM echo.
REM echo All DONE :)
REM echo.

REM pause
 
 
 
 
 
 
 
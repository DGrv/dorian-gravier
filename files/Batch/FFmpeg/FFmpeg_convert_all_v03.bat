@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

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
	echo Code to reduce the quality of video (will convert them to mp4 with libx264 codec).
	echo The user can choose to convert the audio in mp3 (for Samsung TV e.g.), reduce resolution and compress the picture (crf).
	echo The script is using ffmpeg present on your computer, this one should be in your PATH.
	echo.
	echo Please choose your files by pressing Enter (the script may crash during selection, please retry).
	echo.
	pause

:: ----------------- user choice files ------------------
	del list.txt
	rem preparation command
	
	if "%~1"=="" (
		powershell -NoP -C "[System.Reflection.Assembly]::LoadWithPartialName('System.windows.forms')|Out-Null;$OFD = New-Object System.Windows.Forms.OpenFileDialog;$OFD.Multiselect = $True;$OFD.InitialDirectory = '%mypath%';$OFD.ShowDialog()|out-null;$OFD.FileNames" > list.txt
	) else (
		set firstfile=%~1
	)

	
	
	
	
	
:: ----------------- extract all info needed ------------------
	REM Get first file
	head -1 list.txt > tempy
	set /p firstfile=<tempy
	del tempy
			REM echo firstfile=%firstfile%
	echo.
	echo.
	echo ----- DEBUG ------
	echo firstfile: %firstfile%
	echo.
	
	REM Extract path
	for %%i in ("%firstfile%") do (
		set dir=%%~dpi
		set drive=%%~di
	)
			REM echo dir=%dir%
			REM echo drive=%drive%
	set file=%dir%list.txt
			REM echo cd=%cd%
			REM echo file=%file%
	
	echo.
	echo ----- DEBUG ------
	echo file: %file%
	echo dir: %dir%
	echo drive: %drive%
	echo.
	echo.

	move list.txt %file%
	
	REM Get reoslution fifile
	ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 "%firstfile%" > tempy
	set /p resofirst=<tempy
	del tempy
			REM echo firstfile=%firstfile%
			REM echo resofirst=%resofirst%

:: ----------------- User choice ------------------

	echo.
	echo.
	set /p changereso=Do you wanna change the original resolution [y/n] ? 
	echo.
	if %changereso%==y (
		echo            First file: %firstfile%
		echo            The resolution of your first file is %resofirst%
		echo.
		set /p reso="           Which resolution do you want (320 - good for yoga video on phone, 480, 640, 720, 1024 ... 1920 (full HD) ?  "
	)
	
	echo.
	set /p compress="Do you wanna compress quality [y/n] ?  "
	echo.
	if %compress%==y (
		echo.
		set /p crf="           Which compression (crf) ( I used 30 for Yoga video on computer for example - 24 is normal) ?  "
	) 
	
	echo.
	set /p changeaud="Do you want to use mp3 codec (samsung TV e.g.) [1] or aac (normal, and for handy) [2] ?  "


:: ----------------- Code ------------------

	%drive%
	cd %dir%
	for /F "usebackq tokens=*" %%i in (%file%) do (
		if %changereso%==y (
			if %changeaud%==1 (
				if %compress%==y (
					ffmpeg -i "%%i" -vcodec libx264 -vf "scale=%reso%:-2" -preset slow -acodec mp3 -crf %crf% "%%~ni_r%reso%_crf%crf%_mp3.mp4"
				) else (
					ffmpeg -i "%%i" -vcodec libx264 -vf "scale=%reso%:-2" -preset slow -acodec mp3 "%%~ni_r%reso%_mp3.mp4"
				)
			) else (                            
				if %compress%==y (
					ffmpeg -i "%%i" -vcodec libx264 -vf "scale=%reso%:-2" -preset slow -crf %crf% -acodec aac "%%~ni_r%reso%_crf%crf%.mp4"
				) else (
					ffmpeg -i "%%i" -vcodec libx264 -vf "scale=%reso%:-2" -preset slow  -acodec aac "%%~ni_r%reso%.mp4"
				)
			)                                
		) else (                                
			if %changeaud%==1 ( 
				if %compress%==y (
					ffmpeg -i "%%i" -vcodec libx264 -preset slow -crf %crf% -acodec mp3 "%%~ni_crf%crf%_mp3.mp4"
				) else (
					ffmpeg -i "%%i" -vcodec libx264 -preset slow -acodec mp3 "%%~ni_mp3.mp4"
				)			
			) else (  
				if %compress%==y (
					ffmpeg -i "%%i" -vcodec libx264 -preset slow -crf %crf% -acodec aac "%%~ni_crf%crf%.mp4"
				) else (
					if NOT %%~xi==mp4 (
						ffmpeg -i "%%i" -vcodec libx264 -preset slow -acodec aac "%%~ni.mp4"
					) else (
						echo I am doing nothing here with "%%i"
					)
				)			
			)
		)
	)

	del %file%

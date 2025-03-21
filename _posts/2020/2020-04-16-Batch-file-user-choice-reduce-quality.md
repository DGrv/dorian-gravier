---
title: "Batch file using FFmpeg to reduce video quality depending on user choice"
date: "2020-04-16 09:00"
comments_id: 40
---

I use often FFmpeg with batch script that I did.
I usually create videos from GoPro footages in few minutes without having to pass through any software. This will be a new post in future.

However I often have to compress quality of videos (make me think that I should do a script to create all sort of output possible to be able to choose which one I want for a special purpose). 

I wrote here a script that allow the user to choose between 3 option to modify:

- Change the resolution
- Compression (using crf command)
- convert audio in mp3

Depending on the choice of the user the videos choosen (via powershell, so allowing batch of files in a same folder), new videos will be created with specific filenames depending of the user choice.

Just have a try if you want :) 

PS: You need to have ffmpeg in your PATH to use this.

The code is available [here](https://github.com/DGrv/dorian.gravier.github.io/tree/master/files/Batch/FFmpeg/FFmpeg_convert_all_v03.bat).

https://github.com/DGrv/dorian.gravier.github.io/blob/508d48f21174fe693c127a7821aab7a2793de2fa/files/Batch/FFmpeg/FFMPEG_Bind_All_inFolder_v01.bat#L1-L35

```shell
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
	powershell -NoP -C "[System.Reflection.Assembly]::LoadWithPartialName('System.windows.forms')|Out-Null;$OFD = New-Object System.Windows.Forms.OpenFileDialog;$OFD.Multiselect = $True;$OFD.InitialDirectory = '%mypath%';$OFD.ShowDialog()|out-null;$OFD.FileNames" > list.txt
	
:: ----------------- extract all info needed ------------------
	REM Get first file
	head -1 list.txt > temp
	set /p firstfile=<temp
	del temp
			REM echo firstfile=%firstfile%
	
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
	move list.txt %file%

	REM Get reoslution fifile
	ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 "%firstfile%" > temp
	set /p resofirst=<temp
	del temp
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
	set /p changeaud="Do you want to use mp3 codec (samsung TV e.g. ...)  [y/n] ?  "


:: ----------------- Code ------------------

	%drive%
	cd %dir%
	for /F "usebackq tokens=*" %%i in (%file%) do (
		if %changereso%==y (
			if %changeaud%==y (
				if %compress%==y (
					ffmpeg -i "%%i" -vcodec libx264 -vf "scale=%reso%:-2" -preset slow -acodec mp3 -crf %crf% "%%~ni_r%reso%_crf%crf%_mp3.mp4"
				) else (
					ffmpeg -i "%%i" -vcodec libx264 -vf "scale=%reso%:-2" -preset slow -acodec mp3 "%%~ni_r%reso%_mp3.mp4"
				)
			) else (                            
				if %compress%==y (
					ffmpeg -i "%%i" -vcodec libx264 -vf "scale=%reso%:-2" -preset slow -crf %crf% "%%~ni_r%reso%_crf%crf%.mp4"
				) else (
					ffmpeg -i "%%i" -vcodec libx264 -vf "scale=%reso%:-2" -preset slow "%%~ni_r%reso%.mp4"
				)
			)                                   
		) else (                                
			if %changeaud%==y ( 
				if %compress%==y (
					ffmpeg -i "%%i" -vcodec libx264 -preset slow -crf %crf% -acodec mp3 "%%~ni_crf%crf%_mp3.mp4"
				) else (
					ffmpeg -i "%%i" -vcodec libx264 -preset slow -acodec mp3 "%%~ni_mp3.mp4"
				)			
			) else (  
				if %compress%==y (
					ffmpeg -i "%%i" -vcodec libx264 -preset slow -crf %crf% "%%~ni_crf%crf%.mp4"
				) else (
					echo I am doing nothing here with "%%i"
				)			
			)
		)
	)

	del %file%

```
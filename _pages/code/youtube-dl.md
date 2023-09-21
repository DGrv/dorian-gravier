---
title: "Youtube-dl"
permalink: /code/youtube-dl/
toc: true
author_profile: false
layout: code
---


# Easy Commands

Command to dowload the audio from a video or playlist:

``` shell
youtube-dl -x --audio-format "mp3" --audio-quality 0 -c --yes-playlist -i the-url-of-your-video
```

Command to download a video (best quality):

``` shell
youtube-dl -f best the-url-of-your-video
```

Command to download a video (with choosen quality): Get the list of possible format …

``` shell
youtube-dl -F the-url-of-your-video
```

Choose one and run the following line

``` shell
youtube-dl -f format-choosen the-url-of-your-video
```

# Batch

This little batch file will ask you the url of a video and give you the choise to download only the audio or the video (with choosing the format if you need).

You will have to change the 2 variables:

- pathexe
- wd

*E.g.:*

- set pathexe=C:\Users\DGrv\Downloads\Software\Youtube-dl\youtube-dl.exe
- set wd=C:\Users\DGrv\Downloads\Youtube_music

*Use brackets “” if you have space in your path.*

For noobies.

- Download [Youtube-dl](https://rg3.github.io/youtube-dl/download.html), if you have windows, download the Windows.exe. Move it to a safe folder where you know where it is. Note path of the file.
- Download [ffmpeg](https://www.ffmpeg.org/download.html) as well for your system and place it as well in the same folder
- Copy the following lines of codes in a txt file (with notepad for example), change the 2 variables explained above and save it as a .bat file.
- Run the bat file and enjoy.

**Example of easy batch:**

``` shell
@echo off
echo Will download the audio of a youtube video in C:Users\DGrv\Downloads\Software\Youtube-dl
set pathexe=C:\path-of-your\youtube-dl.exe
set wd=path-of-your-output-folder

cd %wd%

set /p url="Enter the url: "
set /p choice="Do you want to download the audio or the video ? (Audio=1, Video=2)   "

if "%choice%"=="1" (
    %pathexe% -x --audio-format "mp3" --audio-quality 0 -c --yes-playlist -i %url%
)
if "%choice%"=="2" (
    set /p choice2="Choose your format (1) and choose best (2): "
    if "%choice2%"=="2" (
        %pathexe% -f best %url%
    )
    if "%choice2%"=="1" (
        set choice=3
        %pathexe% -F %url%
        set /p format="Which one do you want: "
    )
)
if "%choice%"=="3" (
    %pathexe% -f %format% %url%
)
```

The updated version is [here](/files/Batch/Youtube-dl/Dowload_Youtube-dl.bat) with the code here:

```txt
// ./files/Batch/Youtube-dl/Dowload_Youtube-dl.txt

@echo off
SETLOCAL EnableDelayedExpansion

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
echo Code permitting users to choose rapidly how to download videos or audio using youtube-dl (http://ytdl-org.github.io/youtube-dl/). 
echo.
echo.
echo.



:: ------------- Variables
set pathexe=C:\Users\doria\Downloads\Software\Youtube-dl\youtube-dl.exe
set wd=C:\Users\doria\Downloads\Youtube_music

:: -------------- Info
echo Batch written by Dorian Gravier, free of use and modification
echo --------------------------------------------------------------
echo This batch script is only allowing user to use in a simple way Youtube-dl from https://ytdl-org.github.io/youtube-dl/index.html
echo.
echo Will download the audio or video in %wd%
echo.
echo When it is not anymore functionning: try to redownload the software on http://ytdl-org.github.io/youtube-dl/download.html
echo.
echo TIPS
echo ----
echo If you wanna download a playlist you have to be sure that you have a link with a list info :
echo - list=PL-G7EJFoxFcfVIc4EzytG-UhFVBq9AEKs
echo for example: https://www.youtube.com/list=PL-G7EJFoxFcfVIc4EzytG-UhFVBq9AEKs
echo.
echo.
echo.



REM echo --------------------------------------------------------
REM echo UPDATE Check youtube-dl
REM %pathexe% -U
REM echo --------------------------------------------------------
REM echo.
REM echo.
REM echo.
REM echo.


:: -------------- User choice
set /p url="Enter the url or type 'list' if you wanna give a txt file: "

echo.
set /p newfolder="Do you want to dowload it in a new folder ? (No=1, Yes=2)  " 

echo. 
set /p choice="Do you want to download the audio or the video ? (Audio=1, Video=2)   "

echo. 
if "%url%"=="list" (
	set /p listpath="WHERE is your txt file ?"
	set /p url=<!listpath!
)
REM to get first line
REM set /p url=<!listpath!

if "%choice%"=="2" (
	echo. 
	set /p choice2="Choose your format (1) and choose best (2): "
	if "!choice2!"=="1" (
		%pathexe% -F --playlist-items 1 %url%
		set /p format="Which one do you want: "
	)
)






echo.
echo ----- START
echo.
cd %wd%
if "%newfolder%"=="2" (

:: create timestamp depending on timeformat (language time settings) English will print Mon 09/03/2020 and FR 03/09/2020
set /a check=%DATE:~0,1%
set check2=%DATE:~0,1%
if "%check%"=="%check2%" (
	set TIMESTAMP=%DATE:~6,4%%DATE:~3,2%%DATE:~0,2%-%TIME:~0,2%%TIME:~3,2%
) else (
	set TIMESTAMP=%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%-%TIME:~0,2%%TIME:~3,2%
)


	echo ------- Create folder
	:: check if sed command exist (from gow), would extract name playlist, if not use timpestamp for folder
	WHERE sed
	IF !ERRORLEVEL! NEQ 0 (
		echo --------- No sed cmd so create timestamp folder
		:: Create a new directory
		mkdir !TIMESTAMP!
		cd %wd%\!TIMESTAMP!
	) else (
		echo --------- Extract playlist name
		:: get title of the playlist
		%pathexe% -F --playlist-items 1 %url% > temp
		:: check if if the string playlist is in the file
		type temp | grep playlist | sed -n 1p > temp2
		set /p boolplaylist=<temp2
		if "!boolplaylist!" == "" (
			:: Create a new directory
			mkdir !TIMESTAMP!
			rm temp
			rm temp2
			cd %wd%\!TIMESTAMP!
		) else (
			sed -n 2p temp | sed "s/\[download] Downloading playlist: //g" | sed "s/://g"> playlisttitle
			set /p playlisttitle=<playlisttitle
			md "!playlisttitle!"
			rm temp
			rm temp2
			rm playlisttitle
			cd "%wd%\!playlisttitle!"
		)
	)
)





echo ----------- Download Videos
echo.
echo.
if "%choice%"=="1" (
	if "%url%"=="list" (
		for /F "usebackq tokens=*" %%A in ("%listpath%") do %pathexe% -x --audio-format "mp3" --audio-quality 0 -c --yes-playlist -o "%%(playlist_index)s___%%(uploader)s__-__%%(title)s.%%(ext)s"  -i %%A
	) else (
		%pathexe% -x --audio-format "mp3" --audio-quality 0 -c --yes-playlist -o "%%(playlist_index)s___%%(uploader)s__-__%%(title)s.%%(ext)s" -i %url%
	)
)
if "%choice%"=="2" (
	if "!choice2!"=="2" (
		if "%url%"=="list" (
			for /F "usebackq tokens=*" %%A in ("%listpath%") do %pathexe% --write-auto-sub -o "%%(playlist_index)s___%%(uploader)s__-__%%(title)s.%%(ext)s"  -f best %%A
		) else (
			%pathexe% --write-auto-sub -o "%%(playlist_index)s___%%(uploader)s__-__%%(title)s.%%(ext)s"  -f best %url%
		)
	)
	if "!choice2!"=="1" (
		if "%url%"=="list" (
			for /F "usebackq tokens=*" %%A in ("%listpath%") do %pathexe% --write-auto-sub -o "%%(playlist_index)s___%%(uploader)s__-__%%(title)s.%%(ext)s"  -f %format% %%A
		) else (
			%pathexe% --write-auto-sub -o "%%(playlist_index)s___%%(uploader)s__-__%%(title)s.%%(ext)s"  -f %format% %url%
		)
	)
)

for %%i in ("NA___*") do (
	set name=%%~ni
	set ext=%%~xi
	set name=!name:NA___=!
	rename "%%i" "!name!!ext!"
)
for %%i in ("*Topic__-__*") do (
	set name=%%~ni
	set ext=%%~xi
	set name=!name:Topic__-__=!
	rename "%%i" "!name!!ext!"
)
for %%i in ("* Official Audio*") do (
	set name=%%~ni
	set ext=%%~xi
	set name=!name:" (Official Audio)"=""!
	rename "%%i" "!name!!ext!"
)
for %%i in ("*(*") do (
	set name=%%~ni
	set ext=%%~xi
	set name=!name:"("="-"!
	rename "%%i" "!name!!ext!"
)
for %%i in ("*)*") do (
	set name=%%~ni
	set ext=%%~xi
	set name=!name:")"="-"!
	rename "%%i" "!name!!ext!"
)

for %%i in ("*'*") do (
	set name=%%~ni
	set ext=%%~xi
	set name=!name:"'"=""!
	rename "%%i" "!name!!ext!"
)




:: OTHER manual command
REM C:\Users\gravier\Downloads\Software\Youtube-dl\youtube-dl.exe -x --audio-format "mp3" --audio-quality 0 -c --yes-playlist --playlist-start 1 --playlist-end 50 -i https://www.youtube.com/playlist?list=UUpw2gh99XM6Mwsbksv0feEg
REM C:\Users\gravier\Downloads\Software\Youtube-dl\youtube-dl.exe -f 18 --yes-playlist --playlist-start 4 --playlist-end 8 -i https://www.youtube.com/playlist?list=PLVGRF5aTQl4GXNwtlYBSaP_8ErZ1RtaLR

 exit 0



```
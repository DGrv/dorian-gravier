@echo off
SETLOCAL EnableDelayedExpansion

:: ------------- Variables
set pathexe=C:\Users\gravier\Downloads\Software\Youtube-dl\youtube-dl.exe
set wd=C:\Users\gravier\Downloads\Youtube_music

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




:: -------------- User choice
set /p url="Enter the url: "
echo.
set /p choice="Do you want to download the audio or the video ? (Audio=1, Video=2)   "
echo.

cd %wd%
if "%choice%"=="1" (
	%pathexe% -x --audio-format "mp3" --audio-quality 0 -c --yes-playlist -i %url%
)
if "%choice%"=="2" (
	set /p choice2="Choose your format (1) and choose best (2): "
	if "!choice2!"=="2" (
		%pathexe% -f best %url%
	)
	if "!choice2!"=="1" (
		set choice=3
		%pathexe% -F %url%
		set /p format="Which one do you want: "
	)
)
if "%choice%"=="3" (
	%pathexe% -f %format% %url%
)
paused


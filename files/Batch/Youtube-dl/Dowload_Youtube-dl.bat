@echo off
SETLOCAL EnableDelayedExpansion
echo Will download the audio of a youtube video in C:\Users\gravier\Downloads\Software\Youtube-dl
set pathexe=C:\Users\gravier\Downloads\Software\Youtube-dl\youtube-dl.exe
set wd=C:\Users\gravier\Downloads\Youtube_music

cd %wd%

set /p url="Enter the url: "
set /p choice="Do you want to download the audio or the video ? (Audio=1, Video=2)   "

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


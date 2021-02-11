@echo off
SetLocal EnableDelayedExpansion

mkdir v30
for %%i in (*.mp4) do (
	set nam=%%~ni
	ffmpeg -i %%i -af "volume=30" -c:v copy "C:\Users\doria\Downloads\Pictures\2017\2017_09_Fahrrad_Reise_Kroatien\Video\v30\!nam!_v30.mp4"
)

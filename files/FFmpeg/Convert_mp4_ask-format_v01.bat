@echo off
echo This bat file will create convert the mp4 in the folder where it is in the format you choose:
set /p format="Set the output format (e.g. 480 or 720 or 1024 ...) : "

for %%i in (*.mp4) do (
	ffmpeg -i %%i -vcodec libx264 -vbr 3 -vf "scale=%format%:-2" -preset slow -crf 18 %format%_%%i
)

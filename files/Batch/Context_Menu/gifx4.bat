@echo off
set "file=%~1"
set "name=%~n1"
set "dir=%~dp1"
REM "C:\Users\doria\scoop\shims\ffmpeg.exe" -i "%file%" -filter_complex "[0:v]setpts=0.25*PTS,split[a][b];[a]palettegen[p];[b][p]paletteuse" -y "%dir%%name%_x4.gif"
"C:\Users\doria\scoop\shims\ffmpeg.exe" -i "%file%" -filter_complex "[0:v]mpdecimate,setpts=0.25*PTS,split[a][b];[a]palettegen[p];[b][p]paletteuse" -y "%dir%%name%_x4.gif"

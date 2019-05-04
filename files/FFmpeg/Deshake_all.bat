:: Edit the line below to match your path to the ffmpeg executable.
set path2exe=C:\Users\DGrv\Downloads\Software\ffmpeg-20150801-git-b27d4fd-win32-static\bin\ffmpeg.exe
for %%i in (*.mp4) do %path2exe% -i %%i -video_track_timescale 90000 -vf deshake Ds_%%i

for /F "usebackq tokens=*" %%i in (list.txt) do (
	start /wait ffmpeg -i "%%i" -vcodec libx264 -vf "scale=1024:-2" -preset slow -crf 30 -acodec aac  "%%~dpni.mp4"
)

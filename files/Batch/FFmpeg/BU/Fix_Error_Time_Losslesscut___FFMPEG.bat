for %%i in (*.mp4) do (
	ffmpeg -err_detect ignore_err -i %%i -c copy %%i_new.mp4
	::del %%i
)
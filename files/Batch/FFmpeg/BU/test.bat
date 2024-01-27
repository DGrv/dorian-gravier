set simplemode=n
echo simplemode : %simplemode%
	if "%simplemode%" NEQ "y" (
		set draft=n
	)
echo.
if %simplemode% NEQ "y" (
	set /p draft="Do you want to make the [94mdraft[37m version (no filigrane, no overlay) [y/n]: "
	if %draft%=="y" (
		set dooverlaymusic=n
		set dofiligrane=n
	) else (
		set dooverlaymusic=y
		set dofiligrane=y
	)
)
	

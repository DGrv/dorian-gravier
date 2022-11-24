@echo off


echo Batch file for changing the speed of a video (remove audio as well). Value range is 0 to n (btw 0 and 1 it will slow down your video). mpv will be used to check but you will not be able to go higher than 100 during checking (use [ or ] to increase speed during reading). Will create a new file where the video is with a extra 'f'.
echo.
set /p input=Give me the path of a file to speed up: 
 

:: extract filename no extension
:: https://stackoverflow.com/questions/15567809/batch-extract-path-and-filename-from-a-variable/15568171
for %%a in ("%input%") do (
    set filepathnoext=%%~dpna
    set filename=%%~nxa
	set filenamenoext=%%~na
	set ext=%%~xa
)  

REM echo %filepathnoext%
REM echo %filename%
REM echo %filenamenoext%
REM echo %ext%
REM pause

:test
set /p speed=How much do you wanna speed up: 

					:::: can not use ffplay, there is some limitation for speed, but the code is interessant
					:::: convert to numeric
					::set /a speednum=%speed%+0
                    ::
					::if %speednum% gtr 100 (
					::	echo mpv can not read more than speed 100 times. Going to ffmpeg directly. Check output.
					::	set ok=y
					::) else (
					::	::ffplay -i %input% -vf "setpts=PTS/%speed%"
					::	C:\Users\DGrv\Downloads\Software\mpv-x86_64-20181002\mpv.exe --speed=%speed% %input%
					::	echo.
					::	set /p ok= Is it fine or you wanna test a new speed [y/n]: 
					::)
					
					set ok=y


::ffplay -x 500 -y 400 %filepathnoext%_f%speed%%ext%
if %ok%==y (
	ffmpeg -i "%input%" -an -vf "setpts=PTS/%speed%" "%filepathnoext%_f%speed%%ext%"
) else (
	goto :test
)

::ffmpeg -i %input% -codec copy -map_metadata 0 -metadata:s:v:0 rotate=180 %filepathnoext%r%ext%

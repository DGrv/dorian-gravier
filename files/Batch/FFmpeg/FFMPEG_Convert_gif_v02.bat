@echo off


if "%~1"=="" (
	set /p file="Which file do you wanna convert ? "
) else (
	set file=%~1
)

echo. 
ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 %file%

if "%~2"=="" (
	set /p size="Which resolution (above the resolution of your video) give me just the width ? "
) else (
	set size=%~2
)

if "%~3"=="" (
	set /p fps="Frame per second ? "
) else (
	set fps=%~3
)




for %%a in (%file%) do (
	set filepathnoext=%%~dpna
	set filepath=%%~dpa
	set drive=%%~da
	set filename=%%~nxa
	set filenamenoext=%%~na
	set ext=%%~xa
)  

%drive%
cd %filepath%

echo Create Palette
ffmpeg -v quiet -stats -y -i %file% -vf "fps=%fps%,scale=%size%:-1:flags=lanczos,palettegen" -y palette.png
echo Convert in gif
ffmpeg -v quiet -stats -y -i %file% -i palette.png -lavfi "fps=%fps%,scale=%size%:-1:flags=lanczos [x]; [x][1:v] paletteuse" -y %filenamenoext%_fps%fps%_r%size%.gif
del palette.png
	
	
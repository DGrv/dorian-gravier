@echo off

set /p file=Which file do you wanna convert ? 
echo. 
C:\Users\gravier\Downloads\Software\ffmpeg-4.0.2-win32-static\bin\ffprobe.exe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 %file%
set /p size=Which resolution (above the resolution of your video) ? 
set/p fps=Frame per second ? 

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
C:\Users\gravier\Downloads\Software\ffmpeg-4.0.2-win32-static\bin\ffmpeg.exe -v quiet -stats -y -i %file% -vf "fps=%fps%,scale=%size%:-1:flags=lanczos,palettegen" -y palette.png
echo Convert in gif
C:\Users\gravier\Downloads\Software\ffmpeg-4.0.2-win32-static\bin\ffmpeg.exe -v quiet -stats -y -i %file% -i palette.png -lavfi "fps=%fps%,scale=%size%:-1:flags=lanczos [x]; [x][1:v] paletteuse" -y %filenamenoext%_fps%fps%_r%size%.gif
del palette.png
	
	
@echo off

set pixel=940

set /p filepath="Give me your filenamepath: "
for %%a in ("%filepath%") do (
	set pathh%=%%~dpa
	set filename=%%~nxa
	set filenamenoext=%%~na
	set filepathnoext=%%~dpna
	set ext=%%~xa
	set drive=%%~da
)  
set actualcd=%cd%
%drive%
cd %pathh%

ffmpeg -stats -loglevel error -i "%filename%" -vf "crop=2:1080:%pixel%:0" -start_number 1 -c:v pam -f image2pipe pipe:1 | magick - -crop 1x+0+0 +append "%filenamenoext%.png"

cd %actualcd%


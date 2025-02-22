@echo off
SetLocal EnableDelayedExpansion


echo Batch file asking a path for a video and rotate it 180. Will create a new file where the video is with a extra 'r'.


if "%1"=="" (
	set /p input=Give me the path of a file to rotate: 
) else (
	set input=%1
)




set /p rotation=How much do you wanna rotate (0 - flat, 90, 180, 270), it will trun ANTI-CLOCKWISE: 

:: extract filename no extension
:: https://stackoverflow.com/questions/15567809/batch-extract-path-and-filename-from-a-variable/15568171
for %%a in (%input%) do (
	set dir=%%~dpa
    set filepathnoext=%%~dpna
    set filename=%%~nxa
	set filenamenoext=%%~na
	set ext=%%~xa
	set drive=%%~da
)  

%drive%
cd %dir%

echo. 
echo [95m[DEBUG] ---------------------
%drive%
echo input %input% 
echo ----------------------[0m
echo. 



:: only metadata, if you bind it with other, it will not be rotated ...
::ffmpeg -i %input% -v quiet -stats -codec copy -map_metadata 0 -metadata:s:v:0 rotate=180 %filepathnoext%_r%ext%

REM FOR /F %%A IN ('WMIC OS GET LocalDateTime ^| FINDSTR \.') DO @SET time=%%A
REM set TIMESTAMP=%time:~0,8%-%time:~8,6%
for /f %%p in ('bash -c "date +"%%Y%%m%%d-%%H%%M%%S""') do set TIMESTAMP=%%p

:: goo one
rename "%input%" "%filenamenoext%_old_r%rotation%_%TIMESTAMP%.mp4"

::old
REM ffmpeg -i "%filenamenoext%_old.mp4" -v quiet -stats -vf "transpose=2,transpose=2" "%filename%"
REM ffmpeg -display_rotation %rotation% -i "%filenamenoext%_old_r%rotation%_%TIMESTAMP%.mp4"  -codec copy  "%filename%"
REM ffmpeg -v quiet -stats -i "%filenamenoext%_old_r%rotation%_%TIMESTAMP%.mp4" "-metadata:s:v:0" "rotate=%rotation%" -c:v copy -c:a copy "%filename%"
ffmpeg  -i "%filenamenoext%_old_r%rotation%_%TIMESTAMP%.mp4" -metadata:s:v:0 rotate=%rotation%  -codec copy "%filename%"




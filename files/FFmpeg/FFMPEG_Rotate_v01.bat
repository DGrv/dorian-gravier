@echo off


echo Batch file asking a path for a video and rotate it 180. Will create a new file where the video is with a extra 'r'.
set /p input=Give me the path of a file to rotate: 

:: extract filename no extension
:: https://stackoverflow.com/questions/15567809/batch-extract-path-and-filename-from-a-variable/15568171
for %%a in (%input%) do (
    set filepathnoext=%%~dpna
    set filename=%%~nxa
	set filenamenoext=%%~na
	set ext=%%~xa
)  

:: only metadata, if you bind it with other, it will not be rotated ...
::ffmpeg -i %input% -v quiet -stats -codec copy -map_metadata 0 -metadata:s:v:0 rotate=180 %filepathnoext%_r%ext%

:: goo one
ffmpeg -i %input% -v quiet -stats -vf "transpose=2,transpose=2" %filepathnoext%_r%ext%

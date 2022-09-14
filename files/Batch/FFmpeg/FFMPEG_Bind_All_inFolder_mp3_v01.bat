@echo off
SetLocal EnableDelayedExpansion

echo "--------------------------------------------------------------------------------"
echo "   _____             _                _____                 _                   "
echo "  |  __ \           (_)              / ____|               (_)                  "
echo "  | |  | | ___  _ __ _  __ _ _ __   | |  __ _ __ __ ___   ___  ___ _ __         "
echo "  | |  | |/ _ \| '__| |/ _` | '_ \  | | |_ | '__/ _` \ \ / / |/ _ \ '__|        "
echo "  | |__| | (_) | |  | | (_| | | | | | |__| | | | (_| |\ V /| |  __/ |           "
echo "  |_____/ \___/|_|  |_|\__,_|_| |_|  \_____|_|  \__,_| \_/ |_|\___|_|           "
echo "                                                                                "
echo "--------------------------------------------------------------------------------"
REM http://www.network-science.de/ascii/
echo.


echo Batch file for binding all video together from 1 folder.
echo.
echo Take care of name of the files, should not contain strange characters (no paranthesis e.g.) !!!
echo.

if "%~1"=="" (
	set /p input=Give me the path of the directory where your video are: 
) else (
	set input=%~1
)

set /p small="Do you wanna convert it also small for sharing and test [y/n]: "

echo.
echo.

rm %input%\list.txt
:: get the last file in the list to get the ext
:: https://stackoverflow.com/questions/47450531/batch-write-output-of-dir-to-a-variable
for /f "delims=" %%a in ('dir /a-d /b "%input%\*mp3" ') do set "last=%input%\%%a"


:: extract filename no extension
:: https://stackoverflow.com/questions/15567809/batch-extract-path-and-filename-from-a-variable/15568171
for %%a in (%last%) do (
	set pathh=%%~dpa
    set filename=%%~nxa
	set filenamenoext=%%~na
    set filepathnoext=%%~dpna
	set ext=%%~xa
	set drive=%%~da
)  

echo.
echo.
echo ------------------ [DEBUG] --------------------
echo pathh : %pathh%
echo filename : %filename%
echo filenamenoext : %filenamenoext%
echo filepathnoext : %filepathnoext%
echo ext : %ext%
echo ------------------ end debug --------------------
echo.
echo.

%drive%
cd "%input%"
(for %%i in (*%ext%) do @echo file '%input%\%%i') > list.txt
ffmpeg -stats -loglevel error -f concat -safe 0 -i list.txt -c copy output%ext%

) 



::del list.txt

REM (for %i in (*.mp3) do @echo file '%i') > list.txt
REM ffmpeg -f concat -i list.txt -c copy output.mp3

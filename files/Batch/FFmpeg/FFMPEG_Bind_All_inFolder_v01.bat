@echo off

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
echo Take care of name of the files, should not contain strange characters !!!
echo.
set /p input=Give me the path of the directory where your video are: 
 

:: get the last file in the list to get the ext
:: https://stackoverflow.com/questions/47450531/batch-write-output-of-dir-to-a-variable
for /f "delims=" %%a in ('dir /a-d /b /s %input%') do set "last=%%a"


:: extract filename no extension
:: https://stackoverflow.com/questions/15567809/batch-extract-path-and-filename-from-a-variable/15568171
for %%a in (%last%) do (
	set pathh=%%~dpa
    set filename=%%~nxa
	set filenamenoext=%%~na
    set filepathnoext=%%~dpna
	set ext=%%~xa
)  

echo pathh : %pathh%
echo filename : %filename%
echo filenamenoext : %filenamenoext%
echo filepathnoext : %filepathnoext%
echo ext : %ext%


cd %input%
(for %%i in (*%ext%) do @echo file '%%i') > list.txt
ffmpeg -f concat -i list.txt -c copy output%ext%
::del list.txt

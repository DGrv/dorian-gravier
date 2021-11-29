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


where wget
IF %ERRORLEVEL% NEQ 0 (
	echo "[DEBUG] - wget is unknown, please add it to the PATH
)

WHERE ffmpeg
IF %ERRORLEVEL% NEQ 0 (
	echo "[DEBUG] - ffmpeg command is unknown, please add it to the PATH
)
echo.
echo.




echo ------ EXPLANATION -------
echo this script will use a txt file as input parameter.
echo It will run Download_Video_with_m4s_segment_with_extra_audio_v01.bat with 3 parameters
echo the 3 parameters are in the txt file, every 3 lines it will be a new start
echo 1 parameter: url of the segment-x.m4s
echo 2 parameter: url of the mp4 (actually the audio - can keep the range cf sed code)
echo 3 parameter: name of ouput file
echo.

set /p list="Give me the path of your list with url from segment-1.m4s, url audio (also with range), title :  "


sed -i -E "s/(.*)\?range.*/\1/g" %list%


:: count the number of line file
wc -l < %list% >temp
set /p nlines=<temp
echo nlines: %nlines%
echo.
rm temp


:: loop every 3 lines in the files and do the rest
FOR /L %%p IN (1, 3, %nlines%) DO (
	
	:: prepare lines number 1 to 3
	set /a l1=%%p
	set /a l2=%%p+1
	set /a l3=%%p+2
	
	:: extract lines for variable 
	sed -n !l1!p %list% > temp1
	sed -n !l2!p %list% > temp2
	sed -n !l3!p %list% > temp3
	
	:: assign variable
	set /p url=<temp1
	set /p aud=<temp2
	set /p name=<temp3
	
	
	:: rm temp files
	rm temp1 temp2 temp3
	
	echo.
	echo [DEBUG]
	echo url: !url!
	echo aud: !aud!
	echo name: !name!
	echo.

	:: INFO: do not use "call" if you have % in your parameters (like in url)
	:: INFO: do not use without cmd /c because it will keep it open and will not close the new cmd and not continue
	echo call C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\Batch\Video\Download_Video_with_m4s_segment_with_extra_audio_v02.bat "!url!" "!aud!" "!name!"
	REM call C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\Batch\Video\Download_Video_with_m4s_segment_with_extra_audio_v02.bat "!url!" "!aud!" "!name!"
	start /wait cmd /c C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\Batch\Video\Download_Video_with_m4s_segment_with_extra_audio_v02.bat "!url!" "!aud!" "!name!"
)






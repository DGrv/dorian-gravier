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

echo Will add text overlay where you want on your video
echo [91mYou can use \n in your string to create new line !!!![0m

echo.
echo Your ffmpeg is here:
WHERE ffmpeg
IF %ERRORLEVEL% NEQ 0 (
	echo "[DEBUG] - ffmpeg command is unknown, please add it to the PATH
)
echo.

if "%1"=="" (
	set /p pathfile="Give me the Video path: "
) else (
	set pathfile=%1
) 
 
for %%a in (%pathfile%) do (
	set pathh=%%~dpa
	set filename=%%~nxa
	set filenamenoext=%%~na
	set filepathnoext=%%~dpna
	set ext=%%~xa
	set drive=%%~da
)  
REM echo pathh=%pathh%
REM echo filename=%filename%
REM echo filenamenoext=%filenamenoext%
REM echo filepathnoext=%filepathnoext%
REM echo drive=%drive%
REM echo wd=%wd%
%drive%
cd "%pathh%"

echo [95m[DEBUG] ---------------------
echo 1 = %1
echo 2 = %2
echo 3 = %3
echo 4 = %4
echo 5 = %5
echo ----------------------[0m



if [%2]==[] (
	set /p timeuser="At which time to start and stop in form of 'start,stop', e.g '0,20': "
) else (
	set timeuser=%2
	set timeuser=!timeuser:"=!
)
:: need this to remove the " from the lua script mpv
if "%timeuser:~1,1%"=="," (
	set time1=%timeuser:~0,1%
	set time2=%timeuser:~2,3%
) else (
	if "%timeuser:~2,1%"=="," (
		set time1=%timeuser:~0,2%
		set time2=%timeuser:~3,3%
	) else (
		set time1=%timeuser:~0,3%
		set time2=%timeuser:~4,4%
	)
)


:: use %~1 instead of %1 if you have space in the text
:: use %~1 instead of %1 if you have space in the text
:: use %~1 instead of %1 if you have space in the text
:: use %~1 instead of %1 if you have space in the text

if "%~6"=="" (
	echo [91m
	set /p text=Give me you text: You can use \n in your string to create new line !!!! :[0m 
	echo [0m
) else (
	set text=%~6
) 
REM echo|set /p=%text%>temp.txt :: this was to avoid \n in the file
set "text=%text:(=^(%"
set "text=%text:)=^)%"
set "text=%text:\n\n= >> temp.txt & echo. >> temp.txt & echo %"
set "text=%text:\n= >> temp.txt & echo %"
set "text=%text:"=%"
if exist "temp.txt" rm temp.txt
echo %text% >> temp.txt
truncate -s -2 temp.txt

:: Cols:\n- Port de Lers (1517m) avec le col d'Agnès (1570m)\n- Col de la Core (1395m)\n- Col de Menté (1349m)\n- Col de Peyresourde (1569m)\n- Col du Tourmalet (2115m)\n- Col d'Aubisque (1709m)\n- Col de Marie-Blanque (1035m)\n- Col de Labays (1354m)



if "%3"=="" (
	set /p fontsize="Give me your fontsize (Try big first, maybe 50, nothing will be 50): "
) else (
	set fontsize=%3
) 
if [%fontsize%]==[] (
	set fontsize=50
)




REM echo filenamenoext : %filenamenoext%

echo.
echo "--------------------------------"
echo "| TL          TC            TR |"
echo "|                              |"
echo "| LC          C             RC |"
echo "|                              |"
echo "| BL          BC            BR |"
echo "--------------------------------"
echo.



echo Give a x position (0.1 will be on the left, 0.9 will be on the right)
if "%4"=="" (
	set /p xpos="Or give BL (bottom right), TR (top left) ... (nothing will be TR): "
) else (
	set xpos=%4
) 
if "%xpos%"=="" (
	set xpos=TR
)




set /a check=%DATE:~0,1%
set check2=%DATE:~0,1%
if "%check%"=="%check2%" (
	set TIMESTAMP=%DATE:~6,4%%DATE:~3,2%%DATE:~0,2%-%TIME:~0,2%%TIME:~3,2%
) else (
	set TIMESTAMP=%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%-%TIME:~0,2%%TIME:~3,2%
)

set filenamenew=%filenamenoext%_old_%TIMESTAMP%.mp4

echo.
echo.
echo [95m[DEBUG] ---------------------
echo cd = %cd%
echo pathfile = %pathfile%
echo pathh = %pathh%
echo timeuser = %timeuser%
echo fontsize = %fontsize%
echo xpos = %xpos% 
echo ypos = %ypos% 
echo check = %check%
echo check2 = %check2%
echo filename = %filename%
echo filenamenew = %filenamenew%
echo rename "%filename%" "%filenamenew%"
echo.
echo cat temp.txt
cat temp.txt
echo.
echo ----------------------[0m


set posstay=3


rename "%filename%" "%filenamenew%"

if "%xpos%"=="TL" (
	set xpos=0.05
	set ypos=0.05
	ffmpeg -stats -loglevel error -i "%filenamenew%" -vf "drawtext=text='youhou': fontcolor=white: fontfile='Arial': fontsize=50: box=1: boxcolor=Black@0.5:boxborderw=10: x=if(gte(t\,%time1%+%posstay%)\, w*%xpos%-w/10*(t-%time1%-%posstay%)\,if(gte(-w*0.2-tw+w/10*t\,w*%xpos%)\, w*%xpos%\, -w*0.2-tw+w/10*t)): y=h*%ypos%: enable='between(t,%timeuser%)'" -"%filename%"
	REM ffmpeg -stats -loglevel error -i "%filenamenew%" -vf "drawtext=textfile=temp.txt: fontcolor=white: fontfile='Arial': fontsize=%fontsize%: box=1: boxcolor=Black@0.5:boxborderw=10: x=w*!xpos!:y=h*!ypos!:enable='between(t,%timeuser%)'" -vcodec libx264 -x264-params keyint=24:scenecut=0 -c:a copy "%filename%"
	GOTO :end
)
if "%xpos%"=="TC" (
	set xpos=0.5
	set ypos=0.05
	ffmpeg -stats -loglevel error -i "%filenamenew%" -vf "drawtext=text='youhou': fontcolor=white: fontfile='Arial': fontsize=50: box=1: boxcolor=Black@0.5:boxborderw=10: y=if(gte(t\,%time1%+%posstay%)\, h*%ypos%-h/10*(t-%time1%-%posstay%)\,if(gte(-h*0.2-th+h/10*t\,h*%ypos%)\, h*%ypos%\, -h*0.2-th+h/10*t)): x=w*%xpos%: enable='between(t,%timeuser%)'" -"%filename%"
	REM ffmpeg -stats -loglevel error -i "%filenamenew%" -vf "drawtext=textfile=temp.txt: fontcolor=white: fontfile='Arial': fontsize=%fontsize%: box=1: boxcolor=Black@0.5:boxborderw=10: x=((w-text_w)/2):y=h*!ypos!:enable='between(t,%timeuser%)'" -vcodec libx264 -x264-params keyint=24:scenecut=0 -codec:a copy "%filename%"
	GOTO :end
)
if "%xpos%"=="TR" (
	set xpos=0.95
	set ypos=0.05
	ffmpeg -stats -loglevel error -i "%filenamenew%" -vf "drawtext=text='youhou': fontcolor=white: fontfile='Arial': fontsize=50: box=1: boxcolor=Black@0.5:boxborderw=5: x=if(gte(t\,%time1%+%posstay%)\, w*%xpos%-tw+w/10*(t-%time1%-%posstay%)\,if(lt(w+w*0.2-w/10*t\,w*%xpos%-tw)\, w*%xpos%-tw\, w+w*0.2-w/10*t)): y=h*%ypos%: enable='between(t,2,20)'" -"%filename%"
	REM ffmpeg -stats -loglevel error -i "%filenamenew%" -vf "drawtext=textfile=temp.txt: fontcolor=white: fontfile='Arial': fontsize=%fontsize%: box=1: boxcolor=Black@0.5:boxborderw=10: x=w*!xpos!-text_w:y=h*!ypos!:enable='between(t,%timeuser%)'" -vcodec libx264 -x264-params keyint=24:scenecut=0 -codec:a copy "%filename%"
	GOTO :end
)
if "%xpos%"=="LC" (
	set xpos=0.05
	set ypos=0.5
	ffmpeg -stats -loglevel error -i "%filenamenew%" -vf "drawtext=text='youhou': fontcolor=white: fontfile='Arial': fontsize=50: box=1: boxcolor=Black@0.5:boxborderw=10: x=if(gte(t\,%time1%+%posstay%)\, w*%xpos%-w/10*(t-%time1%-%posstay%)\,if(gte(-w*0.2-tw+w/10*t\,w*%xpos%)\, w*%xpos%\, -w*0.2-tw+w/10*t)): y=h*%ypos%: enable='between(t,%timeuser%)'" -"%filename%"
	REM ffmpeg -stats -loglevel error -i "%filenamenew%" -vf "drawtext=textfile=temp.txt: fontcolor=white: fontfile='Arial': fontsize=%fontsize%: box=1: boxcolor=Black@0.5:boxborderw=10: x=w*!xpos!:y=h*!ypos!:enable='between(t,%timeuser%)'" -vcodec libx264 -x264-params keyint=24:scenecut=0 -codec:a copy "%filename%"
	GOTO :end
)
if "%xpos%"=="C" (
	set xpos=0.5
	set ypos=0.5
	ffmpeg -stats -loglevel error -i "%filenamenew%" -vf "drawtext=text='youhou': fontcolor=white: fontfile='Arial': fontsize=50: box=1: boxcolor=Black@0.5:boxborderw=5: x=if(gte(t\,%time1%+%posstay%)\, w*%xpos%-tw+w/10*(t-%time1%-%posstay%)\,if(lt(w+w*0.2-w/10*t\,w*%xpos%-tw)\, w*%xpos%-tw\, w+w*0.2-w/10*t)): y=h*%ypos%: enable='between(t,2,20)'" -"%filename%"
	REM ffmpeg -stats -loglevel error -i "%filenamenew%" -vf "drawtext=textfile=temp.txt: fontcolor=white: fontfile='Arial': fontsize=%fontsize%: box=1: boxcolor=Black@0.5:boxborderw=10: x=((w-text_w)/2):y=h*!ypos!:enable='between(t,%timeuser%)'" -vcodec libx264 -x264-params keyint=24:scenecut=0 -codec:a copy "%filename%"
	GOTO :end
)
if "%xpos%"=="RC" (
	set xpos=0.95
	set ypos=0.5
	ffmpeg -stats -loglevel error -i "%filenamenew%" -vf "drawtext=text='youhou': fontcolor=white: fontfile='Arial': fontsize=50: box=1: boxcolor=Black@0.5:boxborderw=10: x=if(gte(t\,%time1%+%posstay%)\, w*%xpos%-w/10*(t-%time1%-%posstay%)\,if(gte(-w*0.2-tw+w/10*t\,w*%xpos%)\, w*%xpos%\, -w*0.2-tw+w/10*t)): y=h*%ypos%: enable='between(t,%timeuser%)'" -"%filename%"
	REM ffmpeg -stats -loglevel error -i "%filenamenew%" -vf "drawtext=textfile=temp.txt: fontcolor=white: fontfile='Arial': fontsize=%fontsize%: box=1: boxcolor=Black@0.5:boxborderw=10: x=w*!xpos!-text_w:y=h*!ypos!:enable='between(t,%timeuser%)'" -vcodec libx264 -x264-params keyint=24:scenecut=0 -codec:a copy "%filename%"
	GOTO :end
)
if "%xpos%"=="BL" (
	set xpos=0.05
	set ypos=0.90
	ffmpeg -stats -loglevel error -i "%filenamenew%" -vf "drawtext=text='youhou': fontcolor=white: fontfile='Arial': fontsize=50: box=1: boxcolor=Black@0.5:boxborderw=10: y=if(gte(t\,%time1%+%posstay%)\, h*%ypos%+h/10*(t-%time1%-%posstay%)\,if(lt(h+h*0.2-h/10*t\,h*%ypos%)\, h*%ypos%\, h+h*0.2-h/10*t)): x=w*%xpos%: enable='between(t,%timeuser%)'" -"%filename%"
	REM ffmpeg -stats -loglevel error -i "%filenamenew%" -vf "drawtext=textfile=temp.txt: fontcolor=white: fontfile='Arial': fontsize=%fontsize%: box=1: boxcolor=Black@0.5:boxborderw=10: x=w*!xpos!:y=h*!ypos!:enable='between(t,%timeuser%)'" -vcodec libx264 -x264-params keyint=24:scenecut=0 -codec:a copy "%filename%"
	GOTO :end
)
if "%xpos%"=="BC" (
	set xpos=0.5
	set ypos=0.9
	REM ffmpeg -stats -loglevel error -i "%filenamenew%" -vf "drawtext=textfile=temp.txt: fontcolor=white: fontfile='Arial': fontsize=%fontsize%: box=1: boxcolor=Black@0.5:boxborderw=10: x=((w-text_w)/2):y=h*!ypos!:enable='between(t,%timeuser%)'" -vcodec libx264 -x264-params keyint=24:scenecut=0 -codec:a copy "%filename%"
	GOTO :end
)
if "%xpos%"=="BR" (
	set xpos=0.95
	set ypos=0.90
	ffmpeg -stats -loglevel error -i "%filenamenew%" -vf "drawtext=text='youhou': fontcolor=white: fontfile='Arial': fontsize=50: box=1: boxcolor=Black@0.5:boxborderw=5: x=if(gte(t\,%time1%+%posstay%)\, w*%xpos%-tw+w/10*(t-%time1%-%posstay%)\,if(lt(w+w*0.2-w/10*t\,w*%xpos%-tw)\, w*%xpos%-tw\, w+w*0.2-w/10*t)): y=h*%ypos%: enable='between(t,2,20)'" -"%filename%"
	REM ffmpeg -stats -loglevel error -i "%filenamenew%" -vf "drawtext=textfile=temp.txt: fontcolor=white: fontfile='Arial': fontsize=%fontsize%: box=1: boxcolor=Black@0.5:boxborderw=10: x=w*!xpos!-text_w:y=h*!ypos!:enable='between(t,%timeuser%)'" -vcodec libx264 -x264-params keyint=24:scenecut=0 -codec:a copy "%filename%"
	GOTO :end
) else (
	set /p ypos="Give me your y position (0.1 will be on the top, 0.9 will be on the bottom): "
	ffmpeg -stats -loglevel error -i "%filenamenew%" -vf "drawtext=textfile=temp.txt: fontcolor=white: fontfile='Arial': fontsize=%fontsize%: box=1: boxcolor=Black@0.5:boxborderw=10: x=w*!xpos!:y=h*!ypos!:enable='between(t,%timeuser%)'" -vcodec libx264 -x264-params keyint=24:scenecut=0 -codec:a copy "%filename%"
)






:end

del temp.txt


:: souLCe https://stackoverflow.com/questions/17623676/text-on-video-ffmpeg
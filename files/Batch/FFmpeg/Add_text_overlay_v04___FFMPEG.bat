@echo off
setlocal EnableDelayedExpansion

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
echo [91mYou can use  in your string to create new line !!!![37m

echo.
echo Your ffmpeg is here:
WHERE ffmpeg
IF %ERRORLEVEL% NEQ 0 (
	echo [DEBUG] - ffmpeg command is unknown, please add it to the PATH
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
%drive%
cd "%pathh%"




if q%2q==qq (
	set /p times1="At which time to start: "
) else (
	set times1=%2
) 

set times1=%times1:"=%

if q%3q==qq (
	set /p times2="At which time to stop: "
) else (
	set times2=%3
) 

set times2=%times2:"=%



if "%4"=="" (
	set /p fontsize="Give me your fontsize (Try big first, maybe 50, nothing will be 50): "
) else (
	set fontsize=%4
) 
if [%fontsize%]==[] (
	set fontsize=50
)
set /a fontsize2=fontsize/3*2


if "%~6"=="" (
	echo [91m
	set /p text="Give me you text: You can use \n in your string to create new line:  [37m"
	echo [37m
) else (
	set text=%~6
) 



:: use %~1 instead of %1 if you have space in the text
:: use %~1 instead of %1 if you have space in the text
:: use %~1 instead of %1 if you have space in the text
:: use %~1 instead of %1 if you have space in the text

set ft1=%filenamenoext%_old_temp.txt
if "%text%"=="" (
	touch %ft1%
	GOTO continue1
)

:: do not know why but I can not put this in a if so I used GOTO
set "text=%text:!=^!%"
set "text=%text:(=^(%"
set "text=%text:)=^)%"
set "text=%text:\n\n= & echo. & echo %"
set "text=%text:\n= & echo %"
set "text=%text:"=%"
REM if exist "%ft1%" rm %ft1%
(echo %text%) > %ft1%
truncate -s -2 %ft1%

:continue1


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

if "%5"=="" (
	set /p xpos="Or give BL (bottom right), TR (top left) ... (nothing will be TR):  [37m"
) else (
	set xpos=%5
) 



if "%xpos%"=="" (
	set xpos=TR
)
if "%xpos%"=="TR" (
	echo [91m
	set /p text2="Give me you TRANSLATED text (write nothing if you want nothing):  [37m" 
	echo [37m
)
if "%xpos%"=="TL" (
	echo [91m
	set /p text2="Give me you TRANSLATED text (write nothing if you want nothing):  [37m"
	echo [37m
)




set ft2=%filenamenoext%_old_temp2.txt
if "%text2%"=="" (
	touch %ft2%
	goto continue2
)

set "text2=%text2:!=^!%"
set "text2=%text2:(=^(%"
set "text2=%text2:)=^)%"
set "text2=%text2:"=%"
(echo %text2%) > %ft2%
truncate -s -2 %ft2%

:continue2

REM FOR /F %%A IN ('WMIC OS GET LocalDateTime ^| FINDSTR \.') DO @SET time=%%A
REM set TIMESTAMP=%time:~0,8%-%time:~8,6%
for /f %%p in ('bash -c "date +"%%Y%%m%%d-%%H%%M%%S""') do set TIMESTAMP=%%p

set filenamenew=%filenamenoext%_old_%TIMESTAMP%.mp4

echo.
echo.

echo [95m[DEBUG] ---------------------
echo 1 = %1
echo 2 = %2
echo 3 = %3
echo 4 = %4
echo 5 = %5
echo 6 = %6
echo set cd=%cd%
echo set pathfile=%pathfile%
echo set pathh=%pathh%
echo set times1=%times1%
echo set times2=%times2%
echo set fontsize=%fontsize%
echo set xpos=%xpos% 
echo set filename=%filename%
echo set filenamenew=%filenamenew%
echo set rename "%filename%" "%filenamenew%"
echo.
echo cat %ft1%
cat %ft1%
echo.
echo cat %ft2%
cat %ft2%
echo.
echo ----------------------[37m



rename "%filename%" "%filenamenew%"

if "%xpos%"=="TL" (
	set xpos=0.05
	set ypos=0.05
	REM ffmpeg -stats -loglevel error -i "%filenamenew%" -vf "drawtext=textfile=%ft1%: fontcolor=white: fontfile='C\:\\Windows\\Fonts\\calibri.ttf': fontsize=50: box=1: boxcolor=Black@0.5:boxborderw=10: x=if(gte(t\,%time1%+%posstay%)\, w*!xpos!-w/8*(t-%time1%-%posstay%)\,if(gte(-w*0.1-tw+w/8*t\,w*!xpos!)\, w*!xpos!\, -w*0.1-tw+w/8*t)): y=h*!ypos!: enable='between(t,%times1%,%times2%)'" "%filename%"
	ffmpeg -stats -loglevel error -i "%filenamenew%" -vf "drawtext=textfile=%ft1%: fontcolor=white: fontfile='C\:\\Windows\\Fonts\\calibri.ttf': fontsize=%fontsize%: box=1: boxcolor=Black@0.5:boxborderw=10: x=w*!xpos!:y=h*!ypos!:enable='between(t,%times1%,%times2%)',drawtext=textfile=%ft2%: fontcolor=white: fontfile='C\:\\Windows\\Fonts\\Ariali.ttf': fontsize=%fontsize2%: box=1: boxcolor=Black@0.5 : boxborderw=10 : x=w*!xpos!:y=h*(!ypos!+0.07) : enable='between(t,%times1%,%times2%)'" -c:a copy "%filename%"
	GOTO :end
)
if "!xpos!"=="TC" (
	set xpos=0.5
	set ypos=0.05
	REM ffmpeg -stats -loglevel error -i "%filenamenew%" -vf "drawtext=textfile=%ft1%: fontcolor=white: fontfile='C\:\\Windows\\Fonts\\calibri.ttf': fontsize=50: box=1: boxcolor=Black@0.5:boxborderw=10: y=if(gte(t\,%time1%+%posstay%)\, h*!ypos!-h/8*(t-%time1%-%posstay%)\,if(gte(-h*0.1-th+h/8*t\,h*!ypos!)\, h*!ypos!\, -h*0.1-th+h/8*t)): x=w*!xpos!: enable='between(t,%times1%,%times2%)'" "%filename%"
	ffmpeg -stats -loglevel error -i "%filenamenew%" -vf "drawtext=textfile=%ft1%: fontcolor=white: fontfile='C\:\\Windows\\Fonts\\calibri.ttf': fontsize=%fontsize%: box=1: boxcolor=Black@0.5:boxborderw=10: x=((w-text_w)/2):y=h*!ypos!:enable='between(t,%times1%,%times2%)'" -codec:a copy "%filename%"
	GOTO :end
)
if "!xpos!"=="TR" (
	set xpos=0.95
	set ypos=0.05
	REM ffmpeg -stats -loglevel error -i "%filenamenew%" -vf "drawtext=textfile=%ft1%: fontcolor=white: fontfile='C\:\\Windows\\Fonts\\calibri.ttf': fontsize=50: box=1: boxcolor=Black@0.5:boxborderw=5: x=if(gte(t\,%time1%+%posstay%)\, w*!xpos!-tw+w/8*(t-%time1%-%posstay%)\,if(lt(w+w*0.1-w/8*t\,w*!xpos!-tw)\, w*!xpos!-tw\, w+w*0.1-w/8*t)): y=h*!ypos!: enable='between(t,%times1%,%times2%)'" "%filename%"
	ffmpeg -stats -loglevel error -i "%filenamenew%" -vf "drawtext=textfile=%ft1%: fontcolor=white: fontfile='C\:\\Windows\\Fonts\\calibri.ttf': fontsize=%fontsize%: box=1: boxcolor=Black@0.5:boxborderw=10: x=w*!xpos!-text_w:y=h*!ypos!:enable='between(t,%times1%,%times2%)',drawtext=textfile=%ft2%: fontcolor=white: fontfile='C\:\\Windows\\Fonts\\Ariali.ttf': fontsize=%fontsize2%: box=1: boxcolor=Black@0.5 : boxborderw=10 : x=w*!xpos!-text_w:y=h*(!ypos!+0.07) : enable='between(t,%times1%,%times2%)'" -codec:a copy "%filename%"
	GOTO :end
)
if "!xpos!"=="LC" (
	set xpos=0.05
	set ypos=0.5
	REM ffmpeg -stats -loglevel error -i "%filenamenew%" -vf "drawtext=textfile=%ft1%: fontcolor=white: fontfile='C\:\\Windows\\Fonts\\calibri.ttf': fontsize=50: box=1: boxcolor=Black@0.5:boxborderw=10: x=if(gte(t\,%time1%+%posstay%)\, w*!xpos!-w/8*(t-%time1%-%posstay%)\,if(gte(-w*0.1-tw+w/8*t\,w*!xpos!)\, w*!xpos!\, -w*0.1-tw+w/8*t)): y=h*!ypos!: enable='between(t,%times1%,%times2%)'" "%filename%"
	ffmpeg -stats -loglevel error -i "%filenamenew%" -vf "drawtext=textfile=%ft1%: fontcolor=white: fontfile='C\:\\Windows\\Fonts\\calibri.ttf': fontsize=%fontsize%: box=1: boxcolor=Black@0.5:boxborderw=10: x=w*!xpos!:y=h*!ypos!:enable='between(t,%times1%,%times2%)'" -codec:a copy "%filename%"
	GOTO :end
)
if "!xpos!"=="C" (
	set xpos=0.5
	set ypos=0.5
	REM ffmpeg -stats -loglevel error -i "%filenamenew%" -vf "drawtext=textfile=%ft1%: fontcolor=white: fontfile='C\:\\Windows\\Fonts\\calibri.ttf': fontsize=50: box=1: boxcolor=Black@0.5:boxborderw=5: x=if(gte(t\,%time1%+%posstay%)\, w*!xpos!-tw+w/8*(t-%time1%-%posstay%)\,if(lt(w+w*0.1-w/8*t\,w*!xpos!-tw)\, w*!xpos!-tw\, w+w*0.1-w/8*t)): y=h*!ypos!: enable='between(t,%times1%,%times2%)'" "%filename%"
	ffmpeg -stats -loglevel error -i "%filenamenew%" -vf "drawtext=textfile=%ft1%: fontcolor=white: fontfile='C\:\\Windows\\Fonts\\calibri.ttf': fontsize=%fontsize%: box=1: boxcolor=Black@0.5:boxborderw=10: x=((w-text_w)/2):y=h*!ypos!:enable='between(t,%times1%,%times2%)'" -codec:a copy "%filename%"
	GOTO :end
)
if "!xpos!"=="RC" (
	set xpos=0.95
	set ypos=0.5
	REM ffmpeg -stats -loglevel error -i "%filenamenew%" -vf "drawtext=textfile=%ft1%: fontcolor=white: fontfile='C\:\\Windows\\Fonts\\calibri.ttf': fontsize=50: box=1: boxcolor=Black@0.5:boxborderw=10: x=if(gte(t\,%time1%+%posstay%)\, w*!xpos!-w/8*(t-%time1%-%posstay%)\,if(gte(-w*0.1-tw+w/8*t\,w*!xpos!)\, w*!xpos!\, -w*0.1-tw+w/8*t)): y=h*!ypos!: enable='between(t,%times1%,%times2%)'" "%filename%"
	ffmpeg -stats -loglevel error -i "%filenamenew%" -vf "drawtext=textfile=%ft1%: fontcolor=white: fontfile='C\:\\Windows\\Fonts\\calibri.ttf': fontsize=%fontsize%: box=1: boxcolor=Black@0.5:boxborderw=10: x=w*!xpos!-text_w:y=h*!ypos!:enable='between(t,%times1%,%times2%)'" -codec:a copy "%filename%"
	GOTO :end
)
if "!xpos!"=="BL" (
	set xpos=0.05
	set ypos=0.90
	REM ffmpeg -stats -loglevel error -i "%filenamenew%" -vf "drawtext=textfile=%ft1%: fontcolor=white: fontfile='C\:\\Windows\\Fonts\\calibri.ttf': fontsize=50: box=1: boxcolor=Black@0.5:boxborderw=10: y=if(gte(t\,%time1%+%posstay%)\, h*!ypos!+h/8*(t-%time1%-%posstay%)\,if(lt(h+h*0.1-h/8*t\,h*!ypos!)\, h*!ypos!\, h+h*0.1-h/8*t)): x=w*!xpos!: enable='between(t,%times1%,%times2%)'" "%filename%"
	ffmpeg -stats -loglevel error -i "%filenamenew%" -vf "drawtext=textfile=%ft1%: fontcolor=white: fontfile='C\:\\Windows\\Fonts\\calibri.ttf': fontsize=%fontsize%: box=1: boxcolor=Black@0.5:boxborderw=10: x=w*!xpos!:y=h*!ypos!:enable='between(t,%times1%,%times2%)'" -codec:a copy "%filename%"
	GOTO :end
)
if "!xpos!"=="BC" (
	set xpos=0.5
	set ypos=0.9
	ffmpeg -stats -loglevel error -i "%filenamenew%" -vf "drawtext=textfile=%ft1%: fontcolor=white: fontfile='C\:\\Windows\\Fonts\\calibri.ttf': fontsize=%fontsize%: box=1: boxcolor=Black@0.5:boxborderw=10: x=((w-text_w)/2):y=h*!ypos!:enable='between(t,%times1%,%times2%)'" -codec:a copy "%filename%"
	GOTO :end
)
if "!xpos!"=="BR" (
	set xpos=0.95
	set ypos=0.90
	REM ffmpeg -stats -loglevel error -i "%filenamenew%" -vf "drawtext=textfile=%ft1%: fontcolor=white: fontfile='C\:\\Windows\\Fonts\\calibri.ttf': fontsize=50: box=1: boxcolor=Black@0.5:boxborderw=5: x=if(gte(t\,%time1%+%posstay%)\, w*!xpos!-tw+w/8*(t-%time1%-%posstay%)\,if(lt(w+w*0.1-w/8*t\,w*!xpos!-tw)\, w*!xpos!-tw\, w+w*0.1-w/8*t)): y=h*!ypos!: enable='between(t,%times1%,%times2%)'" "%filename%"
	ffmpeg -stats -loglevel error -i "%filenamenew%" -vf "drawtext=textfile=%ft1%: fontcolor=white: fontfile='C\:\\Windows\\Fonts\\calibri.ttf': fontsize=%fontsize%: box=1: boxcolor=Black@0.5:boxborderw=10: x=w*!xpos!-text_w:y=h*!ypos!:enable='between(t,%times1%,%times2%)'" -codec:a copy "%filename%"
	GOTO :end
) else (
	set /p ypos="Give me your y position (0.1 will be on the top, 0.9 will be on the bottom): "
	ffmpeg -stats -loglevel error -i "%filenamenew%" -vf "drawtext=textfile=%ft1%: fontcolor=white: fontfile='C\:\\Windows\\Fonts\\calibri.ttf': fontsize=%fontsize%: box=1: boxcolor=Black@0.5:boxborderw=10: x=w*!xpos!:y=h*!ypos!:enable='between(t,%times1%,%times2%)'" -codec:a copy "%filename%"
)





:end

del %ft1% %ft2%


:: souLCe https://stackoverflow.com/questions/17623676/text-on-video-ffmpeg
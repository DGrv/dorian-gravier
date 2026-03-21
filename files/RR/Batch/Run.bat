@echo OFF
setlocal enabledelayedexpansion

echo @echo OFF > spare.bat
REM to handle utf8 from ag
echo chcp 65001 >> spare.bat
curl https://api.raceresult.com/372967/6USSDYZ82FWC017VWDCKFOU6GG3HLPLX >> spare.bat
echo.
for %%i in ("*.csv") do (
	echo [31mHEADER:[37m
	echo [33m%%~nxi[37m
	REM cat "%%i" | iconv -f Windows-1252 -t utf-8 | head -2 | csview -d ,
	REM Check file encoding using file command
	for /f "tokens=*" %%e in ('file -i "%%i"') do set "encoding=%%e"
		REM Check if encoding contains utf-8
		echo !encoding! | findstr /i "utf-8" >nul
		if !errorlevel! equ 0 (
			cat "%%i" | head -2 | csview -d ,
	) else (
			cat "%%i" | iconv -f Windows-1252 -t utf-8 | head -2 | csview -d ,
	)
)
spare.bat && pause 

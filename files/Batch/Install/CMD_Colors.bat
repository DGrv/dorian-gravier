REM reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT
REM systeminfo | findstr /B /C:"OS Name" /C:"OS Version" | find /i "XP" > NUL && set ver=XP || set ver=other
REM if %OS%==32BIT (
	REM C:\Users\doria\Downloads\Software\ansi189\x86\ansicon.exe -i
REM )
REM if %OS%==64BIT (
	C:\Users\doria\scoop\apps\ansicon\current\ansicon.exe -i
REM )

REM if %ver%==XP (
	REM reg add HKCU\Environment /v PROMPT /d "$e[1;31m$p$s$e[1;34m$g$s$e[1;37m" /f
REM ) else (
	setx prompt $e[1;31m$p$s$e[1;34m$g$s$e[1;37m
REM )

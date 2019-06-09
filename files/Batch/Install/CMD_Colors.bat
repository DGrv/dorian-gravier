reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" | find /i "XP" > NUL && set ver=XP || set ver=other
if %OS%==32BIT (
	if exist H:\ (
		H:
		H:\TEMP\Software\ansi189\x86\ansicon.exe -i
	) else (
		X:
		X:\TEMP\Software\ansi189\x86\ansicon.exe -i
	)
)
if %OS%==64BIT (
	if exist H:\ (
		H:
		H:\TEMP\Software\ansi189\x64\ansicon.exe -i
	) else (
		X:
		X:\TEMP\Software\ansi189\x64\ansicon.exe -i
	)
)

if %ver%==XP (
	reg add HKCU\Environment /v PROMPT /d "$e[1;31m$p$s$e[1;34m$g$s$e[1;37m" /f
) else (
	setx prompt $e[1;31m$p$s$e[1;34m$g$s$e[1;37m
)

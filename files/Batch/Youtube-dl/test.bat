set /a check=%DATE:~5,1%
set check2=%DATE:~5,1%
echo %check%
echo %check2%
if "%check%"=="%check2%" (
	echo numeric
) else (
	echo not numeric
)
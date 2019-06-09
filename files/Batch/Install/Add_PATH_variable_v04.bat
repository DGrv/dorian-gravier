:: Code ----------------------------------------------------------------------------
@echo off
setlocal enableDelayedExpansion


set /p pathwanted="Path you wanna add to the PATH variable: "

echo Do you really want this path added : %pathwanted% ?
echo.
echo To this actual path :
echo. %path%
pause


:: get path and write file with replace ; as LF
set path2=%path%;%pathwanted%
echo %path% > BUpath.txt
for %%a in ("%path2:;=" "%") do echo %%~a >> temp2.txt


:: sort files
setlocal disableDelayedExpansion
set "file=temp2.txt"
set "sorted=%file%.sorted"
set "deduped=%file%.deduped"
::Define a variable containing a linefeed character
set LF=^


::The 2 blank lines above are critical, do not remove
sort "%file%" > "%sorted%"
>"%deduped%" (
  set "prev="
  for /f usebackq^ eol^=^%LF%%LF%^ delims^= %%A in ("%sorted%") do (
    set "ln=%%A"
    setlocal enableDelayedExpansion
    if /i "!ln!" neq "!prev!" (
      endlocal
      (echo %%A)
      set "prev=%%A"
    ) else endlocal
  )
)
>nul move /y "%deduped%" "%file%"
del "%sorted%"
:: end sort file


(set all=)
FOR /f "delims=" %%x IN (temp2.txt) DO call SET all=%%all%%;%%x
set all="%all%;"
set all=%all: ;=;%
set all=%all:~1,20000%

:: remove the '%all%; in the string
echo %all% > NEWpath.txt
echo %all%

setx path %all%
del temp2.txt

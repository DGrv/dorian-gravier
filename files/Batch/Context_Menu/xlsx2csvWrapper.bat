@echo off
REM %~nx1 = filename with extension, no path
REM optional: cd /d %~dp1  to switch to file directory
cd /d %~dp1
REM echo %CD%
C:\Users\doria\scoop\apps\libreoffice\current\LibreOffice\program\soffice.exe  --headless --convert-to csv --outdir "%cd%" %1"
REM pause
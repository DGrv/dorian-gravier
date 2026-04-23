@echo off
REM %~nx1 = filename with extension, no path
REM optional: cd /d %~dp1  to switch to file directory
cd /d "%~dp1"
REM echo %CD%
REM C:\Users\doria\scoop\apps\libreoffice\current\LibreOffice\program\soffice.exe  --headless --convert-to csv --outdir "%cd%" %1"
python "C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\Python\RR\Export_sheets_xlsx2csv_single_v01.py" "$1"
REM pause
@echo off
REM %~nx1 = filename with extension, no path
REM optional: cd /d %~dp1  to switch to file directory
cd /d %~dp1
REM echo %CD%
magick "%1" "%~nx1.pdf"
REM pause
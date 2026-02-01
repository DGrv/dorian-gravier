@echo off
REM %~nx1 = filename with extension, no path
REM optional: cd /d %~dp1  to switch to file directory
cd /d %~dp1
REM echo %CD%
C:\Users\doria\AppData\Local\Microsoft\WindowsApps\bash.exe -c "source ~/.bashrc;addts '%~nx1'"
REM pause
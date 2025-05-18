xcopy C:\Users\doria\scoop\persist\freecommander\Settings C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\configBU\FreeCommander /Y
xcopy C:\Users\doria\scoop\persist\mpv\portable_config C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\configBU\mpv /Y /E /EXCLUDE:exclude_mpv.txt
xcopy C:\Users\doria\scoop\persist\notepadplusplus C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\configBU\notepad /Y /E /EXCLUDE:exclude_notepad.txt

:: get timestamp
@REM for /f %p in ('bash -c "date +"%Y%m%d-%H%M%S""') do set TIMESTAMP=%p
for /f %%p in ('bash -c "date +"%%Y%%m%%d-%%H%%M%%S""') do set TIMESTAMP=%%p

:: vscodium -----------------------------
copy C:\Users\doria\scoop\apps\vscodium\current\data\user-data\User\keybindings.json C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\configBU\vscodium\keybindings_%TIMESTAMP%.json
copy C:\Users\doria\scoop\apps\vscodium\current\data\user-data\User\settings.json C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\configBU\vscodium\settings_%TIMESTAMP%.json 
copy C:\Users\doria\scoop\apps\vscodium\current\data\extensions\extensions.json C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\configBU\vscodium\extensions_%TIMESTAMP%.json 

:: Timetrap ------------------------
echo Put this at the end !!!!!!!!!!!!!!!!!
t d -f csv > C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\configBU\timetrap\%TIMESTAMP%_timetrap.csv
rscript "C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\RR\Timetrap_v01.R"


REM :: Thunderbird ------------------------
REM set "processname=thunderbird.exe"
REM tasklist /FI "IMAGENAME eq %processname%" 2>NUL | find /I "%processname%" >NUL
REM if "%ERRORLEVEL%"=="0" (
    REM echo %processname% is running. Attempting to close it...
    REM taskkill /IM "%processname%" /F
    REM echo %processname% closed.
REM ) else (
    REM echo %processname% is not running.
REM )
REM :: Set backup destination (Change this to your preferred location)
REM set "backupPath=D:\RR_BU_Email"
REM :: Locate the Thunderbird profile folder
REM set "profilePath=C:\Users\doria\AppData\Roaming\Thunderbird\Profiles\4lopllqe.default-release"
REM :: Define output ZIP file name
REM set "zipFile=%backupPath%\4lopllqe.default-release_%TIMESTAMP%.zip"
REM :: Use PowerShell to zip the folder
REM powershell -command "& {Compress-Archive -Path '%profilePath%' -DestinationPath '%zipFile%' -Force}"
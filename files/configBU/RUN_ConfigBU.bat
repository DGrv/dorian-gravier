xcopy C:\Users\doria\scoop\persist\freecommander\Settings C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\configBU\FreeCommander /Y
xcopy C:\Users\doria\scoop\persist\mpv\portable_config C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\configBU\mpv /Y /E /EXCLUDE:exclude_mpv.txt
xcopy C:\Users\doria\scoop\persist\notepadplusplus C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\configBU\notepad /Y /E /EXCLUDE:exclude_notepad.txt

:: Timetrap ------------------------
:: get timestamp
@REM for /f %p in ('bash -c "date +"%Y%m%d-%H%M%S""') do set TIMESTAMP=%p
for /f %%p in ('bash -c "date +"%%Y%%m%%d-%%H%%M%%S""') do set TIMESTAMP=%%p
t d -f csv > C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\configBU\timetrap\%TIMESTAMP%_timetrap.csv

:: vscodium -----------------------------
copy C:\Users\doria\scoop\apps\vscodium\1.96.2.24355\data\user-data\User\keybindings.json C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\configBU\vscodium\keybindings_%TIMESTAMP%.json
copy C:\Users\doria\scoop\apps\vscodium\1.96.2.24355\data\user-data\User\settings.json C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\configBU\vscodium\settings_%TIMESTAMP%.json 


:: Thunderbird ------------------------
set "processname=thunderbird.exe"
tasklist /FI "IMAGENAME eq %processname%" 2>NUL | find /I "%processname%" >NUL
if "%ERRORLEVEL%"=="0" (
    echo %processname% is running. Attempting to close it...
    taskkill /IM "%processname%" /F
    echo %processname% closed.
) else (
    echo %processname% is not running.
)
:: Set backup destination (Change this to your preferred location)
set "backupPath=D:\RR_BU_Email"
:: Locate the Thunderbird profile folder
set "profilePath=C:\Users\doria\AppData\Roaming\Thunderbird\Profiles\4lopllqe.default-release"
:: Define output ZIP file name
set "zipFile=%backupPath%\4lopllqe.default-release_%TIMESTAMP%.zip"
:: Use PowerShell to zip the folder
powershell -command "& {Compress-Archive -Path '%profilePath%' -DestinationPath '%zipFile%' -Force}"
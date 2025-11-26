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
REM copy C:\Users\doria\.timetrap.db C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\configBU\timetrap\%TIMESTAMP%_.timetrap.db
C:\Users\doria\AppData\Local\Microsoft\WindowsApps\bash.exe -c "source ~/.bashrc;cp ~/.timetrap.db /mnt/c/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/configBU/timetrap/$(date +"%%Y%%m%%d-%%H%%M%%S")_timetrap.db"
REM t d -f csv > C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\configBU\timetrap\%TIMESTAMP%_timetrap.csv
C:\Users\doria\AppData\Local\Microsoft\WindowsApps\bash.exe -c "source ~/.bashrc;t d -f csv > /mnt/c/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/configBU/timetrap/$(date +"%%Y%%m%%d-%%H%%M%%S")_timetrap.csv"
C:\Users\doria\scoop\shims\rscript.exe "C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\RR\Timetrap_v01.R"

::wt windows-terminal
cd C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\configBU\
mkdir wt
copy C:\Users\doria\scoop\apps\windows-terminal\current\settings\settings.json C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\configBU\wt\%TIMESTAMP%_settings.json
copy C:\Users\doria\scoop\apps\windows-terminal\current\settings\settings.json C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\configBU\wt\settings.json /Y

:: wezterm
REM copy C:\Users\doria\scoop\apps\wezterm\current\wezterm.lua C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\configBU\wezterm\%TIMESTAMP%_wezterm.lua


:: synth-shell config
C:\Users\doria\AppData\Local\Microsoft\WindowsApps\bash.exe -c "source ~/.bashrc;")"







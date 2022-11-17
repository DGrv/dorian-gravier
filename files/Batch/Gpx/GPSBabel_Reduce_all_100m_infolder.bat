@echo off
SetLocal EnableDelayedExpansion


echo "--------------------------------------------------------------------------------"
echo "   _____             _                _____                 _                   "
echo "  |  __ \           (_)              / ____|               (_)                  "
echo "  | |  | | ___  _ __ _  __ _ _ __   | |  __ _ __ __ ___   ___  ___ _ __         "
echo "  | |  | |/ _ \| '__| |/ _` | '_ \  | | |_ | '__/ _` \ \ / / |/ _ \ '__|        "
echo "  | |__| | (_) | |  | | (_| | | | | | |__| | | | (_| |\ V /| |  __/ |           "
echo "  |_____/ \___/|_|  |_|\__,_|_| |_|  \_____|_|  \__,_| \_/ |_|\___|_|           "
echo "                                                                                "
echo "--------------------------------------------------------------------------------"
REM http://www.network-science.de/ascii/
echo.


set /p input=Path of your gpx : 

for /F %%i in ("%input%") do @set drive=%%~di

%drive%
cd "%input%"



for %%f in (*.gpx) do (
	rename %%f %%~nf_ori.gpx
	"C:\Program Files (x86)\GPSBabel\gpsbabel.exe" -i gpx -f "%%~nf_ori.gpx" -x simplify,crosstrack,error=0.01k -o gpx -F "%%f"
)



::old method - but when too many files, reach too long cmd
::set f=
::for %%f in (*.gpx) do set f=!f! -f "%%f"
::"C:\Program Files (x86)\GPSBabel\gpsbabel.exe" -i gpx %f% -o gpx -F "temp.gpx"
::"C:\Program Files (x86)\GPSBabel\gpsbabel.exe" -i gpx -f temp.gpx -x duplicate,location,shortname -o gpx -F Merge.gpx
::rm temp.gpx

::https://stackoverflow.com/questions/38554131/merge-all-gpx-files-within-a-folder-into-one-file-with-gpsbabel

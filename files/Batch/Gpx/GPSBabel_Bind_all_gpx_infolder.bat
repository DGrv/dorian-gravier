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


echo Do you wanna remove all :
echo - comments <cmt> balise
echo - description <desc> balise
echo - links with thecrag
set /p rmdesc=and empty latitude [y/n]   
if %rmdesc%==y (
	for %%f in (*.gpx) do (
		echo %input% --- Remove comment and empty latitude --- %%f
		:: remove empty lat and 3 lines afterward
		REM change empty latitude
		sed -i "/wpt lat=\"\"/,/wpt>/d" "%%f"
		sed -i "/wpt lat=\"0.00.*\" lon=\"0.00.*\"/,/wpt>/d" "%%f"
		REM sed -i "/<wpt lat=\"0.* lon=\"0.*>/{n;d}" "%%f"
		REM sed -i "/<wpt lat=\"0.* lon=\"0.*>/{n;d}" "%%f"
		REM sed -i "/<wpt lat=\"0.* lon=\"0.*>/{n;d}" "%%f"
		REM sed -i "/<wpt lat=\"0.* lon=\"0.*>/{n;d}" "%%f"
		REM sed -i "/<wpt lat=\"0.* lon=\"0.*>/{d}" "%%f"
		REM sed -i "/\<link href=\"https\:\/\/www\.thecrag\.com.*/{n;d}" "%%f"
		REM sed -i "/\<link href=\"https\:\/\/www\.thecrag\.com.*/{n;d}" "%%f"
		REM sed -i "/\<link href=\"https\:\/\/www\.thecrag\.com.*/{d}" "%%f"
		:: remove comment
		sed -i "/\<desc\>\|\<\/desc\>/d" "%%f"
		sed -i "/\<cmt\>\|\<\/cmt\>/d" "%%f"
	)
	ls | grep "^sed.*" | xargs rm
)


:: rename first file
for %%f in (*.gpx) do (
	copy "%%f" "Merge.gpx"
	goto :continue
)

:continue
for %%f in (*.gpx) do (
	echo %input% --- GPSBabel --- %%f
	echo.
	
	"C:\Program Files (x86)\GPSBabel\gpsbabel.exe" -i gpx -f Merge.gpx -f "%%f" -x duplicate,location,shortname -o gpx -F Merge.gpx
)


::old method - but when too many files, reach too long cmd
::set f=
::for %%f in (*.gpx) do set f=!f! -f "%%f"
::"C:\Program Files (x86)\GPSBabel\gpsbabel.exe" -i gpx %f% -o gpx -F "temp.gpx"
::"C:\Program Files (x86)\GPSBabel\gpsbabel.exe" -i gpx -f temp.gpx -x duplicate,location,shortname -o gpx -F Merge.gpx
::rm temp.gpx

::https://stackoverflow.com/questions/38554131/merge-all-gpx-files-within-a-folder-into-one-file-with-gpsbabel

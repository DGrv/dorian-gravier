@echo off

for %%f in (*.gpx) do (
	echo %input% --- GPSBabel --- %%f
	echo.
	
	"C:\Program Files (x86)\GPSBabel\gpsbabel.exe" -i gpx -f Merge.gpx -f "%%f" -x duplicate,location,shortname -o gpx -F Merge.gpx
)

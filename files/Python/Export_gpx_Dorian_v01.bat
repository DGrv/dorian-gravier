python C:\Users\doria\Downloads\Outdoor\Garmin_gpx_export\garmin-connect-export\gcexport.py -d "Export" -c 20 -f gpx -ot --username yourusername --password yourpassword

:: explorer C:\Users\doria\Downloads\Outdoor\Garmin_gpx_export

cd C:\Users\doria\Downloads\Outdoor\Garmin_gpx_export\Export

for %%i in (*gpx) do (
	C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\Batch\Gpx\BATCH_Rename_gpx.bat "%%i"
)

for %%i in (*gpx) do (
	call python "C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\Batch\Gpx\gpx_reduce_modified-Dorian.py" -d 600 -m 600 -t 50 -4 "%%i" -o "%%i"
)

cd C:\Users\doria\Downloads\Outdoor\Garmin_gpx_export


REM for %i in (*gpx) do (call python.exe "C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\Batch\Gpx\gpx_reduce_modified-Dorian.py" -d 600 -m 600 -t 50 -4 "%i" -o "%i")
setlocal enabledelayedexpansion
set f=
for %%f in (*.gpx) do set f=!f! -f "%%f"
"C:\Program Files (x86)\GPSBabel\gpsbabel.exe" -i gpx !f! -o gpx -F "merge.gpx"

::https://stackoverflow.com/questions/38554131/merge-all-gpx-files-within-a-folder-into-one-file-with-gpsbabel

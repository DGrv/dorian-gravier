SetLocal EnableDelayedExpansion

cd "C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\gpx\Bike_trip_2022"

set f=
for %%f in (*.gpx) do set f=!f! -f "%%f"
echo %f%
gpsbabel -i gpx %f% -x duplicate,location,shortname -o gpx -F "D:\Pictures\GoPro\BT_2022_all.gpx"
gpsbabel -i gpx -f "D:\Pictures\GoPro\BT_2022_all.gpx" -o kml,points=0 -F "D:\Pictures\GoPro\BT_2022_all.kml"
explorer D:\Pictures\GoPro\
SetLocal EnableDelayedExpansion

cd "C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\gpx\Bike_trip_2022"

set f=
for %%f in (*.gpx) do set f=!f! -f "%%f"
echo %f%
gpsbabel -i gpx %f% -x duplicate,location,shortname -o gpx -F "C:\Users\doria\Downloads\Pictures\GoPro\Google_Earth\Merge.gpx"
gpsbabel -i gpx -f "C:\Users\doria\Downloads\Pictures\GoPro\Google_Earth\Merge.gpx" -o kml,points=0 -F "C:\Users\doria\Downloads\Pictures\GoPro\Google_Earth\Merge.kml"
explorer C:\Users\doria\Downloads\Pictures\GoPro\Google_Earth
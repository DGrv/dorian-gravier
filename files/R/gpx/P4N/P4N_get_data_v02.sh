mkdir csv

start=(43.74798164794179 15.804051617371373)
end=(42.19130042179526 19.304756444143887)

h=$(echo "(${start[0]}-${end[0]})*3/1" | bc)
w=$(echo "(${start[1]}-${end[1]})*3/-1" | bc)

echo Start ${start[0]} ${start[1]}
echo End ${end[0]} ${end[1]}
echo h,w $h $w

# lat2=$(echo $lat1+$h*0.1 | bc)
# lon2=$(echo $lon1+$w*0.2 | bc)



# ----------------------------
# Create gpx 

echo '<?xml version="1.0" encoding="UTF-8"?><gpx creator="https://gpx.studio" version="1.1" xmlns="http://www.topografix.com/GPX/1/1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.topografix.com/GPX/1/1 http://www.topografix.com/GPX/1/1/gpx.xsd http://www.garmin.com/xmlschemas/GpxExtensions/v3 http://www.garmin.com/xmlschemas/GpxExtensionsv3.xsd http://www.garmin.com/xmlschemas/TrackPointExtension/v1 http://www.garmin.com/xmlschemas/TrackPointExtensionv1.xsd http://www.garmin.com/xmlschemas/PowerExtension/v1 http://www.garmin.com/xmlschemas/PowerExtensionv1.xsd http://www.topografix.com/GPX/gpx_style/0/2 http://www.topografix.com/GPX/gpx_style/0/2/gpx_style.xsd" xmlns:gpxtpx="http://www.garmin.com/xmlschemas/TrackPointExtension/v1" xmlns:gpxx="http://www.garmin.com/xmlschemas/GpxExtensions/v3" xmlns:gpxpx="http://www.garmin.com/xmlschemas/PowerExtension/v1" xmlns:gpx_style="http://www.topografix.com/GPX/gpx_style/0/2">'  > P4N_area.gpx
echo '<wpt lat="'${start[0]}'" lon="'${start[1]}'"><name>start</name></wpt>' >> P4N_area.gpx
echo '<wpt lat="'${end[0]}'" lon="'${end[1]}'"><name>end</name></wpt>' >> P4N_area.gpx
echo '<trk><name>Area</name><trkseg>'  >> P4N_area.gpx
echo '<trkpt lat="'${start[0]}'" lon="'${start[1]}'"> </trkpt>' >> P4N_area.gpx
echo '<trkpt lat="'${start[0]}'" lon="'${end[1]}'"> </trkpt>' >> P4N_area.gpx
echo '<trkpt lat="'${end[0]}'" lon="'${end[1]}'"> </trkpt>' >> P4N_area.gpx
echo '<trkpt lat="'${end[0]}'" lon="'${start[1]}'"> </trkpt>' >> P4N_area.gpx
echo '<trkpt lat="'${start[0]}'" lon="'${start[1]}'"> </trkpt>' >> P4N_area.gpx
echo '</trkseg></trk>' >> P4N_area.gpx
echo '</gpx>' >> P4N_area.gpx





# --------------------------------------------------------
# get data 

id=0
cd csv
for ((i=1;i<=$h;i++)) do
	for ((j=1;j<=$w;j++)) do
		id=$((id+1))
		# echo $lat1*$i*0.1
		lat=$(echo "scale=2;${start[0]}-($i/3)" | bc -l)
		lon=$(echo "scale=2;${start[1]}+($j/3)" | bc -l)
		echo -------------
		echo $lat $lon
		echo ----
		url=$(echo "https://park4night.com/api/places/around?lat="${lat}"&lng="${lon}"&radius=200")
		curl "${url}" | jq '.[]' | jq '[.id, .lat, .lng, .rating, .type.label, .url, .title_short, .description]' | jq -r @csv > P4N_$id.csv
	done
done




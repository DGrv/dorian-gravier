#!/bin/sh

# source me in your script or .bashrc/.zshrc if wanna use cecho
# source '/path/to/cecho.sh'


mergegpx() { # merge all gpx in folder
	ff=""
	for f in *.gpx;	do 
		ff="$ff -f $f"
	done
	gpsbabel -i gpx $ff -x duplicate,location,shortname -o gpx -F "Merge.gpx"
}


splitgpxtrack() { # split a gpx in multiples if track inside
	perl -i -pe "s/\&amp;//g" "$1"
    basename="${1%.*}"
    grep name "$1" | perl -pe "s|.*<name>(.*)</name>|\1|g" \
    | cat -n | while read n f; do
        f2=$(slugify "$f")
        fout=${basename}-${f2}.gpx
        gpsbabel -i gpx -f "$1" -x track,name="$f" -o gpx -F "$fout"
    done
}

kml2gpx() { # convert kml to gpx
    basename="${1%.*}"
    gpsbabel -i kml -f "$1" -x nuketypes,waypoints -o gpx -F "${basename}.gpx"
}


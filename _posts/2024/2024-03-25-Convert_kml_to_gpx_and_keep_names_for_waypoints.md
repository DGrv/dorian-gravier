--- 
title: "Convert_kml_to_gpx_and_keep_names_for_waypoints" 
date: "2024-03-25 14:56" 
comments_id: 80
---


# Gipfe!buch huts

- go on the website in overview map
- load all map
- search for the name of a hut and download the link of the file (kml) e.g. https://www.gipfelbuch.ch/kml/overview/range/5.46072676846822,45.27359050815676,10.42105391690572,47.553043836578496/active/1
- delete some balise

```sh
cp Gipfelbuch_huts.kml Gipfelbuch_huts_BU.kml

# remove peaks, pass and situation warnings
perl -i -pe "s|\<Placemark id\=.pea.*?\<\/Placemark\>||g" Gipfelbuch_huts.kml
perl -i -pe "s|\<Placemark id\=.pas.*?\<\/Placemark\>||g" Gipfelbuch_huts.kml
perl -i -pe "s|\<Placemark id\=.situ.*?\<\/Placemark\>||g" Gipfelbuch_huts.kml

# convert in gpx, but does not keep the names ...
gpsbabel -i kml -f Gipfelbuch_huts.kml -o gpx -F Gipfelbuch_huts.gpx

# add carriage return to work per line
perl -i -pe "s|<Placemark|\r\n<Placemark|g" Gipfelbuch_huts.kml

# get alone the name of the huts
perl -pe "s|.*(Hütte.*?)<.*|\1|p" Gipfelbuch_huts.kml | grep Hütte > kmlnames.txt

# remove soe shitty characters
perl -i -pe "s|\'| |g" kmlnames.txt

perl -i -pe "s|\„| |g" kmlnames.txt

# prepare a bash file to replace name in gpx by the real name
nrow=$(cat kmlnames.txt | wc -l)
j=1
echo "echo Script running" > Change_names.sh
for i in $( eval echo {001..$nrow} )
do 
in="WPT$i"
out=$(sed "${j}q;d" kmlnames.txt)
echo "perl -i -pe 's|${in}|${out}|g' Gipfelbuch_huts.gpx" >> Change_names.sh
((j++))
done

# run it
./Change_names.sh

# del what not needed
rm kmlnames.txt Change_names.sh

```




mkdir P4N_csv
cd P4N_csv

lat1=45.7
lon1=6
id=0



for ((i=1;i<=20;i++)) do
for ((j=1;j<=40;j++)) do
id=$((id+1))
# echo $lat1*$i*0.1
lat=$(echo $lat1+$i*0.1 | bc)
lon=$(echo $lon1+$j*0.2 | bc)
url=$(echo "https://park4night.com/api/places/around?lat="${lat}"&lng="${lon}"&radius=200")
curl "${url}" | jq '.[]' | jq '[.id, .lat, .lng, .rating, .type.label, .url, .title_short, .description]' | jq -r @csv > P4N_$id.csv
done
done




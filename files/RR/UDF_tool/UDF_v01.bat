rm temp.json temp.lvs 
yq "UDF_template_v01 - List_UDF.csv"  -p=csv -o=json |  perl -pe "s|null|\"\"|g" > temp.json
cat "User Defined Fields_Fcts..lvs" > "temp.lvs"
cat temp.json >> "temp.lvs"
perl -pe "s|\]\[|,|g" "temp.lvs" > udf.lvs

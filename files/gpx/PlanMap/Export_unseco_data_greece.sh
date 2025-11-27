curl -O https://data.unesco.org/api/explore/v2.1/catalog/datasets/whc001/exports/csv?lang=en&timezone=Europe%2FBerlin&use_labels=true&delimiter=%2C
cat whc001.csv | mlr --csv filter '${States Names}=="Greece"' then rename "Name EN","name","Coordinates","coord","Description EN","desc" then cut -o -f "name,coord,desc" then put '$group="Unesco"' --ofs tab | rmFl | clip.exe

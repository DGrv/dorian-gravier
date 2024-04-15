--- 
title: "Read_json_in_bash_and_extract_in_csv" 
date: "2024-04-11 16:14" 
comments_id: 84
--- 

Wanna read json in csv in order to have a readable output, for example in silver-searcher.
Found a solution [here](https://www.cyberciti.biz/faq/how-to-convert-json-to-csv-using-linux-unix-shell/)


In my case I used:

```sh
cat yourjson | jq -r '.[] | join("\t")'
# -r is for getting rid of the double quotes, and join to join the fields with the wanted separator.

```

I used it in combination with mdbtools extract.

```sh
grep -s UserFields settings.csv | perl -pe 's|.*?(\[.*\]).*|\1|g' | perl -pe 's|\\t||g' | ascii2uni -a U -q | jq -r '.[] | join("\t")' > UDF.csv
```


If you wanna bind everything in alias:

```sh
alias RRextract='tablewanted=( settings customFields ranks teamscores contests results );for file in *.ses; do pathfile=$(echo $file | perl -pe "s|.ses||g" | perl -pe "s| ||g" ); mkdir "$pathfile"; mdb-tables -1 "$file"; for value in "${tablewanted[@]}"; do mdb-export -Q -d \\t "$file" $value > "$pathfile/${value}.csv"; done;done;grep -s UserFields "$pathfile/settings.csv" | perl -pe "s|.*?(\[.*\]).*|\1|g" | perl -pe "s|\\t||g" | ascii2uni -a U -q | jq -r '"'"'.[] | join("\t\t")'"'"' > "$pathfile/UDF.csv";rm "$pathfile/settings.csv"'
```

Tricks with quotes and double quotes from [here](https://stackoverflow.com/a/28786747/2444948):

```sh 
$ echo 'abc'"'"'abc'
abc'abc
$ echo "abc"'"'"abc"
abc"abc
```



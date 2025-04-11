#!/bin/sh

# source me in your script or .bashrc/.zshrc if wanna use cecho
# source '/path/to/cecho.sh'


mdb-export-all () {
    mdb-tables "$1" | tr ' ' '\n' | while read line ; do
       mdb-export -Q -d "\\t" "$1" $line > "${line}.csv"
    done
}

spareRR () {
   # keep as info 
   for i in *.csv ; do 
   ll=$(grep -n "$1" "$i" | cut -d : -f 1)
   if [[  $ll ]]; then
   cecho -g "$i"
   ll2="1p;${ll}p"
   sed -n "${ll2}" "$i" | csvv | grep --color -E "$1|$"
   echo
   fi
   done
}


sesExtract () {
    if [ -f "$1" ]; then
	
		# set "backup_OCHSNER SPORT Zurich Marathon 2025_20250407-111407.ses"
		
        # tablewanted=( settings customFields rankings teamscores contests results timingpoints splits history data RawData )
        tablewanted=( agegroups exporters rawdatarules times bibranges history results timingpointrules contests overwriteValues settings timingpoints customFieldValues participants splits vouchers customFields rankings tableValues entryfees rawdata teamScores )
        fdir=$(echo rr_${1} | perl -pe "s|.ses||g" | perl -pe "s| |_|g" )
        mkdir -p $fdir
        # mdb-tables -1 "$1"
        sqlite3 "$1" ".tables"
        cecho -y "Export mdb:"
        for value in "${tablewanted[@]}"; do sqlite3 -header -separator $'\t' "$1" "SELECT * FROM $value " > "$fdir/${value}.csv"; done
        cecho -g Done
        cecho -y "Export von settings UDF:"
        grep -s UserFields "$fdir/settings.csv" | perl -pe "s|.*?(\[.*\]).*|\1|g" | perl -pe "s|\\t||g" | ascii2uni -a U -q | jq -r '.[] | join("\t\t")' > "$fdir/UDF.csv"
        cecho -g Done

        # Export list ---------------------------------------------
        cecho -y "Export list from settings:"
        let i=1
        echo > "$fdir/output_list.csv"
        echo > "$fdir/output_list_selectors.csv"
        echo "List;Expression;Color;BG" > "$fdir/output_list_colors.csv"
        # get only what I need
        # extract with perl the json
        # remove \" that is making problems for jq
        # transform unicode (\u0026 ...) with ascii2uni -a U -q
        # then work per line
        grep -s "ListName" "$fdir/settings.csv" | perl -pe "s|.*({\"ListName.*})\t.*|\1|g" | perl -pe "s|\\\\\"|'|g"  | ascii2uni -a U -q | while read line ; do 
            echo "$line" | jq -r '.ListName' | perl -pe "s/\|/  ;\"----\";  /g"  >> "$fdir/output_list.csv"
            echo "ORDER;Label;Descending;Grouping;GroupingFilterDefault;__________" >> "$fdir/output_list.csv"
            # ; is the separator of the csv, then add \" so a quote for each cell, this \(.Expression) is extract the value with jq
            # source : https://stackoverflow.com/questions/28164849/using-jq-to-parse-and-display-multiple-fields-in-a-json-serially
            # echo "$line" | jq -r '.Orders[] | ";\"\(.Expression)\";\"\(.Descending)\";\"\(.Grouping)\";\"\(.GroupFilterDefault)\""' >> "$fdir/output_list.csv"
            echo "$line" | jq -r '.Orders[] | ";\"\(.Expression)\";\"\(.Descending)\";\"\(.Grouping)\";\"\(.GroupFilterDefault)\"\"\(.Color)\"\"\(.BackgroundColor)\""' >> "$fdir/output_list.csv"
            echo ";" >> "$fdir/output_list.csv"
            echo "$line" | jq -r '"\"LineDynamicFormat\";\"\(.LineDynamicFormat)\""' >> "$fdir/output_list.csv"
            echo ";" >> "$fdir/output_list.csv"
            echo "FIELDS;Label;Expression;LineDynamicFormat" >> "$fdir/output_list.csv"
            echo "$line" | jq -r '.Fields[] | ";\"\(.Label)\";\"\(.Expression)\";\"\(.LineDynamicFormat)\""' >> "$fdir/output_list.csv"
            echo ";" >> "$fdir/output_list.csv"
            echo "FILTERS;OR" >> "$fdir/output_list.csv"
            echo "$line" | jq -r '.Filters[] | ";\"\(.OrConjunction)\";\"\(.Expression1)   \(.Operator)\";\"\(.Expression2)\""' >> "$fdir/output_list.csv"
            echo ";"  >> "$fdir/output_list.csv"
            echo "SELECTORS" >> "$fdir/output_list.csv"
            # jq play : .SelectorResults[] | "\(.ResultID) \(.ShowAs)"
            echo "$line" | jq -r '.SelectorResults[] | ";\"\(.ResultID)\";\"\(.ShowAs)\";"' | tr -d \{  | tr -d \} | perl -pe "s/\|/\";\"/g" | ascii2uni -a U -q >> "$fdir/output_list.csv"
            echo ";" >> "$fdir/output_list.csv"
            echo "-------------" >> "$fdir/output_list.csv"
            echo "-------------" >> "$fdir/output_list.csv"
            echo ";"  >> "$fdir/output_list.csv"
            echo ";"  >> "$fdir/output_list.csv"
            
            echo "$line" | jq -r '.ListName' | perl -pe "s/\|/  ----  /g"  >> "$fdir/output_list_selectors.csv"
            echo "$line" | jq -r '.SelectorResults[] | ";\"\(.ResultID)\";\"\(.ShowAs)\""' | tr -d \{  | tr -d \} | perl -pe "s/\|/\";\"/g" | ascii2uni -a U -q >> "$fdir/output_list_selectors.csv"

            # colors
            # source : https://stackoverflow.com/a/75932555/2444948
            # source : https://stackoverflow.com/questions/67596741/how-to-combine-two-json-variables-using-jq
            echo "$line" | jq -r '.ListName as $test |.Orders[] | [.Expression, .Color, .BackgroundColor] | join("\";\"") as $t2 | "\"" + $test + "\";\"" + $t2 + "\""'  >> "$fdir/output_list_colors.csv"
            
            cecho -g "Line $i done"
            let i++
        done
        cecho -g Done
        
        cecho -y "R Kable for list"
        /mnt/c/Windows/System32/cmd.exe /C "C:\Users\doria\scoop\shims\rscript.exe" "C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\RR\Kable_v01.R" "$PWD/$fdir"
        cecho -g Done

        
        # Export gpx ------------------------------------
        cecho -y "Export gpx:"
        mkdir -p $fdir/gpx
        rm $fdir/gpx/*
        # extract gpx daten
        cat "$fdir/settings.csv" | perl -pe "s;\n|\r|\r\n;;g" | perl -pe "s|\<\?xml|\n<\?xml|g" | perl -pe "s|\<\/gpx>|</gpx>\n|g" | grep "<gpx" > "$fdir/gpx/gpx"
        # extract name gpx
        grep -s "GPXFileName" "$fdir/settings.csv" | perl -pe "s/.*GPXFileName\t.*?\t(.*?)\t(.*?).gpx.*/\1__\2.gpx/g" > "$fdir/gpx/namegpx"
        # export gpx
        while read -r -u 3 lineA && read -r -u 4 lineB; do echo $lineB >> "$fdir/gpx/${lineA}" ; done 3<"$fdir/gpx/namegpx" 4<"$fdir/gpx/gpx"
        rm $fdir/gpx/namegpx $fdir/gpx/gpx
        ls -1 $fdir/gpx/*gpx | cat -n | while read n i; do gpsbabel -i gpx -f "$i" -x simplify,crosstrack,error=0.01k -o gpx -F "$i"; done
        cecho -g Done
        
        # Export Contest infos --------------------------
        # does not work
        # does not work
        # does not work
        # does not work
        # cecho -y "Export contest info:"
        # paste -d , <(csvcut -c ID,ContestName,ContestNameShort,ContestLength "$fdir/contests.csv") <(echo ContestStart && (csvcut -c ContestStart "$fdir/contests.csv" | tail -n +2 | perl -pe "s|(.*)\..*|\1|g" | xargs -I \\ date -d@\\ -u +%H:%M:%S)) | csvlook > "$fdir/Info_Contest.txt"
        # cecho -g Done

        cecho -y "R Split_map:"
        #/mnt/c/Windows/System32/cmd.exe /C "C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\RR\Split_map_v02.R" "$PWD"
        /mnt/c/Windows/System32/cmd.exe /C "C:\Users\doria\scoop\shims\rscript.exe" "C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\RR\Leaflet_v03.R" "$PWD/$fdir"
        cecho -g Done
    else
        echo File not found
    fi
}

sesExtractold () {
    if [ -f "$1" ]; then
	
		# set "backup_OCHSNER SPORT Zurich Marathon 2025_20250407-111407.ses"
		
        tablewanted=( settings customFields ranks teamscores contests results timingpoints splits history data RawData )
        fdir=$(echo rr_${1} | perl -pe "s|.ses||g" | perl -pe "s| |_|g" )
        mkdir -p $fdir
        mdb-tables -1 "$1"
        cecho -y "Export mdb:"
        for value in "${tablewanted[@]}"; do mdb-export -Q -d "\\t" "$1" $value > "$fdir/${value}.csv"; done
        cecho -g Done
        cecho -y "Export von settings UDF:"
        grep -s UserFields "$fdir/settings.csv" | perl -pe "s|.*?(\[.*\]).*|\1|g" | perl -pe "s|\\t||g" | ascii2uni -a U -q | jq -r '.[] | join("\t\t")' > "$fdir/UDF.csv"
        cecho -g Done

        # Export list
        cecho -y "Export list from settings:"
        let i=1
        echo > "$fdir/output_list.csv"
        echo > "$fdir/output_list_selectors.csv"
        echo "List;Expression;Color;BG" > "$fdir/output_list_colors.csv"
        # get only what I need
        # extract with perl the json
        # remove \" that is making problems for jq
        # transform unicode (\u0026 ...) with ascii2uni -a U -q
        # then work per line
        grep -s "ListName" "$fdir/settings.csv" | perl -pe "s|.*({\"ListName.*})\t.*|\1|g" | perl -pe "s|\\\\\"|'|g"  | ascii2uni -a U -q | while read line ; do 
            echo "$line" | jq -r '.ListName' | perl -pe "s/\|/  ;\"----\";  /g"  >> "$fdir/output_list.csv"
            echo "ORDER;Label;Descending;Grouping;GroupingFilterDefault;__________" >> "$fdir/output_list.csv"
            # ; is the separator of the csv, then add \" so a quote for each cell, this \(.Expression) is extract the value with jq
            # source : https://stackoverflow.com/questions/28164849/using-jq-to-parse-and-display-multiple-fields-in-a-json-serially
            # echo "$line" | jq -r '.Orders[] | ";\"\(.Expression)\";\"\(.Descending)\";\"\(.Grouping)\";\"\(.GroupFilterDefault)\""' >> "$fdir/output_list.csv"
            echo "$line" | jq -r '.Orders[] | ";\"\(.Expression)\";\"\(.Descending)\";\"\(.Grouping)\";\"\(.GroupFilterDefault)\"\"\(.Color)\"\"\(.BackgroundColor)\""' >> "$fdir/output_list.csv"
            echo ";" >> "$fdir/output_list.csv"
            echo "$line" | jq -r '"\"LineDynamicFormat\";\"\(.LineDynamicFormat)\""' >> "$fdir/output_list.csv"
            echo ";" >> "$fdir/output_list.csv"
            echo "FIELDS;Label;Expression;LineDynamicFormat" >> "$fdir/output_list.csv"
            echo "$line" | jq -r '.Fields[] | ";\"\(.Label)\";\"\(.Expression)\";\"\(.LineDynamicFormat)\""' >> "$fdir/output_list.csv"
            echo ";" >> "$fdir/output_list.csv"
            echo "FILTERS;OR" >> "$fdir/output_list.csv"
            echo "$line" | jq -r '.Filters[] | ";\"\(.OrConjunction)\";\"\(.Expression1)   \(.Operator)\";\"\(.Expression2)\""' >> "$fdir/output_list.csv"
            echo ";"  >> "$fdir/output_list.csv"
            echo "SELECTORS" >> "$fdir/output_list.csv"
            # jq play : .SelectorResults[] | "\(.ResultID) \(.ShowAs)"
            echo "$line" | jq -r '.SelectorResults[] | ";\"\(.ResultID)\";\"\(.ShowAs)\";"' | tr -d \{  | tr -d \} | perl -pe "s/\|/\";\"/g" | ascii2uni -a U -q >> "$fdir/output_list.csv"
            echo ";" >> "$fdir/output_list.csv"
            echo "-------------" >> "$fdir/output_list.csv"
            echo "-------------" >> "$fdir/output_list.csv"
            echo ";"  >> "$fdir/output_list.csv"
            echo ";"  >> "$fdir/output_list.csv"
            
            echo "$line" | jq -r '.ListName' | perl -pe "s/\|/  ----  /g"  >> "$fdir/output_list_selectors.csv"
            echo "$line" | jq -r '.SelectorResults[] | ";\"\(.ResultID)\";\"\(.ShowAs)\""' | tr -d \{  | tr -d \} | perl -pe "s/\|/\";\"/g" | ascii2uni -a U -q >> "$fdir/output_list_selectors.csv"

            # colors
            # source : https://stackoverflow.com/a/75932555/2444948
            # source : https://stackoverflow.com/questions/67596741/how-to-combine-two-json-variables-using-jq
            echo "$line" | jq -r '.ListName as $test |.Orders[] | [.Expression, .Color, .BackgroundColor] | join("\";\"") as $t2 | "\"" + $test + "\";\"" + $t2 + "\""'  >> "$fdir/output_list_colors.csv"
            
            cecho -g "Line $i done"
            let i++
        done
        cecho -g Done
        
        cecho -y "R Kable for list"
        /mnt/c/Windows/System32/cmd.exe /C "C:\Users\doria\scoop\shims\rscript.exe" "C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\RR\Kable_v01.R" "$PWD/$fdir"
        cecho -g Done

        
        # Export gpx ------------------------------------
        cecho -y "Export gpx:"
        mkdir -p $fdir/gpx
        rm $fdir/gpx/*
        # extract gpx daten
        cat "$fdir/settings.csv" | perl -pe "s;\n|\r|\r\n;;g" | perl -pe "s|\<\?xml|\n<\?xml|g" | perl -pe "s|\<\/gpx>|</gpx>\n|g" | grep "<gpx" > "$fdir/gpx/gpx"
        # extract name gpx
        grep -s "GPXFileName" "$fdir/settings.csv" | perl -pe "s|.*GPXFileName\t.*?\t(.*?)\t.*?\t(.*?).gpx.*|\1__\2.gpx|g" > "$fdir/gpx/namegpx"
        # export gpx
        while read -r -u 3 lineA && read -r -u 4 lineB; do echo $lineB >> "$fdir/gpx/${lineA}" ; done 3<"$fdir/gpx/namegpx" 4<"$fdir/gpx/gpx"
        rm $fdir/gpx/namegpx $fdir/gpx/gpx
        ls -1 $fdir/gpx/*gpx | cat -n | while read n i; do gpsbabel -i gpx -f "$i" -x simplify,crosstrack,error=0.01k -o gpx -F "$i"; done
        cecho -g Done
        
        # Export Contest infos --------------------------
        cecho -y "Export contest info:"
        mdb-export "$1" contests > "$fdir/temp.csv"
        paste -d , <(csvcut -c ID,ContestName,ContestNameShort,ContestLength "$fdir/temp.csv") <(echo ContestStart && (csvcut -c ContestStart "$fdir/temp.csv" | tail -n +2 | perl -pe "s|(.*)\..*|\1|g" | xargs -I \\ date -d@\\ -u +%H:%M:%S)) | csvlook > "$fdir/Info_Contest.txt"
        rm "$fdir/temp.csv"
        cecho -g Done

        cecho -y "R Split_map:"
        #/mnt/c/Windows/System32/cmd.exe /C "C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\RR\Split_map_v02.R" "$PWD"
        /mnt/c/Windows/System32/cmd.exe /C "C:\Users\doria\scoop\shims\rscript.exe" "C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\RR\Leaflet_v03.R" "$PWD/$fdir"
        cecho -g Done
    else
        echo File not found
    fi
}



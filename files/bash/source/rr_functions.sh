#!/bin/sh

# source me in your script or .bashrc/.zshrc if wanna use cecho
# source '/path/to/cecho.sh'

uColor() { # change all color from a logo to one unique color (e.g. for templates 9370DB or test events FF1493): usage: uColor "filename" "hex code your color" 
	checkdep convert
	convert "$1" -channel RGB -auto-level +level-colors "$2" "${1%.*}_uColor1.png"
	convert "$1" -colorspace gray -contrast-stretch 0 +level-colors "none,$2" -transparent black "${1%.*}_uColor2.png"
	convert "$1" -negate -colorspace gray -contrast-stretch 0 +level-colors "none,$2" -transparent black "${1%.*}_uColor3.png"
	# convert "map.jpg" -colorspace gray -contrast-stretch 0 +level-colors "none,#ff0000" -transparent black "map_uColor3.png"
}



rmbg() { # Remove the white/first piel background based on different fuzz
    color=$(convert "$1"  -format "%[pixel:p{0,0}]" info:)
    for i in $(seq 10 10 90); do 
        convert "$1" -fill none -fuzz $i% -draw "color 0,0 floodfill" "${1%.*}_rmwbg${i}_floodfill.png"
        convert "$1" -channel RGBA -fuzz $i% -fill none -opaque white "${1%.*}_rmwbg$i.png"
        # convert "$1" -channel RGBA -fuzz $i% -fill none -opaque white -alpha on -blur 0x0.5 "${1%.*}_rmwbg${i}_smooth.png"
        # Get color at position 0,0 (top-left)
        convert "$1" -alpha set -fuzz $i% -transparent "$color" "${1%.*}_rmwbg${i}_colorpixel.png"
    done

}

gpx2svg() { # convert a gpx to svg for profile, gpx2svg *.gpx  or gpx2svg input.gpx
	
	# to use like this : gpx2svg *.gpx 
	# gpx2svg input.gpx

    for file in "$@"; do
        # Only process .gpx files
        if [[ "$file" == *.gpx ]]; then
            filename="${file%.*}"
            python3 /mnt/c/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/Python/gpx2svg.py -i "$file" -o "${filename}.svg"
            python3 /mnt/c/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/Python/gpx2elevation.py "$file" "${filename}_elev-100.svg" 100
            python3 /mnt/c/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/Python/gpx2elevation.py "$file" "${filename}_elev-50.svg" 50
            python3 /mnt/c/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/Python/gpx2elevation.py "$file" "${filename}_elev-10.svg" 10
            python3 /mnt/c/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/Python/gpx2elevation.py "$file" "${filename}_elev-1.svg" 1
        fi
    done
}



vertiAppendPdf() { # convert png and append them together vertically and create a pdf for commenting
	convert *.png -append output.png
	img2pdf output.png -o output.pdf
}

svg2png() { # convert svg to png in directory with $1 a color to replace it and $2 resize size (e.g. 50x50) or none
  # Replace In All Files
  cecho -g "rrsvg=Replace in all svg : \n\t- $1 with hex color -> USE DOUBLE QUOTES: rrsvg \"#fa9b2c\"\n\t- $2 with resize (50x50) or none"
  local color="$1"
  local resize="$2"
  # old \Q is opening quote and \E ending quote
  # grep -rl -- "${in}" . | xargs -d '\n' -I {} perl -pi -e "s|\Q${in}\E|${out}|g" "{}"
	# Replace color in all SVG files
  find . -name "*.svg" -print0 | xargs -0 -I {} perl -pi -e "s|Color1|${color}|g" "{}"
  
  # Convert SVG to PNG with conditional resize
  for file in *.svg; do
    if [ -z "$resize" ]; then
      # No resize specified
      convert -background none -density 300 "$file" "${file%.svg}.png"
    else
      # Resize specified
      convert -background none -density 300 "$file" -resize "$resize" "${file%.svg}.png"
    fi
  done
}

spareRR () { # (not used anymore)
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

splitRawData() { # Split a file with rawdata to split files, using Rscript (not used anymore) used Split_RawData_v01, but now Split_RawData_v02
	if [ -f "$1" ]; then
		/mnt/c/Windows/System32/cmd.exe /C "C:\Users\doria\scoop\shims\rscript.exe" "C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\RR\Split_RawData_v01.R" "${PWD}" "${1}" "${2}"
	fi
}



sesExtract () { # Extract ses data
    if [ -f "$1" ]; then
	
		# set "backup_Zurich City Triathlon 2026_20251227-152734.ses"
		
        # tablewanted=( settings customFields rankings teamscores contests results timingpoints splits history data RawData )
        # tablewanted=( agegroups exporters rawdatarules times bibranges history results timingpointrules contests overwriteValues settings timingpoints customFieldValues participants splits vouchers customFields rankings tableValues entryfees rawdata teamScores )
        tablewanted=( agegroups exporters rankings tableValues bibranges history rawdata teamScores contests invoiceSourceItems rawdatarules times customFieldValues invoices results timingpointrules customFields overwriteValues settings timingpoints entryfees participants splits vouchers )
        fdir=$(echo rr_${1} | perl -pe "s|.ses||g" | perl -pe "s| |_|g" )
        mkdir -p $fdir
        sqlite3 "$1" ".tables"
        cecho -y "Export mdb:"
        for value in "${tablewanted[@]}"; do sqlite3 -header -csv -separator $'\t' "$1" "SELECT * FROM $value " > "$fdir/${value}.csv"; done
		# use quote in participant to avoid error in comments field
		# sqlite3 -header -csv -separator $"," "$1" "SELECT * FROM participants" > "$fdir/participants_quote.csv"
        cecho -g "csv Done"
		
		# Export in other format for RRdeps
        mkdir -p $fdir/RRdeps
		sqlite3 -json "$1" "SELECT * FROM results" | jq -r '.[] | [.ID, .Name, .TimeFormat, .TimeRounding, .Location, .Formula ] | @csv' | sed 's/,/;/g; s/"//g' > "$fdir/RRdeps/Special Results.lvs"
		grep -s UserFields "$fdir/settings.csv" | perl -pe "s|.*?(\[.*\]).*|\1|g" | perl -pe 's|\"\"|"|g' > "$fdir/RRdeps/User Defined Fields_Fcts..lvs"
		sqlite3 -json "$1" "SELECT * FROM contests" > "$fdir/RRdeps/Contests.lvs"
		sqlite3 -json "$1" "SELECT * FROM rankings" > "$fdir/RRdeps/Rankings.lvs"
		sqlite3 -json "$1" "SELECT * FROM customFields" > "$fdir/RRdeps/Additional Fields.lvs"
		
		
		# Enhance participants.csv
		/mnt/c/Windows/System32/cmd.exe /C "C:\Users\doria\scoop\shims\rscript.exe" "C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\RR\Enhance_Participantscsv_from_BU_v01.R" "$PWD/$fdir"
        cecho -g "participants_full.csv Done"
		
		
        cecho -y "Export von settings UDF:"
        # grep -s UserFields "$fdir/settings.csv" | perl -pe "s|.*?(\[.*\]).*|\1|g" | perl -pe "s|\\t||g" | ascii2uni -a U -q | jq -r '.[] | join("\t\t")' > "$fdir/UDF.csv" # old 20251227
        grep -s UserFields "$fdir/settings.csv" | perl -pe "s|.*?(\[.*\]).*|\1|g" | perl -pe "s|\\t||g" | perl -pe 's|\"\"|"|g' | ascii2uni -a U -q | jq -r '.[] | join("\t\t")' > "$fdir/UDF.csv"
        cecho -g "UDF Done"

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
        # grep -s "ListName" "$fdir/settings.csv" | perl -pe "s|.*({\"ListName.*})\t.*|\1|g" | perl -pe "s|\\\\\"|'|g"  | ascii2uni -a U -q | while read line ; do # old 20251227
        grep -s "ListName" "$fdir/settings.csv" | perl -pe 's|\"\"|"|g' | perl -pe "s/.*(\{\"ListName.*\})\"\t.*/\1/g" | perl -pe "s|\\\\\"|'|g" | ascii2uni -a U -q | while read line ; do 
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
		grep -s "GPXFile" "$fdir/settings.csv" > "$fdir/gpx/gpxallinfo"
		/mnt/c/Windows/System32/cmd.exe /C "C:\Users\doria\scoop\shims\rscript.exe" "C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\RR\Extract_gpx_ses_v01.R" "$PWD/$fdir"

		#old
        # grep -P "GPXFile\t" "$fdir/settings.csv" | perl -pe "s;\n|\r|\r\n;;g" | perl -pe "s|\<\?xml|\n<\?xml|g" | perl -pe "s|\<\/gpx>|</gpx>\n|g" | grep "<gpx" > "$fdir/gpx/gpx"
        # # extract name gpx
        # grep -s "GPXFileName" "$fdir/settings.csv" | perl -pe "s/.*GPXFileName\t.*?\t(.*?)\t(.*?).gpx.*/\1__\2.gpx/g" > "$fdir/gpx/namegpx"
        # # export gpx
        # while read -r -u 3 lineA && read -r -u 4 lineB; do echo $lineB >> "$fdir/gpx/${lineA}" ; done 3<"$fdir/gpx/namegpx" 4<"$fdir/gpx/gpx"
        # rm $fdir/gpx/namegpx $fdir/gpx/gpx
        rm $fdir/gpx/gpxallinfo
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
        /mnt/c/Windows/System32/cmd.exe /C "C:\Users\doria\scoop\shims\rscript.exe" "C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\RR\Leaflet_v05.R" "$PWD/$fdir"
		
		
        cecho -g Done
    else
        echo File not found
    fi
}





RRgroupingColors() { # Function to update BackgroundColor and Color in JSON files (supports glob patterns *.lvs) Example: RRgroupingColors data.json "#ff0000,#00ff00" "#0000ff,#ffff00" "#ff00ff,#00ffff"

    # Function to update Color and BackgroundColor in JSON files (supports glob patterns)
    # Usage: update_colors "<pattern_or_file>" "<color1>,<color2>" ["<color3>,<color4>"] ["<color5>,<color6>"]
    # Example: update_colors "*.lv" "#ff0000,#00ff00" "#0000ff,#ffff00"
    # Example: update_colors "data.json" "#ff0000,#00ff00"

    # Check if correct number of arguments provided (2-4 total)
    if [ $# -lt 2 ] || [ $# -gt 4 ]; then
        echo "Usage: update_colors \"<pattern_or_file>\" \"<color1>,<color2>\" [\"<color3>,<color4>\"] [\"<color5>,<color6>\"]"
        echo "Example: update_colors \"*.lv\" \"#ff0000,#00ff00\" \"#0000ff,#ffff00\""
        echo "Example: update_colors \"data.json\" \"#ff0000,#00ff00\""
        echo "Note: You can provide 2-4 parameters total (pattern + 1-3 color pairs)"
        return 1
    fi

    local PATTERN="$1"
    
    # Expand the glob pattern to get actual files
    local FILES=()
    if [[ "$PATTERN" == *"*"* ]] || [[ "$PATTERN" == *"?"* ]] || [[ "$PATTERN" == *"["* ]]; then
        # It's a glob pattern
        shopt -s nullglob  # Enable nullglob so empty matches return empty array
        FILES=($PATTERN)
        shopt -u nullglob  # Disable nullglob after use
        
        if [ ${#FILES[@]} -eq 0 ]; then
            echo "Error: No files match pattern '$PATTERN'"
            return 1
        fi
        
        echo "Found ${#FILES[@]} files matching pattern '$PATTERN':"
        printf "  %s\n" "${FILES[@]}"
        echo
    else
        # It's a single file
        FILES=("$PATTERN")
    fi

    # Function to validate and parse color pair
    validate_color_pair() {
        local colors="$1"
        local pair_num="$2"
        
        # Split colors using regex (supports both comma and semicolon)
        local color1=$(echo "$colors" | sed -E 's/^[^,;]+[,;](.+)$/\1/')
        local color2=$(echo "$colors" | sed -E 's/^([^,;]+)[,;].*$/\1/')
        
        # Validate that we have two colors
        if [ -z "$color1" ] || [ -z "$color2" ] || [ "$color1" = "$color2" ]; then
            echo "Error: Color pair $pair_num - Please provide two different colors separated by comma or semicolon."
            echo "Example: \"#ff0000,#00ff00\" or \"#ff0000;#00ff00\""
            return 1
        fi
        
        # Validate hex color format
        if ! [[ "$color1" =~ ^#[0-9a-fA-F]{6}$ ]] || ! [[ "$color2" =~ ^#[0-9a-fA-F]{6}$ ]]; then
            echo "Error: Color pair $pair_num - Colors must be in hex format (#rrggbb)."
            echo "Example: #ff0000, #00ff00"
            return 1
        fi
        
        echo "$color1,$color2"
        return 0
    }

    # Parse and validate all color pairs (only once for all files)
    local COLOR_PAIRS=()
    for i in $(seq 2 $#); do
        local pair_index=$((i-1))
        local colors="${!i}"
        
        echo "Processing color pair $pair_index: $colors"
        
        local parsed_colors=$(validate_color_pair "$colors" "$pair_index")
        if [ $? -ne 0 ]; then
            return 1
        fi
        
        COLOR_PAIRS+=("$parsed_colors")
    done

    echo "Number of color pairs: ${#COLOR_PAIRS[@]}"
    echo

    # Build jq arguments for all color pairs (only once)
    local COLOR_JSON="["
    for i in "${!COLOR_PAIRS[@]}"; do
        local color1=$(echo "${COLOR_PAIRS[$i]}" | cut -d',' -f1)
        local color2=$(echo "${COLOR_PAIRS[$i]}" | cut -d',' -f2)
        if [ $i -gt 0 ]; then
            COLOR_JSON+=","
        fi
        COLOR_JSON+="{\"color\":\"$color1\",\"backgroundColor\":\"$color2\"}"
    done
    COLOR_JSON+="]"

    # Process each file
    local SUCCESS_COUNT=0
    local FAIL_COUNT=0
    
    for FILE in "${FILES[@]}"; do
        echo "Processing file: $FILE"
		
        
        # Check if file exists
        if [ ! -f "$FILE" ]; then
            echo "  Error: File '$FILE' does not exist."
            ((FAIL_COUNT++))
            continue
        fi

		# convert ANSI to UTF-8
		iconv -f WINDOWS-1252 -t UTF-8 "$FILE" > "temp" && mv "temp" "$FILE"
		
        # Validate JSON format
        if ! jq empty "$FILE" 2>/dev/null; then
            echo "  Error: File '$FILE' is not valid JSON."
            ((FAIL_COUNT++))
            continue
        fi

        # Find orders with Grouping != 0 and update colors
        local TEMP_FILE=$(mktemp)

        jq --argjson "colorPairs" "$COLOR_JSON" '
          # Find all indices where Grouping != 0
          [.Orders | to_entries[] | select(.value.Grouping != 0) | .key] as $indices |
          
          # Update colors for each available index and color pair
          reduce range(0; [($colorPairs | length), ($indices | length)] | min) as $i (.;
            $indices[$i] as $order_index |
            .Orders[$order_index].Color = $colorPairs[$i].color |
            .Orders[$order_index].BackgroundColor = $colorPairs[$i].backgroundColor
          )
        ' "$FILE" > "$TEMP_FILE"

        # Check if jq command was successful
        if [ $? -eq 0 ]; then
            # Replace original file with updated content
            mv "$TEMP_FILE" "$FILE"
            echo "  ✓ Successfully updated colors in $FILE"
            ((SUCCESS_COUNT++))
            
            # Show the updated orders (only for single file or verbose mode)
            if [ ${#FILES[@]} -eq 1 ]; then
                echo "  Updated order details:"
                jq '
                .Orders | to_entries | 
                map(select(.value.Grouping != 0)) | 
                to_entries | 
                map({
                  "order_index": .value.key,
                  "pair_index": (.key + 1),
                  "grouping": .value.value.Grouping,
                  "color": .value.value.Color,
                  "backgroundColor": .value.value.BackgroundColor
                })
                ' "$FILE"
            fi
        else
            echo "  ✗ Error: Failed to update file '$FILE'."
            rm -f "$TEMP_FILE"
            ((FAIL_COUNT++))
        fi
        echo
    done
    
    # Summary
    echo "=== Summary ==="
    echo "Successfully processed: $SUCCESS_COUNT files"
    echo "Failed: $FAIL_COUNT files"
    echo "Total: ${#FILES[@]} files"
    
    if [ $FAIL_COUNT -eq 0 ]; then
        return 0
    else
        return 1
    fi
}
@echo off

:: Convest json in cv
@REM qsv json "User Defined Fields_Fcts..lvs" | qsv fmt --quote-always > temp.csv
@REM mlr --ijson --ocsv --quote-all cat "User Defined Fields_Fcts..lvs"  > temp.csv
@REM cat "User Defined Fields_Fcts..lvs"  | mlr --ijson --ocsv filter '$Expression !=~ "---------------"' then put '$Group="Old"'   > temp.csv
cat "User Defined Fields_Fcts..lvs"  | mlr --ijson --ocsv filter '$Expression !=~ "---------------"'   > temp.csv
cat temp.csv | qsv fmt --quote-always > UDF_ori.csv

::join but remove the one in the google sheet
@REM mlr --csv --quote-all cat "UDF_template_v01 - List_UDF.csv" > temp.csv
:: remove some comment group
cat "UDF_template_v01 - List_UDF.csv"  | mlr --csv filter '$Expression !=~ "---------------"'  > temp.csv
cat temp.csv | qsv fmt --quote-always > UDF_gdrive.csv

::join
qsv join --left-anti Name UDF_ori.csv Name UDF_gdrive.csv > UDF_ori_filtered.csv

:: prepare data for comparison
qsv join --left Name UDF_ori.csv Name "UDF_template_v01 - List_UDF.csv" | qsv search -s Name[1] -v "^$" | qsv select "Name[0]-Expression[0]" > UDF_compare_event.csv
qsv join --left Name UDF_ori.csv Name "UDF_template_v01 - List_UDF.csv" | qsv search -s Name[1] -v "^$" | qsv select "Name[1]-Expression[1]" > UDF_compare_gdrive_temp.csv


REM working for info
REM qsv replace -s Expression -i "\[contest" "[CONTEST" "UDF_compare_gdrive_temp.csv" | grep --color CONTEST
REM qsv apply operations regex_replace Expression --comparand "(?i)\[contest" --replacement "[CONTEST" "UDF_compare_gdrive_temp.csv"  | grep --color CONTEST


qsv replace -s Expression -i "\[contest\." "[CONTEST." "UDF_compare_gdrive_temp.csv" | ^
qsv replace -s Expression -i "\[contest\]" "[CONTEST]" | ^
qsv replace -s Expression -i "\[firstname" "[FIRSTNAME" | ^
qsv replace -s Expression -i "\[lastname" "[LASTNAME" | ^
qsv replace -s Expression -i "\[created" "[CREATED" | ^
qsv replace -s Expression -i "\[gender\]" "[SEX]" | ^
qsv replace -s Expression -i "decimal" "DECIMAL" | ^
qsv replace -s Expression -i "\[nation" "[NATION" | ^
qsv replace -s Expression -i "\[country" "[COUNTRY" | ^
qsv replace -s Expression -i "alpha" "ALPHA" | ^
qsv replace -s Expression -i "\[city" "[CITY" | ^
qsv replace -s Expression -i "\[status" "[STATUS" | ^
qsv replace -s Expression -i "\[started" "[STARTED" | ^
qsv replace -s Expression -i "\[agegroup" "[AGEGROUP" | ^
qsv replace -s Expression -i "\[finished" "[FINISHED" | ^
qsv replace -s Expression -i "\[language" "[LANGUAGE" | ^
qsv replace -s Expression -i "\[bib" "[BIB" | ^
qsv replace -s Expression -i "\[openentryfee" "[OPENENTRYFEE"  | ^
qsv replace -s Expression -i "\[opmethod" "[opmethod"  | ^
qsv replace -s Expression -i "\.gender\]" ".GENDER]"  | ^
qsv replace -s Expression -i "\.overall\]" ".OVERALL]"  | ^
qsv replace -s Expression -i "\.agegroup\]" ".AGEGROUP]"  | ^
qsv replace -s Expression -i "\.label\]" ".LABEL]"  | ^
qsv replace -s Expression -i "\.name\]" ".NAME]"  | ^
qsv replace -s Expression -i "\.positive\]" ".TIMESET]"  | ^
qsv replace -s Expression -i "\[event" "[EVENT"  | ^
qsv replace -s Expression -i "ioc\]" "IOCNAME]"  | ^
qsv replace -s Expression -i "\[paidentryfee" "[PAIDENTRYFEE" > UDF_compare_gdrive.csv

:: ---------- COMPARISON
qsv diff UDF_compare_event.csv UDF_compare_gdrive.csv > UDF_compare_w_qsvdiff.csv
:: install on windows : pip install ansi2html icdiff
:: icdiff should be on your bash
REM bash -c "icdiff --cols=200 \"UDF_compare_event.csv\" \"UDF_compare_gdrive.csv\" -W | tee diff.ansi.txt"
REM type diff.ansi.txt | ansi2html > UDF_diff.html
icdiff --cols=200 "UDF_compare_event.csv" "UDF_compare_gdrive.csv" -W | tee | ansi2html > UDF_compare_icdiff.html

:: csv to json and remove the null with empty string
yq --csv-auto-parse=false UDF_ori_filtered.csv -p=csv -o=json |  perl -pe "s|null|\"\"|g" > UDF_ori_filtered.json
yq --csv-auto-parse=false UDF_gdrive.csv -p=csv -o=json |  perl -pe "s|null|\"\"|g" > UDF_from-template.json

:: maybe qsv slice --json is working
:: maybe qsv slice --json is working
:: maybe qsv slice --json is working
:: maybe qsv slice --json is working

:: bind them in lvs (text)
C:\Users\doria\scoop\apps\git\current\usr\bin\cat.exe UDF_ori_filtered.json > "temp.lvs"
C:\Users\doria\scoop\apps\git\current\usr\bin\cat.exe UDF_from-template.json >> "temp.lvs"
:: remove the part where the 2 json are near eacht other, to have only 1
:: so old UDF are at the top
perl -0777 -pe "s/\s*\n\s*\]\s*\n\s*\[/,/g" temp.lvs > UDF.lvs
REM -0777 — slurp the whole file as one string (multi-line mode)
REM s/\]\s*\r?\n\s*\[/,/g —
REM \] followed by optional whitespace \s*
REM optional whitespace \s*
REM then \[
REM Replaces all such occurrences with a comma ,

C:\Users\doria\scoop\apps\git\current\usr\bin\rm.exe UDF_ori_filtered.json UDF_from-template.json UDF_ori.csv UDF_ori_filtered.csv temp.lvs temp.csv UDF_gdrive.csv *.stats.csv.* *.stats.csv UDF_compare_event.csv UDF_compare_gdrive.csv UDF_compare_gdrive_temp.csv 

qsv lens UDF_compare_w_qsvdiff.csv





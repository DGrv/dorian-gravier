qsv json "User Defined Fields_Fcts..lvs" > udf_ori.csv
qsv join --left-anti Name udf_ori.csv Name "UDF_template_v01 - List_UDF.csv"> udf_ori_filtered.csv

yq udf_ori_filtered.csv -p=csv -o=json |  perl -pe "s|null|\"\"|g" > udf_ori_filtered.json
yq "UDF_template_v01 - List_UDF.csv" -p=csv -o=json |  perl -pe "s|null|\"\"|g" > udf_from-template.json

C:\Users\doria\scoop\apps\git\current\usr\bin\cat.exe udf_ori_filtered.json > "temp.lvs"
C:\Users\doria\scoop\apps\git\current\usr\bin\cat.exe udf_from-template.json >> "temp.lvs"
perl -0777 -pe "s/\s*\n\s*\]\s*\n\s*\[/,/g" temp.lvs > udf.lvs

C:\Users\doria\scoop\apps\git\current\usr\bin\rm.exe udf_ori_filtered.json udf_from-template.json udf_ori.csv udf_ori_filtered.csv temp.lvs 




REM -0777 — slurp the whole file as one string (multi-line mode)
REM s/\]\s*\r?\n\s*\[/,/g —
REM \] followed by optional whitespace \s*
REM optional whitespace \s*
REM then \[
REM Replaces all such occurrences with a comma ,


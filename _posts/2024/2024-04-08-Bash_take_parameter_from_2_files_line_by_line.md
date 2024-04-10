--- 
title: "Bash_take_parameter_from_2_files_line_by_line" 
date: "2024-04-08 12:58" 
comments_id: 81
--- 

Or let's say: How to Read Corresponding Lines From Two Input Files.

I found the solution [here](https://www.baeldung.com/linux/read-lines-two-input-files) and would expose only by favorite one.

```sh
grep "LC20lb MBeuO DKV0Md" "site_https___www.climbers-paradise.com_ filetype_pdf - Google Search.html" | perl -pe "s|.*>(.*?)<.*|\1|g" > Name.txt
grep "jsname=.UWckNb." "site_https___www.climbers-paradise.com_ filetype_pdf - Google Search.html" | perl -pe "s|.*href=.(.*?). .*|\1|g" > pdf_link_climbingpara.txt

while read -r -u 3 lineA && read -r -u 4 lineB
do
    echo curl -o "$lineA" "$lineB" >> Download.sh
done 3<"Name.txt" 4<"pdf_link_climbingpara.txt"

```







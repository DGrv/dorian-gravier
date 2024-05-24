# rm MainList.html temp.html ModernZeiten_UrlList.txt output.csv

# curl  \
  # -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7' \
  # -H 'Accept-Language: de,fr;q=0.9,en;q=0.8,en-GB;q=0.7,es;q=0.6' \
  # -H 'Connection: keep-alive' \
  # -H 'Cookie: G_ENABLED_IDPS=google; ApacheSessionID=aef9138308d979838cb98efbf6a28f1ab345b83f; NavCtx=/climbing/switzerland/haldenstein; _ga=GA1.1.1548316475.1715090738; _ga_E4F0QR29VH=GS1.1.1715090738.1.1.1715091108.0.0.0' \
  # -H 'Referer: https://www.thecrag.com/lists/by/@dgrv' \
  # -H 'Sec-Fetch-Dest: document' \
  # -H 'Sec-Fetch-Mode: navigate' \
  # -H 'Sec-Fetch-Site: same-origin' \
  # -H 'Sec-Fetch-User: ?1' \
  # -H 'Upgrade-Insecure-Requests: 1' \
  # -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36' \
  # -H 'sec-ch-ua: "Chromium";v="124", "Google Chrome";v="124", "Not-A.Brand";v="99"' \
  # -H 'sec-ch-ua-mobile: ?0' \
  # -H 'sec-ch-ua-platform: "Windows"' "https://www.thecrag.com/de/liste/9558769071" > MainList.html
# xmllint --noout  --html --xpath "//div[@class='titlelist']/span/a/@href" MainList.html | perl -pe "s| href=\"(.*)\"|https://www.thecrag.com\1|g" > Urls.txt

echo "url;name;grad;lat;lon" >> output.csv

source /mnt/c/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/bash/source/cecho.sh

cecho -r START LOOP --------------------------

LINES=$(cat Urls.txt)
for line in $LINES 
do

  if grep -Fxq "$line" output.csv
  then
    # code if found
    echo found
  else
    # code if not found
    cecho -g $line
    curl  \
      -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7' \
      -H 'Accept-Language: de,fr;q=0.9,en;q=0.8,en-GB;q=0.7,es;q=0.6' \
      -H 'Connection: keep-alive' \
      -H 'Cookie: G_ENABLED_IDPS=google; ApacheSessionID=aef9138308d979838cb98efbf6a28f1ab345b83f; NavCtx=/climbing/switzerland/haldenstein; _ga=GA1.1.1548316475.1715090738; _ga_E4F0QR29VH=GS1.1.1715090738.1.1.1715091108.0.0.0' \
      -H 'Referer: https://www.thecrag.com/lists/by/@dgrv' \
      -H 'Sec-Fetch-Dest: document' \
      -H 'Sec-Fetch-Mode: navigate' \
      -H 'Sec-Fetch-Site: same-origin' \
      -H 'Sec-Fetch-User: ?1' \
      -H 'Upgrade-Insecure-Requests: 1' \
      -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36' \
      -H 'sec-ch-ua: "Chromium";v="124", "Google Chrome";v="124", "Not-A.Brand";v="99"' \
      -H 'sec-ch-ua-mobile: ?0' \
      -H 'sec-ch-ua-platform: "Windows"' --silent  $line > temp.html
    sleep 5

    nameroute=$(xmllint --noout  --html --xpath "string(//span[@class='heading__t']/span[@itemprop='name'])" temp.html)
    grad=$(xmllint --noout  --html --xpath "string(//span[@class='grade gb2'])" temp.html)
    arealink=$(xmllint --noout  --html --xpath "//div[@class='crumbs__all']/li/a/@href" temp.html | perl -pe "s| href=\"(.*)\"|https://www.thecrag.com\1|g" | tail -2 | head -1)
    loc=$(xmllint --noout  --html --xpath "string(//dl[@class='areaInfo'])" temp.html | perl -pe "s|B.*\:||g" | perl -pe "s|, |;|g"| perl -pe "s|\n||g")

    rm temp.html 

    cecho -y "$arealink -- $nameroute -- $grad -- $loc" 
    sleep 3

    if [ "$line" != "" ]
    then
      echo "$arealink;$nameroute;$grad;$loc" >> output.csv
    fi

  fi

done

# rm temp.html MainList.html temparea.html

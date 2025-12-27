---
title: "Bash or sehll"
permalink: /code/bash/
toc: true
author_profile: false
layout: code
---

# Data Manipulation and Analysis in bash

## Basics

```sh 
head -n -1 # remove last line
tail -n +2 # Remove header
```
## qsv

![]({{ "/files/icon/qsv.png" | relative_url }})

```sh
qsv  slice -s -1 --invert # Remove last row
qsv  stats | qsv lens # Check the stat of a table, type of columns ... 
qsv  stats | qsv lens      # Check the stat of a table, type of columns ... 
qsv apply operations len coord -c testnewcolumn # calculate length of coord column and create a new colum to store the result : https://www.stijn.digital/docs/data-tools/qsv-commands/apply/
```


## miller

```sh
rmLl Not_paid_out_yet.csv | \                          # remove last line from this file (need to)
 mlr  --csv stats1 -a sum -f "ToPayOut" -g "Pay-Out"\  # make a sum of -f col with group from -g
 then rename 'ToPayOut_sum,Sum'\                       # rename the output column
 then put '$Sum=round($Sum)'\                          # do calculatoon
 then sort -nr Sum | \                                 # sort, check  mlr sort -h
 rmH  | \                                              # rm header for termagraph
 termgraph                                             # to a distribution
```

```sh
cat whc001.csv | \ 
 mlr --csv filter '${States Names}=="Greece"' then \                                # filter, filter should always be a bool output
 rename "Name EN", "name", "Coordinates", "coord", "Description EN", "desc" then \  # rename "Name EN" to "Name" and so on
 cut -o -f "name,coord,desc" then put '$group="Unesco"' \                           # select only those columns and keep the order with -o
 --ofs tab | \                                                                      # Export in tsv --ofs is separatour output, you have also --ifs
 rmFl | \                                                                           # remove the header
 clip.exe                                                                           # copy to clipboard
```

## termgraph


## jq




### read json and export csv

[Source](https://www.cyberciti.biz/faq/how-to-convert-json-to-csv-using-linux-unix-shell/)
[Manual](https://jqlang.github.io/jq/manual/#invoking-jq)

```sh 
cat yourjson | jq -r '.[] | join("\t\t")' > "UDF.csv"
cat yourjson | jq -r '.[] | join(";")' > "UDF.csv"
# or even better
cat yourjson | jq -r '.[]' | jq -r @csv > test.csv
```

```sh 
# depending on your json- will extract headers and use it -- really good
cat Contests.lvs | jq -r ' (.[0] | to_entries | map(.key)), (.[] | [.[]]) | @csv' > Contest.csv
```

[Source here](https://stackoverflow.com/a/30032247/2444948)

You can try everything here : [](https://jqplay.org/)

### some commands


```sh
# prettify
jq '.'
# with arrays
jq '.[]'
# access with index
jq '.[1]'
jq '.[]. [0]'
# with Name
jq '.[].name'
# select certain rows
jq '.[]' | jq 'select(.id == 65061)'
# use select with regex
jq '.[]' | jq 'select(.title_short | test("111"))'
# export in csv big example
curl "https://park4night.com/api/places/around?lat=46.25977500237305&lng=8.776788825087465&radius=200" | jq '.[]' | jq '[.id, .lat, .lng, .rating, .type.label, .url, .title_short, .description]' | jq -r @csv > test.csv
# csv to json, For RR: save csv with comma separators
jq Contest_new.csv -p=csv -o=json | perl -pe 's|\{\}|"{}"|g' > Contest_new.lvs
# depending on your json- will extract headers and use it -- really goog
cat Contests.lvs | jq -r ' (.[0] | to_entries | map(.key)), (.[] | [.[]]) | @csv' > Contest.csv
# extract ids from json and add url:
jq -r '.[].[0] | "https://my.raceresult.com/\(.)/logo"' events_2024.json
# do a curl on it, 2 options:
jq -r '.[].[0]' events_2024.json | xargs -I {} curl -o logo_{}.png "https://my.raceresult.com/{}/logo"
jq -r '.[].[0] | "curl -o logo_\(.).png https://my.raceresult.com/\(.)/logo"' events_2024.json | sh


```

### Export 

Export what you want how you want, [found here](https://stackoverflow.com/a/39139478/2444948)

```sh
echo '[{
    "name": "George",
    "id": 12,
    "email": "george@domain.example"
}, {
    "name": "Jack",
    "id": 18,
    "email": "jack@domain.example"
}, {
    "name": "Joe",
    "id": 19,
    "email": "joe@domain.example"
}]' | jq -r '.[] | "\(.id)\t\(.name)"'
```








# Installation and maintenance

## WSL

```batchfile
wsl --list -o
wsl --install -d Ubuntu-22.04
wsl --set-default <Distribution Name>
# version wsl to set if 1
wsl --set-version <distribution name> <versionNumber>
```

## bash

```sh
# in bash
sudo apt update        # Fetches the list of available updates
sudo apt upgrade       # Installs some updates; does not remove packages
sudo apt full-upgrade  # Installs updates; may also remove some packages, if needed
sudo apt autoremove    # Removes any old packages that are no longer needed
sudo apt-get purge --auto-remove packagename # purges/removes a package
sudo apt-get purge --auto-remove packagename # uninstall
sudo apt-get install $(apt-cache depends <PACKAGE> | grep Depends | sed "s/.*ends:\ //" | tr '\n' ' ') # install dependencies
```

### Little things

#### create shortcut

symlink
to list them `sudo find / -type l`
list them from the directory ` find -L . -type l`
they are attached to a directory
to see where it is linking to 
`realpath link_name`
you can remove them `rm link1`

`ln -s /mnt/opera/Screening/ Screening`
`ln -s /mnt/OperaImages/ /mnt/opera`

to go to the symlinl `cd -L yoursymlink`
to know where you are `pwd -P`


#### report file system disk space usage

`df -h`

####  Explanation Bash file

Extension is `sh` but it is not important. To make it executable:

- start script with `#!/bin/bash`
- make it executable with `chmod u+x yourfile`
- run it with `./youfile`

read well [this](https://data-skills.github.io/unix-and-bash/03-bash-scripts/index.html)

[Source](https://stackoverflow.com/questions/27813563/what-is-the-bash-file-extension)

####  Color in echo

use `echo -e` with those codes.

```sh
R='\033[0;31m'   #'0;31' is Red's ANSI color code
G='\033[0;32m'   #'0;32' is Green's ANSI color code
Y='\033[1;32m'   #'1;32' is Yellow's ANSI color code
B='\033[0;34m'   #'0;34' is Blue's ANSI color code
M='\033[0m'   #'0 No Color

echo -e "I ${R}love${N} Linux"
```

Find ANSI codes [here](https://ansi.gabebanks.net/?ref=linuxhandbook.com)

[Source](https://linuxhandbook.com/change-echo-output-color/)


#### kill process

```sh
#find process id
pidof lighttpd
# kill the process
kill theprocessidnumber
```

#### task manager or similar

```sh
top
ps -aux
```

#### sed or perl - Replace string in multiples files

use sed : https://stackoverflow.com/questions/11392478/how-to-replace-a-string-in-multiple-files-in-linux-command-line

`sed -i "s/stringtosearch/stringtoreplace/g" *	`

Example to replace BC in logfiles : H:\Data\Thermo\Echo\ARP_3079\Barcode_exchange\PS85\20190926_Replace_BC_PS85.xlsx
H:\Data\Thermo\Echo\ARP_3079\Barcode_exchange\PS85\TUTO_Exchange_BC_multiple-plates_Polara-log.md

`sed -i -E "s/(.+)S=1:C(.+)BAR CODE READ, NOCODE(.+)/\1S=1:C\2BAR CODE READ, AxxEXP210mM_028\3/g" "H:\Data\Thermo\Echo\ARP_3079\Barcode_exchange\PS85\3079_CP_01.log"`

*Example*

```sh
perl -i -pe "s|\<Placemark id\=.pea.*?\<\/Placemark\>||g" Gipfelbuch_huts.kml

```

*Loop*

Use in and out from 2 different files

```sh 
j=1
echo "echo test" > Change_names.sh
for i in {001..554}
do 
in="WPT$i"
out=$(sed "${j}q;d" kmlnames.txt)
echo "perl -i -pe 's|${in}|${out}|g' Gipfelbuch_huts.gpx" >> Change_names.sh
((j++))
done
```

*Leading zero (leading 0)*

```sh
for i in {001..554}; do; echo $i; done

nrow=$(cat kmlnames.txt | wc -l)
for i in for i in $( eval echo {001..$nrow} ); do; echo $i; done
```

*Multilines to Multilines*

You want to replace this:

```r
if( paste0(Sys.info()[4]) == 'DESKTOP-MG...PG' ) {
  rootpath <- 'C:/Users/doria/Dropbox/Shared_Dorian/'
  Sys.setlocale('LC_ALL', 'German')
} else {
  if( paste0(Sys.info()[4]) == 'DORIANSRECHNER' ) {
    rootpath <- 'C:/Users/dorian.BSPM/Dropbox/Shared_Dorian/'
  } else {
    rootpath <- 'C:/Users/buero.BSPM/Dropbox/Shared_Dorian/'
  }
}
```
with this, which is "after.txt":

```r
rootpath \<\- 'D\:\/BU_Work\/Maxi_BU\/20240812\/Shared_Dorian\/' 
Sys\.setlocale\('LC_ALL', 'German'\)
```

Prepare your expression and your after.txt to include "\n" (check [source](https://unix.stackexchange.com/a/181215/374250))
You can use the [online tool to escape regex](https://beautifycode.net/regex-escape)

```sh
perl -i -0 -pe "s/if\( paste0\(Sys\.info\(\)\[4\].*?utf-8\"\)/$(cat after.txt)/s" Bike_map_location_choose_v02.R
```

Then run it only on the files you are interested in:

*PLEASE MAKE SOME TEST BEFORE*

```sh 
ag -l DORIANSRECHNER | xargs -0 perl -i -0 -pe "s/if\( paste0\(Sys\.info\(\)\[4\].*?utf-8\"\)/$(cat /mnt/c/Users/doria/Downloads/sedtemp/after.txt)/s"
```

other example with `xargs -I ß`

```shell
ag -i "\# setup\r\n" -l | xargs -I ß perl -i -0 -pe "s/\# setup.*utf-8.\)\r\n\)\)/$(cat /mnt/c/Users/doria/Downloads/sedtemp/replace.txt)/s" "ß"
```

This did not work 20250201, I needed to run `ag "%Y%m%d-%H%M%S" -l | tr -d "\r" | xargs -I # perl -i -pe "s/%Y%m%d-%H%M%S/%%Y%%m%%d-%%H%%M%%S/s" #`

other tips to open all file with notepad++

```shell
ag -i "WMIC OS GET LocalDateTime" -l | head -1 | tr -d "\r" | xargs -I # notepad++ #
```

ag is putting a "\r" at the end of the output you can see it with ` ag -i "WMIC OS GET LocalDateTime" -l | head -1 | cat -A`


#### count 

*count number of lines or words*

`wc -l filename`
`wc -w filename`

*number of files*

`-l <folder> | wc -l`

*Find which OS*

`cat /etc/os-release`

*find duplicate lines in file*

[Source](https://stackoverflow.com/questions/6712437/find-duplicate-lines-in-a-file-and-count-how-many-time-each-line-was-duplicated)

`sort <file> | uniq -c`

Do display only duplicates

`sort <file> | uniq -d `

Save only unique value

```cat a.txt b.txt | sort | uniq -u > unique.txt``` *combine both files, sort it alphabeticaly, take only unique values*
```cat a.txt b.txt | sort | uniq -d >> unique.txt``` *combine both files, sort it alphabeticaly, take only duplicate values and append it to the file 'unique.txt'*
`wc -l unique.txt` * count the number of lines*


Print near each other

```sh
pr -m -t Google_Calendar_Dori.csv Google_Calendar_Dori2.csv
pr -m -t -w 200 Google_Calendar_Dori.csv Google_Calendar_Dori2.csv
```

Search in column

```sh
qsv search -s PID "4577" -d "\t" history.csv | csview
qsv search -s PID "4577" -d "\t" history.csv | qsv table
qsv search -s PID "4577" -d "\t" history.csv | qsv table
# if qsv does not work, no output with qsv --version use xsv

xsv search -s Field "Contest" history.csv | csvlens

```

Search in column with csvlens

```sh
qsv lens -t history.csv
	# tab to change btw row or column mode
	# choose your row or column
	# Type & to filter rows 
	# 	&<regex>	Filter rows using regex (show only matches)
	# 	/<regex>	Find content matching regex and highlight matches
	# 	*<regex>	Filter columns using regex (show only matches)
	# Type what you want
	# q to exit
```


#### line by line 2 files

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

#### Rename files with perl or sed for loop

```sh 

for i in *pdf;do
	new=$(echo $i | perl -pe 's/(.*?)_(.*?)(_\d*.pdf|.pdf)/\2__\1__\3/g')
	mv "$i" "$new"
done
```

[Source in SuperUser](https://superuser.com/a/31466/860920)

#### quotes in double quotes in quotes

Tricks with quotes and double quotes from [here](https://stackoverflow.com/a/28786747/2444948):

```sh 
$ echo 'abc'"'"'abc'
abc'abc
$ echo "abc"'"'"abc"
abc"abc
```

#### Size folders

```sh
sudo apt-get install ncdu
ncdu
```

#### list packages size

```sh
dpkg-query -Wf '${Installed-Size}\t${Package}\n' | sort -n

```

[Source](https://unix.stackexchange.com/a/107039/374250)

#### unicode to utf-8

```sh
ascii2uni -a U -q
```




#### P4N matrix coordinate

```sh
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
```

#### packages not fully Installed

Check which one `sudo dpkg -C`
Delete the folders

```sh
cd /var/lib/dpkg/info/
ls | grep packagename
ls | grep packagename | xargs sudo rm 
sudo dpkg --configure -a
sudo apt-get update
```

if `debconf: DbDriver "config": /var/cache/debconf/config.dat is locked by another process: Resource temporarily unavailable`

then `sudo fuser -v /var/cache/debconf/config.dat`
`sudo kill PIDshown`

#### calculator bc Example

```shell
start=(47.3 12.66)
end=(37.3 25.66)

# /1 ist to get int 
h=$(echo "(${start[0]}-${end[0]})*10/1" | bc)
w=$(echo "(${start[1]}-${end[1]})*10/-1" | bc)

# scale=2 is to have 2 decimal after the .
lat=$(echo "scale=2;${start[0]}+($i/10)" | bc -l)
lon=$(echo "scale=2;${start[1]}+($j/10)" | bc -l)
```

#### rename or move files from subdirectories with subdirectories names

Another version, that is renaming and moving the files to the parent directory. But you can change the last line as you want.

```sh
here=$(pwd)
for f in */*.jpg; do
	dir=$(dirname $f)
	image=$(basename $f)
	echo mv ${here}/${f} ${here}/${dir}_${image}
done
```

#### github page with so many example and Tips

[e-bash](https://github.com/OleksandrKucherenko/e-bash?tab=readme-ov-file#commons-functions-and-inputs)

#### convert csv to html table

```sh
awk 'BEGIN {print "<table border=\"1\">"}
     NR==1 {print "<tr>"; for (i=1; i<=NF; i++) print "<th>" $i "</th>"; print "</tr>"}
     NR>1 {print "<tr>"; for (i=1; i<=NF; i++) print "<td>" $i "</td>"; print "</tr>"}
     END {print "</table>"}' FS=, info2.csv > info.html
```

#### change default terminal in wsl

```sh
sudo nano /etc/passwd
# change the line for your user to /usr/bin/bash for example
```

#### Show all 256 colors bash prompt

```sh 
curl -s https://gist.githubusercontent.com/HaleTom/89ffe32783f89f403bba96bd7bcd1263/raw/ | bash
```






# gpx

## split segment or tracks

[check this out]()

```sh
splitgpxtrack() {
    basename="${1%.*}"
    grep name "$1" | perl -pe "s|.*<name>(.*)</name>|\1|g" \
    | cat -n | while read n f; do 
        f2=$(slugify "$f")
        fout=${basename}-${f2}.gpx
        gpsbabel -i gpx -f "$1" -x track,name="$f" -o gpx -F "$fout"
    done
}
```

## export gpx in csv 

```sh 
gpsbabel -i kml -f "in.kml" -t -o unicsv -F "out.csv"
gpsbabel -i kml -f "in.kml" -t -o csv -F "out.csv"
```

## remove gpx points

```sh
gpsbabel -i kml -f "in.kml" -x nuketypes,waypoints -o gpx -F "out.gpx"
```

# Raspberry lessons

```sh
# full upgrade after booting raspberry
sudo apt -y full-upgrade 

# ip adresses
ip -br -c a # best of all
hostname -I
ip a
ifconfig
ip route
nmcli

# taskmanager list
ps auxww
ps auxww | grep dhcp
# kill process with pid
kill -9 PID

# check connection ip
nmcli device
nmcli dev
nmcli connection 
nmcli con
nmcli device show eth0
nmcli device modify eth0 ipv4.method auto
nmcli device modify eth0 ipv6.method auto
# with gui change connection
sudo nmtui 
# or with nmcli
nmcli con mod eth0 ipv4.addresses 192.168.137.89/24
nmcli con mod eth0 ipv4.gateway 192.168.137.1
nmcli con mod eth0 ipv4.dns “8.8.8.8”
nmcli con mod eth0 ipv4.method manual
nmcli con up eth0
# The changes will be written to /etc/sysconfig/network-scripts/ifcfg-eth0 file


# remove useless packages
sudo apt autoremove

# To scan for wireless networks, run the following command:
nmcli dev wifi list
# Connect to a network
sudo nmcli --ask dev wifi connect <example_ssid>
# check if connected
nmcli dev wifi list
# set network priority
nmcli --fields autoconnect-priority,name connection
#Use the nmcli connection modify command to set the priority of a network. The following example command sets the priority of a network named "Pi Towers" to 10:
nmcli connection modify "Pi Towers" connection.autoconnect-priority 10


# to source a file in shell script use . instead of source

```

## install driver AX1800 from BrosTrend

Do not follow their instruction but follow this https://github.com/morrownr/rtl8852bu

## Vnc server

`sudo raspi-config`

Go in Interface / VNC / Enable / Yes
Will start automatically vnc server at start

To start RealVNC Server now: `sudo systemctl start vncserver-x11-serviced`
To start RealVNC Server at next boot, and every subsequent boot: `sudo systemctl enable vncserver-x11-serviced`
To stop RealVNC Server: `sudo systemctl stop vncserver-x11-serviced`
To prevent RealVNC Server starting at boot: `sudo systemctl disable vncserver-x11-serviced`

[Good Tutorial](https://help.realvnc.com/hc/en-us/articles/360002249917-RealVNC-Connect-and-Raspberry-Pi#stopping-a-virtual-desktop-0-8)

## get what happening on the board 

`pinout`

## get file btw windows and Pi

on Windows cmd 

```sh
scp pi@192.168.178.67:~/Downloads/Gopro/20240717__100140_100207.png "C:\Users\doria\Downloads\OBS\test.png"
```

Synchronisation

`rsync -avzP -e ssh pi@192.168.178.67:~/Downloads/Gopro/ /mnt/c/Users/doria/Downloads/OBS/pi`

## share connection from windows wifi throught lan to Linux

[source](https://superuser.com/a/1093443/860920)

On the Windows PC:

- Connect the PC to the WiFi and ensure Internet connection is working locally
- Connect the PC to the LAN and ensure the Ubuntu LAN IP is reachable
- You'd better use fixed IP adresses on the LAN instead of DHCP, or make DHCP reservations on the LAN router
- Go to Control Pannel > Network & Sharing > Network Connections > right-click on the WiFi connection > Properties
	- WiFi connection: On the Share tab > Allow other users to connect... If you don't see the share tab, you may want to disable this feature on the other connections (the wired one) for the tab to appear.
	- WiFi connection: On the Network tab, Internet Protocol version 4 > Properties > Advanced > Disable Auto metric. Use a low metric (eg. Interface Metric = 5).
- Run `ipconfig` from a command prompt and note the Ethernet connection (wired LAN) IP address (<IP>).

On the Ubuntu PC:

- Run `sudo ip route add default via <IP> proto static metric 50`

to reset this reset ip routes `ip route flush table main`

Tips to debug:

Windows:

- `ipconfig /all`
- `route PRINT`
- `tracert 8.8.8.8`

Ubuntu:

- `ifconfig and nmcli dev show`
- `ip route`
- `traceroute 8.8.8.8`




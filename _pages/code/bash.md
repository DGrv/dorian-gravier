---
title: "Bash or sehll"
permalink: /code/bash/
toc: true
author_profile: false
layout: code
---




# install wsl 

```batchfile

wsl --list -o
wsl --install -d Ubuntu-22.04
wsl --set-default <Distribution Name>
# version wsl to set if 1
wsl --set-version <distribution name> <versionNumber>
```

```sh
# in bash
sudo apt update        # Fetches the list of available updates
sudo apt upgrade       # Installs some updates; does not remove packages
sudo apt full-upgrade  # Installs updates; may also remove some packages, if needed
sudo apt autoremove    # Removes any old packages that are no longer needed
```

# create shortcut

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


# report file system disk space usage

`df -h`

# config function or alias

`nano ~/.bashrc`

Modify this file and it will be loaded all the time	
example:

```sh
# Alias Dorian
alias rename.video='ls | grep mp4 | cat -n | while read n f; do mv "$f" `printf "temp_%04d.mp4" $n` ; done ; ls | grep mp4 | cat -n | while read n f; do mv "$f" `printf "%04d.mp4" $n` ; done'
alias move.old="mkdir old & mv *old*.mp4 old/"
alias merge.gpx='ff="";for f in *.gpx; do ff="$ff -f $f"; done; gpsbabel -i gpx $ff -x duplicate,location,shortname -o gpx -F "Merge.gpx"'
```

BU bashrc

```sh
cat ~/.bashrc > /mnt/c/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/bash/source/bashrc.sh
```



# Bash file

Extension is `sh` but it is not important. To make it executable:

- start script with `#!/bin/bash`
- make it executable with `chmod u+x yourfile`
- run it with `./youfile`

read well [this](https://data-skills.github.io/unix-and-bash/03-bash-scripts/index.html)

[Source](https://stackoverflow.com/questions/27813563/what-is-the-bash-file-extension)

# Color in echo

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

# remove files

`rm filename`

## with expression

`rm file*`

### all recursively with space in names

`find ./ -type f -printf '"%p"\n'| grep "(1)" | xargs rm`
-printf '"%p"\n' is to get quotes 
%p means path, could use %f for file

# kill process

## find process id

`pidof lighttpd`

## kill the process

`kill theprocessidnumber`

# Packages

## install

`sudo apt-get update`
`sudo apt-get install <name>`

## uninstall

`sudo apt-get purge --auto-remove packagename`

## install dependencies

`sudo apt-get install $(apt-cache depends <PACKAGE> | grep Depends | sed "s/.*ends:\ //" | tr '\n' ' ')`

# task manager or similar

```sh
top
ps -aux
```

# get ip

ifconfig

# installing exa or build packagename

https://github.com/ogham/exa/issues/783

```sh
In Ubuntu 20.04.4 LTS, I had to install cargo as well.

So the commands had to be modified to

sudo apt install libgit2-dev rustc cargo
sudo apt-mark auto rustc cargo
git clone https://github.com/ogham/exa --depth=1
cd exa
cargo build --release && cargo test #cargo test is optional
sudo install target/release/exa /usr/local/bin/exa
cd ..
rm -rf exa
sudo apt purge --autoremove
```

# EDITORS

## VIM

get in insert mode
i
escape insert mode
esc button
quit without saving

```
:q!
```

save and quit

```
:wq
```

# RAM

Display available memory 

`free -m`

Get your RAM

`grep MemTotal /proc/meminfo`

# File System Disk Space Usage

```sh
df
df -a
```


# Mount

```sh
sudo mount //10.13.20.9/hts  /mnt/hts_share -t cifs -o username=youruser,password=yourpw
sudo mount //10.13.44.9/hts  /mnt/hts_share -t cifs -o username=robolab,password=labarobo
sudo mount //10.13.44.9/OperaImages  /mnt/opera -t cifs -o username=robolab,password=labarobo
sudo umount /mnt/hts_share
```

Keep them mounted:

```sh
cat /proc/mounts
# Copy the lines from the mounted drives
sudo nano /etc/fstab
# add those line there in fstab
```

## Windows Ubuntu

```sh
cd /mnt
sudo mkdir h
sudo mount -t drvfs '\\10.13.20.9\hts' /mnt/h
sudo mkdir x
sudo mount -t drvfs '\\10.13.20.9\OperaImages' /mnt/x
sudo mkdir l
sudo mount -t drvfs '\\10.13.20.10\Ablage' /mnt/l
```

# change title terminal or console

`PS1="\[\e]2;yournewname\a\]"`

or use a function 
from https://askubuntu.com/a/774543/1121492

```sh
# function to set terminal title
function set-title(){
if [[ -z "$ORIG" ]]; then
ORIG="$PS1"
fi
TITLE="\[\e]2;$*\a\]"
PS1="${ORIG}${TITLE}"
}
```


# Slurm

## cmd

print queue
squeue
squeue --format="JobID,JobName%30"
change format squeue print
https://stackoverflow.com/questions/39521707/can-you-change-the-default-output-from-slurms-squeue-command
You simply set the SQUEUE_FORMAT environment variable with the options you specify on the command line.
Exemple:
export SQUEUE_FORMAT="%.18i %.9P %.20j %.8u %.2t %.10M %.6D %.20R %q"
Write the above line in your .bash_profile file and you will always have the additional QOS column in your output.
.bash_profile is in your user home folder. If does not exist.

`touch .bash_profile`
`nano .bash_profile`

write your line, save and exit
reboot
send job
sbatch yourshbatch.sh
with inside

```sh
!/bin/sh
SBATCH --nodelist=wormulon-6   or  here --partititon=screening
SBATCH --job-name=Check-install-packages
```

```r
Rscript /mnt/hts_share/Data/R/Functions/Wormulon/Check-Install-Packages_Wormulon_v03.R
```

# Wormulon


## Run ssh cmd on all nodes	

for host in {1..17}; do ssh -t cellprofiler@wormulon-$host 'Rscript /mnt/hts_share/Data/R/Functions/Wormulon/Check-Install-Packages_Wormulon_v03.R'; done;
for host in {1..17}; do ssh -t cellprofiler@wormulon-$host 'Rscript /mnt/hts_share/Data/R/Functions/Wormulon/Functions_Wormulon_v05.R'; done;

# find / grep / find words

for windows use Gow https://github.com/bmatzelle/gow
on Gow	
Regular expression, recursive, list

`grep -RlE "word1|word2" *.doc`

R is recursive
l stands for "show the file name, not the result itself".
E to use regex expression or use egrep
only in current directory, not recursive

`grep -s string *`

search files, gow does not have find cmd so use ls in combinaison with grep

```sh
ls -lRt | grep "filename"
ls -lR | grep "filename"
ls -lR | grep "filename" | sort
```

or just with windows dir cmd

`dir /s /b *filename*`

replace recursively

`grep -rl "MPB-SS1" * | xargs sed -i "s/MPB-SS1/BKG-SS1/g"`

-rl for list and recursive
xargs -0 to be able to take space in filenames (not sure it is working)
with special character

`grep -rl "mnt\/opera\/scripts" *.* | xargs sed -i "s/mnt\/opera\/scripts/mnt\/hts_share\/Data\/R\/Functions/g"`

grep and last line

`grep -s string *.* | tail -1`

grep line above line below

`grep's -A 1` 

option will give you one line after; -B 1 will give you one line before; and -C 1 combines both to give you one line both before and after, -1 does the same
You can also only print the line below by combining 2 grep:

`grep -Es -A 1 ".*temperature.*Measinfo.*" *.* | grep -v "temperature"`

You then can hide filename and cut the string (first grep), here e.g. to get temperature of envision files

`grep -hEs -A 1 ".*temperature.*Measinfo.*" *.* | grep -v "temperature" | cut -c23-28`

grep hide filename

`grep -h`

## Silver search - ag

Ignore some extension

`ag --ignore *gpx garmin`

# sed or perl - Replace string in multiples files

use sed : https://stackoverflow.com/questions/11392478/how-to-replace-a-string-in-multiple-files-in-linux-command-line

`sed -i "s/stringtosearch/stringtoreplace/g" *	`

Example to replace BC in logfiles : H:\Data\Thermo\Echo\ARP_3079\Barcode_exchange\PS85\20190926_Replace_BC_PS85.xlsx
H:\Data\Thermo\Echo\ARP_3079\Barcode_exchange\PS85\TUTO_Exchange_BC_multiple-plates_Polara-log.md

`sed -i -E "s/(.+)S=1:C(.+)BAR CODE READ, NOCODE(.+)/\1S=1:C\2BAR CODE READ, AxxEXP210mM_028\3/g" "H:\Data\Thermo\Echo\ARP_3079\Barcode_exchange\PS85\3079_CP_01.log"`

## Examples

```sh
perl -i -pe "s|\<Placemark id\=.pea.*?\<\/Placemark\>||g" Gipfelbuch_huts.kml

```

### Loop

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

Leading zero (leading 0)

```sh
for i in {001..554}; do; echo $i; done

nrow=$(cat kmlnames.txt | wc -l)
for i in for i in $( eval echo {001..$nrow} ); do; echo $i; done
```

# count 

## count number of lines or words

`wc -l filename`
`wc -w filename`

## number of files

`-l <folder> | wc -l`

# merge files or concatenate	

cat header.csv adult.data > adult.csv

# Change colors terminal

## Bash ubuntu windows

ALL ANSWER HERE https://superuser.com/a/1284236/860920
Bash ubuntu windows come with shitty colors that are difficult to read
Change color directories
cd /home/<user>

`ls -a`

You should find a .bashrc
make a 

`cp .bashrc .bashrcBU`

add 2 lines

```
echo "LS_COLORS='rs=0:di=1;35:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:';" >> .bashrc
echo "export LS_COLORS" >> .bashrc
```

or via vim
before change vim also background to see correctly
echo "set background=dark" >> .vimrc
quit and restart

You then still have the path in the name with this strange blue color
What is written come from PS1 (session variable). To mke it permanent we have to write it in a file that is loading at the beginning. A good one is the .bashrc.
(https://linuxconfig.org/bash-prompt-basics=)
echo $PS1
Copy this somewhere
https://apple.stackexchange.com/questions/219125/is-there-a-way-to-change-the-font-color-of-the-current-path-in-termial
echo $PS1
\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$
[\033[01;34m\] is your strange color
Overwrite with
echo "PS1='\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;35m\]\w\[\033[00m\]\$'" >> /home/gravier/.bashrc
quit and restart

# Find which OS

cat /etc/os-release

# find duplicate lines in file

https://stackoverflow.com/questions/6712437/find-duplicate-lines-in-a-file-and-count-how-many-time-each-line-was-duplicated

`sort <file> | uniq -c`

Do display only duplicates

`sort <file> | uniq -d `

Save only unique value

```cat a.txt b.txt | sort | uniq -u > unique.txt``` *combine both files, sort it alphabeticaly, take only unique values*
```cat a.txt b.txt | sort | uniq -d >> unique.txt``` *combine both files, sort it alphabeticaly, take only duplicate values and append it to the file 'unique.txt'*
`wc -l unique.txt` * count the number of lines*


# pdftk

## merge all in folder

```sh
pdftk *.pdf cat output mergedfiles.pdf
```

# space on disk

```sh
sudo apt install ncdu  
sudo ncdu / --exclude /mnt
```

# Compare files

```sh
diff -y Google_Calendar_Dori.csv Google_Calendar_Dori2.csv
diff --color Google_Calendar_Dori.csv Google_Calendar_Dori2.csv
```

# csv

Print readable

```sh
csvtool readable "Google_Calendar_Dori (1).csv"
```

Print near each other

```sh
pr -m -t Google_Calendar_Dori.csv Google_Calendar_Dori2.csv
pr -m -t -w 200 Google_Calendar_Dori.csv Google_Calendar_Dori2.csv
```

# line by line 2 files

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

# Rename files with perl or sed for loop

```sh 

for i in *pdf;do
	new=$(echo $i | perl -pe 's/(.*?)_(.*?)(_\d*.pdf|.pdf)/\2__\1__\3/g')
	mv "$i" "$new"
done
```

[Source in SuperUser](https://superuser.com/a/31466/860920)

# quotes in double quotes in quotes

Tricks with quotes and double quotes from [here](https://stackoverflow.com/a/28786747/2444948):

```sh 
$ echo 'abc'"'"'abc'
abc'abc
$ echo "abc"'"'"abc"
abc"abc
```

# read mdb files or ses

Source found [here](https://www.kali.org/tools/mdbtools/).

Working with mdb and ses file extensions.

```sh
file="filename.ses"
mdb-tables -1 "$file"
tablewanted=( customFields settings ranks teamscores contests results )
for value in "${tablewanted[@]}"; do mdb-export -d \\t "$file" $value > "${value}.csv"; done
```

# unicode to utf-8

```sh
ascii2uni -a U -q
```

# read json and export csv

[Source](https://www.cyberciti.biz/faq/how-to-convert-json-to-csv-using-linux-unix-shell/)

```sh 
cat yourjson | jq -r '.[] | join("\t\t")' > "UDF.csv"
```


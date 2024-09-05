# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples


# START Dorian ----------------------------------------------		
# Alias Dorian
alias rvid='nold=$(ls |grep -i mp4 |grep old| wc -l); if [[ $nold != 0 ]];then mkdir -p old ; mv *old*.mp4 old/ ; fi ; ls | grep -i mp4 | grep -v zzz | grep -v title | cat -n | while read n f; do mv "$f" `printf "temp_%04d.mp4" $n` ; done ; ls | grep mp4 | grep -v zzz | grep -v title | cat -n | while read n f; do mv "$f" `printf "%04d.mp4" $n` ; done'
# escape the $ with \ (\$)

# csv
alias csvv='column -t -s,'

# Get duration
alias mp4d='tts=$(exiftool -n -T -duration -s3 *mp4 | jq -s add);tts=$(calc -d "round($tts)"); ttm=$(calc -d "round($tts / 60, 2)"); echo $tts s - $ttm min'
alias mp3d='tts=$(exiftool -n -T -duration -s3 *mp3 | jq -s add);tts=$(calc -d "round($tts)"); ttm=$(calc -d "round($tts / 60, 2)"); echo $tts s - $ttm min'
# funktion tosearch on youtube and download the first found video and export audio
   ytsearch() {  yt-dlp ytsearch1:"$1" -x --audio-format "mp3" --audio-quality 0 -c -o "%(uploader)s__-__%(title)s.%(ext)s"; }
# merge all gpx in folder
alias merge.gpx='ff="";for f in *.gpx; do ff="$ff -f $f"; done; gpsbabel -i gpx $ff -x duplicate,location,shortname -o gpx -F "Merge.gpx"'
# reduce the frame rate of all mp4 in folder
alias reduce.fr.60='for i in *mp4; do  fr=$(exiftool -n -T -VideoFrameRate -s3 $i);  fr=$(calc -d "round($fr)");  fr=$(echo $fr);  if [[ "$fr" -gt "60" ]]; then   nname="$(basename $i .mp4)___old_fr-$fr.mp4";   mv "$i" "$nname"; cecho -g "Convert $i:"; ffmpeg -stats -loglevel error -i "$nname" -r 60 "$i"; echo;  fi; done'
alias reduce.fr.30='for i in *mp4; do  fr=$(exiftool -n -T -VideoFrameRate -s3 $i);  fr=$(calc -d "round($fr)");  fr=$(echo $fr);  if [[ "$fr" -gt "30" ]]; then   nname="$(basename $i .mp4)___old_fr-$fr.mp4";   mv "$i" "$nname"; cecho -g "Convert $i:"; ffmpeg -stats -loglevel error -i "$nname" -r 30 "$i"; echo;  fi; done'
alias reduce.fr.24='for i in *mp4; do  fr=$(exiftool -n -T -VideoFrameRate -s3 $i);  fr=$(calc -d "round($fr)");  fr=$(echo $fr);  if [[ "$fr" -gt "24" ]]; then   nname="$(basename $i .mp4)___old_fr-$fr.mp4";   mv "$i" "$nname"; cecho -g "Convert $i:"; ffmpeg -stats -loglevel error -i "$nname" -r 24 "$i"; echo;  fi; done'

# backup bashrc
alias bubashrc='cat ~/.bashrc > /mnt/c/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/bash/source/bashrc.sh'
mergemp4 () {
    rm listmerge 2> /dev/null
    touch listmerge
    for i in *mp4; do 
        echo file \'$i\' >> listmerge
    done
    ffmpeg -stats -loglevel error -f concat -safe 0 -i listmerge -c copy merge.mp4
    rm listmerge
}
reducemp4 () {
    input=$1
    ffmpeg -stats -loglevel error  -i $input -vf "scale=720:-2" -preset slow -crf 30 -r 24 -acodec aac -y ${input%.*}_r720.mp4
}

# function

mdb-export-all () {
    mdb-tables "$1" | tr ' ' '\n' | while read line ; do
       mdb-export -Q -d "\\t" "$1" $line > "${line}.csv"
    done
}


addpad () {
# add padding if vertical video - right now video should be 1920x1080 or 1080 x1920
cecho -y "Will add a padding if video is 1080x1920 to get it 1920x1080"
for i in *mp4; do
	cecho -g $i
	reso=$(exiftool -ImageSize -s3 $i)
	if [[ "$reso" = "1080x1920" ]]; then
		cecho -r "Need to be padded"
        nname="$(basename $i .mp4)___old_pad.mp4"
        mv "$i" "$nname"
		ffmpeg -stats -loglevel error -y -i "$nname" -vf "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2,setsar=1" "$i"
	fi
done
}

keyframe () {
# add keyframe to get 1 per second to all files in folder
for i in *mp4; do
   fr=$(exiftool -n -T -VideoFrameRate -s3 $i)
   fr=$(calc -d "round($fr)")
   fr=$(echo $fr)
   nname="$(basename $i .mp4)___old_KF.mp4"
   mv "$i" "$nname"
   cecho -g "Add keyframes $i:"
   ffmpeg -stats -loglevel error -i "$nname" -vcodec libx264 -x264-params keyint=$fr:scenecut=0 -acodec copy "$i"
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
        tablewanted=( settings customFields ranks teamscores contests results timingpoints splits history data RawData )
        fdir=$(echo rr_${1} | perl -pe "s|.ses||g" | perl -pe "s| |_|g" )
        mkdir -p $fdir
        # mdb-tables -1 "$1"
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
        # get only what I need
        # extract with perl the json
        # remove \" that is making problems for jq
        # transform unicode (\u0026 ...) with ascii2uni -a U -q
        # then work per line
        grep -s "ListName" "$fdir/settings.csv" | perl -pe "s|.*({\"ListName.*})\t.*|\1|g" | perl -pe "s|\\\\\"|'|g"  | ascii2uni -a U -q | while read line ; do 
            echo "$line" | jq -r '.ListName' | perl -pe "s/\|/  ----  /g"  >> "$fdir/output_list.csv"
            echo "ORDER;Label;Descending;Grouping;GroupingFilterDefault" >> "$fdir/output_list.csv"
            # ; is the separator of the csv, then add \" so a quote for each cell, this \(.Expression) is extract the value with jq
            echo "$line" | jq -r '.Orders[] | ";\"\(.Expression)\";\"\(.Descending)\";\"\(.Grouping)\";\"\(.GroupFilterDefault)\""' >> "$fdir/output_list.csv"
            echo ";" >> "$fdir/output_list.csv"
            echo "$line" | jq -r '"\"LineDynamicFormat\";\"\(.LineDynamicFormat)\""' >> "$fdir/output_list.csv"
            echo ";" >> "$fdir/output_list.csv"
            echo "FIELDS;Label;Expression;LineDynamicFormat" >> "$fdir/output_list.csv"
            echo "$line" | jq -r '.Fields[] | ";\"\(.Label)\";\"\(.Expression)\";\"\(.LineDynamicFormat)\""' >> "$fdir/output_list.csv"
            echo ";" >> "$fdir/output_list.csv"
            echo "FILTERS;OR" >> "$fdir/output_list.csv"
            echo "$line" | jq -r '.Filters[] | ";\"\(.OrConjunction)\";\"\(.Expression1)   \(.Operator)\";\"\(.Expression2)\""' >> "$fdir/output_list.csv"
            echo ";" >> "$fdir/output_list.csv"
            echo ";"  >> "$fdir/output_list.csv"
            echo "-------------" >> "$fdir/output_list.csv"
            echo ";"  >> "$fdir/output_list.csv"
            echo ";"  >> "$fdir/output_list.csv"
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
        /mnt/c/Windows/System32/cmd.exe /C "C:\Users\doria\scoop\shims\rscript.exe" "C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\RR\Leaflet_v01.R" "$PWD/$fdir"
        cecho -g Done
    else
        echo File not found
    fi
}




jpg2mp4 () {
    # convert picture to video
    # $1 is video path
    # $2 how many seconds
    cecho -r "Arg1 is the image, arg2 is duration of the mp4"
    mogrify -resize 1920x1080 -extent 1920x1080 -gravity Center -background black "$1"
    ffmpeg -stats -loglevel error -r "1/$2" -f image2 -i "$1" -vcodec libx264 -vf "fps=30,format=yuv420p" -y temp.mp4
    filename="${1%.*}"
    ffmpeg -stats -loglevel error -i temp.mp4 -f lavfi -i aevalsrc=0 -ac 2 -shortest -y -c:v copy "${filename}.mp4"
    rm temp.mp4
}


timestamp () {
date +"%Y%m%d-%H%M%S"
}


splitgpxtrack() {
    basename="${1%.*}"
    grep name "$1" | perl -pe "s|.*<name>(.*)</name>|\1|g" \
    | cat -n | while read n f; do
        f2=$(slugify "$f")
        fout=${basename}-${f2}.gpx
        gpsbabel -i gpx -f "$1" -x track,name="$f" -o gpx -F "$fout"
    done
}

kml2gpx() {
    basename="${1%.*}"
    gpsbabel -i kml -f "$1" -x nuketypes,waypoints -o gpx -F "${basename}.gpx"
}






rents () {
dirname=$(dirname "$1")
filename=$(basename "$1")
ext=$(echo "$filename" | cut -f 2 -d '.')
filename=$(echo "$filename" | cut -f 1 -d '.')
ts=$(timestamp)
mv "$1"  "${dirname}/${filename}_${ts}.${ext}"
}







# source cecho for color echo
source /mnt/c/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/bash/source/cecho.sh

# shorcut
ffm=/mnt/c/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/Batch/FFmpeg

# END DORIAN --------------------------------------------









# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

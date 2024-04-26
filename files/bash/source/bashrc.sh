# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# START Dorian ----------------------------------------------		
# Alias Dorian
alias rvid='nold=$(ls |grep mp4 |grep old| wc -l); if [[ $nold != 0 ]];then mkdir -p old ; mv *old*.mp4 old/ ; fi ; ls | grep mp4 | grep -v zzz | grep -v title | cat -n | while read n f; do mv "$f" `printf "temp_%04d.mp4" $n` ; done ; ls | grep mp4 | grep -v zzz | grep -v title | cat -n | while read n f; do mv "$f" `printf "%04d.mp4" $n` ; done'
# escape the $ with \ (\$)

# Get duration
alias mp4d='tts=$(exiftool -n -T -duration -s3 *mp4 | jq -s add);tts=$(calc -d "round($tts)"); ttm=$(calc -d "round($tts / 60, 2)"); echo $tts s - $ttm min'
alias mp3d='tts=$(exiftool -n -T -duration -s3 *mp3 | jq -s add);tts=$(calc -d "round($tts)"); ttm=$(calc -d "round($tts / 60, 2)"); echo $tts s - $ttm min'
# funktion tosearch on youtube and download the first found video and export audio
ytsearch() {  yt-dlp ytsearch1:"$1" -x --audio-format "mp3" --audio-quality 0 -c -o "%(uploader)s__-__%(title)s.%(ext)s"; }
# merge all gpx in folder
alias merge.gpx='ff="";for f in *.gpx; do ff="$ff -f $f"; done; gpsbabel -i gpx $ff -x duplicate,location,shortname -o gpx -F "Merge.gpx"'
# reduce the frame rate of all mp4 in folder
alias reduce.fr.60='for i in *mp4; do  fr=$(exiftool -n -T -VideoFrameRate -s3 $i);  fr=$(calc -d "round($fr)");  fr=$(echo $fr);  if [[ "$fr" -gt "60" ]]; then   nname="$(basename $i .mp4)___old_fr-$fr.mp4";   mv "$i" "$nname"; cecho -g "Convert $i:"; ffmpeg -stats -loglevel error -i "$nname" -r 60 "$i"; echo;  fi; done'

# function
ses_extract () {
tablewanted=( settings customFields ranks teamscores contests results timingpoints splits )
fdir=$(echo $1 | perl -pe "s|.ses||g" | perl -pe "s| |_|g" )
mkdir -p $fdir
# mdb-tables -1 "$1"
for value in "${tablewanted[@]}"; do mdb-export -Q -d "\\t" "$1" $value > "$fdir/${value}.csv"; done
grep -s UserFields "$fdir/settings.csv" | perl -pe "s|.*?(\[.*\]).*|\1|g" | perl -pe "s|\\t||g" | ascii2uni -a U -q | jq -r '"'"'.[] | join("\t\t")'"'"' > "$fdir/UDF.csv"

mkdir -p $fdir/gpx
# extract gpx daten
grep -s "GPXFile" "backup_OCHSNER_SPORT_Zurich_Marathon_2024830_20240422-002750/settings.csv" | grep -v GPXFileName | perl -pe "s|.*\<\?xml(.*?)\<\/gpx\>.*|<?xml\1</gpx>|g" > $fdir/gpx/gpx
# extract name gpx
grep -s "GPXFileName" "backup_OCHSNER_SPORT_Zurich_Marathon_2024830_20240422-002750/settings.csv" | perl -pe "s|.*GPXFileName\t.*?\t.*?\t.*?\t(.*?).gpx.*|\1.gpx|g" > $fdir/gpx/namegpx
# export gpx
while read -r -u 3 lineA && read -r -u 4 lineB; do echo $lineB >> "$fdir/gpx/${lineA}" ; done 3<"$fdir/gpx/namegpx" 4<"$fdir/gpx/gpx"
rm $fdir/gpx/namegpx $fdir/gpx/gpx

cd $fdir
/mnt/c/Windows/System32/cmd.exe /C "C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\RR\Split_map_v02.R" "$PWD"
cd ..
}

# source cecho for color echo
source /mnt/c/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/bash/source/cecho.sh

# shorcut
ffm=/mnt/c/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/Batch/FFmpeg

# END DORIAN --------------------------------------------

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


#!/bin/bash
set -x 
# set -v
# exe() { echo '$' "${@:q}" ; "$@" ; }
# exe() { echo "\$ $@" ; "$@" ; }
# exe() { echo "\$ ${@/eval/}" ; "$@" ; }
exe() { echo "\`\$\$  ${@/eval/} \`" ; "$@" ; }
# source: https://stackoverflow.com/questions/2853803/how-to-echo-shell-commands-as-they-are-executed#

# R='\033[0;31m'   #'0;31' is Red's ANSI color code
# G='\033[0;32m'   #'0;32' is Green's ANSI color code
# Y='\033[1;32m'   #'1;32' is Yellow's ANSI color code
# B='\033[0;34m'   #'0;34' is Blue's ANSI color code
# N='\033[0m'   
# check this : https://ansi.gabebanks.net/?ref=linuxhandbook.com

echo
echo -----------------------------------------------------------
echo # Setup
echo Lets take a random keyframe from in.mp4:
echo
exe eval "kfn=20"
echo
echo "kf=\$(ffprobe -v error -select_streams v -show_frames -print_format csv in.mp4 | grep 'frame,video,0,1' | head -$kfn | tail -1 | perl -pe 's|frame,video,0,1,.*?,(.*?),.*|\1|') "
exe eval "kf=$(ffprobe -v error -select_streams v -show_frames -print_format csv in.mp4 | grep 'frame,video,0,1' | head -$kfn | tail -1 | perl -pe 's|frame,video,0,1,.*?,(.*?),.*|\1|') "
echo
echo Lets select keyframe at $kf. Here are the timestamps of the all the frames from in.mp4 around this keyframe.
echo
exe eval "ffprobe -v error -select_streams v -show_frames -print_format csv in.mp4  | perl -pe 's|frame,video,0,(.*?),.*?,(.*?),.*|\2  \1|' | perl -pe 's|(.*?)  1|\1\tKF|' |  perl -pe 's|(.*?)  0|\1|' |grep -A 5 -B 5 --color $kf"
echo
echo Lets compare 2 methods of split: actual losslesscut 3.53.0 and another one
echo
echo -----------------------------------------------------------
echo # Method 1: Losslesscut
echo if I use the split method at timeframe $kf it will run
echo
exe eval "ffmpeg -stats -v error -i "in.mp4" -t $kf -map "0:0" "-c:0" copy -map "0:1" "-c:1" copy -map_metadata 0 -movflags use_metadata_tags -movflags "+faststart" -ignore_unknown -f mp4 -y "in_seg1.mp4""
exe eval "ffmpeg -stats -v error -ss $kf -i "in.mp4" -avoid_negative_ts make_zero -map "0:0" "-c:0" copy -map "0:1" "-c:1" copy -map_metadata 0 -movflags use_metadata_tags -movflags "+faststart" -ignore_unknown -f mp4 -y "in_seg2.mp4""
echo
echo Timestamps of in_seg1.mp4:
echo
exe eval "ffprobe -v error -select_streams v -show_frames -print_format csv in_seg1.mp4  | perl -pe 's|frame,video,0,(.*?),.*?,(.*?),.*|\2  \1|' | perl -pe 's|(.*?)  1|\1\tKF|' |  perl -pe 's|(.*?)  0|\1|' |grep -A 5 -B 5 --color $kf"
echo
echo we see that it is taking 1 or 2 frames too much,always at least the KF
echo
echo -----------------------------------------------------------
echo # Method 2
echo The only good solution and reproducible that I found it to set the -t to 2 frames before the keyframe wanted
echo
echo "kf2=\$(ffprobe -v error -select_streams v -show_frames -print_format csv in.mp4 | perl -pe 's|frame,video,0,.,.*?,(.*?),.*|\1|' | grep --color -B 2 $kf | head -1)"
echo
exe eval "kf2=$(ffprobe -v error -select_streams v -show_frames -print_format csv in.mp4 | perl -pe 's|frame,video,0,.,.*?,(.*?),.*|\1|' | grep --color -B 2 $kf | head -1)"
echo
echo Lets take then $kf2 instead of $kf
echo
exe eval "ffprobe -v error -select_streams v -show_frames -print_format csv in.mp4  | perl -pe 's|frame,video,0,(.*?),.*?,(.*?),.*|\2  \1|' | perl -pe 's|(.*?)  1|\1\tKF|' |  perl -pe 's|(.*?)  0|\1|' |grep -A 5 -B 5 --color $kf2"
exe eval "ffmpeg -stats -v error -i "in.mp4" -t $kf2 -map "0:0" "-c:0" copy -map "0:1" "-c:1" copy -map_metadata 0 -movflags use_metadata_tags -movflags "+faststart" -ignore_unknown -f mp4 -y "in_seg1b.mp4""
echo
exe eval "ffprobe -v error -select_streams v -show_frames -print_format csv in_seg1b.mp4  | perl -pe 's|frame,video,0,(.*?),.*?,(.*?),.*|\2  \1|' | perl -pe 's|(.*?)  1|\1\tKF|' |  perl -pe 's|(.*?)  0|\1|' |grep -A 5 -B 5 --color $kf2"
echo
echo now it it stopping just before the keyframe $kf.
echo

# Different test --------------
# Issue with seg2, first few frames are duplicates
# Take few frame after keyframe for seg2
# kf3=$(ffprobe -v error -select_streams v -show_frames -print_format csv in.mp4 | perl -pe 's|frame,video,0,.,.*?,(.*?),.*|\1|' | grep --color -A 1 $kf2 | tail -1)
# printf "kf3=%kf3%\n"
# ffmpeg -stats -v error -ss "%kf3%" -i "in.mp4" -avoid_negative_ts make_zero -map "0:0" "-c:0" copy -map "0:1" "-c:1" copy -map_metadata 0 -movflags use_metadata_tags -movflags "+faststart" -ignore_unknown -f mp4 -y "in_seg2.mp4"

# Try to trim a second time
# ffmpeg -stats -v error -ss "$kf2" -i "in.mp4" -avoid_negative_ts make_zero -map "0:0" "-c:0" copy -map "0:1" "-c:1" copy -map_metadata 0 -movflags use_metadata_tags -movflags "+faststart" -ignore_unknown -f mp4 -y "in_seg2b.mp4"
# kf3=$(ffprobe -v error -select_streams v -show_frames -print_format csv in_seg2b.mp4 | head -1 | perl -pe 's|frame,video,0,1,.*?,(.*?),.*|\1|')
# ffmpeg -stats -v error -ss "%kf3%" -i "in_seg2b.mp4" -avoid_negative_ts make_zero -map "0:0" "-c:0" copy -map "0:1" "-c:1" copy -map_metadata 0 -movflags use_metadata_tags -movflags "+faststart" -ignore_unknown -f mp4 -y "in_seg2.mp4"
# del in_seg2b.mp4

# Try to use sseof instead of ss
# ffmpeg -stats -v error -sseof "-4.689" -i "in.mp4" -avoid_negative_ts make_zero -map "0:0" "-c:0" copy -map "0:1" "-c:1" copy -map_metadata 0 -movflags use_metadata_tags -movflags "+faststart" -ignore_unknown -f mp4 -y "in_seg2.mp4"

echo -----------------------------------------------------------
echo Concat seg1 and seg2 from each method to compare.
echo
exe eval "(echo file \'in_seg2.mp4\' & echo file \'in_seg1.mp4\' ) > list.txt"
exe eval "ffmpeg -stats -v error -safe 0 -f concat -i list.txt -c copy -y out.mp4 "
exe eval "(echo file \'in_seg2.mp4\' & echo file \'in_seg1b.mp4\' ) > listb.txt"
exe eval "ffmpeg -stats -v error -safe 0 -f concat -i listb.txt -c copy -y outb.mp4 "
exe eval "ffmpeg -stats -v error -i in.mp4 -i out.mp4 -filter_complex "blend=all_mode=difference" -c:a copy -y outdiff.mp4"
exe eval "ffmpeg -stats -v error -i in.mp4 -i outb.mp4 -filter_complex "blend=all_mode=difference" -c:a copy -y outdiffb.mp4"
echo
echo -----------------------------------------------------------
echo Lets check the frame MD5 to see the difference between the 2 methods:
echo
exe eval "ffmpeg -stats -v error -i in_seg1.mp4 -c copy -f framemd5 -y in_seg1.md5"
exe eval "ffmpeg -stats -v error -i in_seg1b.mp4 -c copy -f framemd5 -y in_seg1b.md5"
exe eval "ffmpeg -stats -v error -i in.mp4 -c copy -f framemd5 -y in.md5"
exe eval "ffmpeg -stats -v error -i out.mp4 -c copy -f framemd5 -y out.md5"
exe eval "ffmpeg -stats -v error -i outb.mp4 -c copy -f framemd5 -y outb.md5"
echo
exe eval "lastframe=$(tail -1 in_seg1b.md5 | awk '{print $6}')"
echo
echo lastframe from in_seg1b.mp4 is $lastframe
echo Lets find this frame in in_seg1.mp4, and in in.mp4
echo
echo in_seg1.md5
echo
exe eval "cat in_seg1.md5 | grep --color -B 5 -A 2 $lastframe"
echo
echo in_seg1b.md5
echo
exe eval "cat in_seg1b.md5 | grep --color -B 5 -A 2 $lastframe"
echo
echo in.md5
echo
exe eval "cat in.md5 | grep --color -B 5 -A 5 $lastframe"
echo
echo Lets check the next frame after lastframe in in.mp4 and find it again in the combine seg1 and seg2 in each method.
exe eval "lastframein=$(cat in.md5 | grep --color -A 1 $lastframe | tail -1 | awk '{print $6}')"
echo
echo lastframe from in.mp4 is $lastframein
echo
echo out.md5
echo
exe eval "cat out.md5 | grep --color -B 5 -A 5 $lastframein"
echo
echo outb.md5
echo
echo
exe eval "cat outb.md5 | grep --color -B 5 -A 5 $lastframein"
echo
echo
echo This one is not found in either of both ...
echo Lets check a bit more in detail in.mp4
echo
echo Duplicates in out.mp4
echo
exe eval "cat out.md5 | awk '{print \$6}' | grep --color -A 15 $lastframe | sort | uniq -d"
echo
echo Duplicates in outb.mp4
echo
exe eval "cat outb.md5 | awk '{print \$6}' | grep --color -A 15 $lastframe | sort | uniq -d"
echo
# echo
# echo
# echo Compare in and outb from the lastframe from seg1
# echo
# echo in.md5 and out.md5
# echo
# exe eval "diff -y -W 200 in.md5 out.md5 | grep --color -A 10 -B 10 $lastframe"
# echo
# echo in.md5 and outb.md5
# echo
# exe eval "diff -y -W 200 in.md5 outb.md5 | grep --color -A 10 -B 10 $lastframe"


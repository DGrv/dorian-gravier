#!/bin/bash

source /mnt/c/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/bash/source/cecho.sh

cecho -y "You need for this:"
cecho -p "- a beginning picture"
cecho -p "- a mp4 (losslesscut, smartcut and merge)"
echo 
rm temp0.mp4 temp1.mp4 v1.mp4 v2.mp4 v3.mp4 trailer.mp4  2> /dev/null # keep it silent

# read input user and write to history to get it avalaible with arrow, and allow arrow in read
echo "Give your path with the needed files: " 
read -e -i "" input
echo $input >> ~/.bash_history
history -a

# -d for directory
if [[ ! -d "$input" ]]; then
    echo "$input does not exists."
fi

oldpath=$(pwd)

cd $input
pic=$(ls -1 | grep -E "jpg|png" | head -1)
vid=$(ls -1 | grep mp4 | head -1)
aud=$(ls -1 | grep mp3 | head -1)
nname=$(basename $vid)
nname=${nname:0:3}_trailer.mp4

# mp40=${pic%.*}_temp0.mp4
# mp41=${pic%.*}_temp1.mp4
# mp4=${pic%.*}.mp4

#resize picture
mogrify -resize 1920x1080 -extent 1920x1080 -gravity Center -background black "$pic"
# create video from it
ffmpeg -v error -stats -r 1/3 -f image2 -i "$pic" -vcodec libx264 -vf "fps=30,format=yuv420p" -y temp0.mp4
# add fadeout
ffmpeg -v error -stats -i temp0.mp4 -vf "fade=t=out:st=2:d=1" -acodec copy -y temp1.mp4
# add audio silence
ffmpeg -v error -stats -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=48000 -i temp0.mp4 -vcodec copy -acodec aac -video_track_timescale 30000 -shortest -y v1.mp4

# add fadein and out for trailer
du=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 $vid)
du=$(echo "$du-2" | bc )
ffmpeg -v error -stats -i "$vid" -vf "fade=t=in:st=0:d=2,fade=t=out:st=$du:d=2" -acodec copy -video_track_timescale 30000 -y v2.mp4

# create end 
ffmpeg -v error -stats -f lavfi -i color=c=black:s=1920x1080:d=10 -vf drawtext=fontfile='C\:\\Windows\\Fonts\\Arial.ttf':fontsize=50:fontcolor=white:x=W/2-text_w/2:y=H/2:text='Full video in YouTube - Link in Description',fps=30 -video_track_timescale 30000 -y temp1.mp4

mv temp1.mp4 temp0.mp4
ffmpeg -v error -stats -i temp0.mp4 -i "/mnt/d/Pictures/Youtube/icon/youtube.png" -filter_complex "[1:v]setpts=PTS-STARTPTS+(1/TB)[1v];[0:v][1v] overlay=(W/2-w/2):300:enable='between(t,0.0,20)'" -acodec copy -y temp1.mp4

mv temp1.mp4 temp0.mp4
ffmpeg -v error -stats  -i temp0.mp4 -i "/mnt/d/Pictures/Youtube/icon/channels4_profile.png" -filter_complex "[1:v]setpts=PTS-STARTPTS+(1/TB)[1v];[0:v][1v] overlay=(W/2-w/2):650:enable='between(t,0.0,20)'" -acodec copy -y temp1.mp4

mv temp1.mp4 temp0.mp4
ffmpeg -v error -stats -i temp0.mp4 -vf "fade=t=in:st=0:d=1" -acodec copy -y temp1.mp4

mv temp1.mp4 temp0.mp4
ffmpeg -v error -stats -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=48000 -i temp0.mp4 -vcodec copy -acodec aac -video_track_timescale 30000 -shortest -y v3.mp4

# merge
echo file 'v1.mp4' > temp
echo file 'v2.mp4' >> temp
echo file 'v3.mp4' >> temp
# ffmpeg -v error -stats -i v1.mp4 -i v2.mp4 -i v3.mp4 -filter_complex "[0:v] [0:a] [1:v] [1:a] [2:v] [2:a] concat=n=3:v=1:a=1 [v] [a]" -map "[v]" -map "[a]" -y temp1.mp4
ffmpeg -stats -loglevel error -f concat -i temp -c copy -movflags faststart -y temp1.mp4
rm temp



mv temp1.mp4 temp0.mp4
ffmpeg -v error -stats -i temp0.mp4 -i "$aud" -filter_complex "[0:a]volume=2[a1];[1:a]volume=0.3[a2];[a1][a2]amerge=inputs=2[a]" -map 0:v -map "[a]" -vcodec copy -ac 2 -shortest -y temp1.mp4

mv temp1.mp4 temp0.mp4
ffmpeg -v error -stats  -i temp0.mp4 -vcodec libx264 -vf "scale=720:-2" -preset slow $nname

#clean
rm temp0.mp4 temp1.mp4 v1.mp4 v2.mp4 v3.mp4  2> /dev/null # keep it silent


cd $oldpath
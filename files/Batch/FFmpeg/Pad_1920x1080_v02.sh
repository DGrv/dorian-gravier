#!/bin/bash

source /mnt/c/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/bash/source/cecho.sh

cecho -y "Will add a padding if video is 1080x1920 to get it 1920x1080"

# read input user and write to history to get it avalaible with arrow, and allow arrow in read
cecho -p "Give your path of your mp4 files: " 
read -e -i "" input
echo $input >> ~/.bash_history
history -a

# -d for directory
if [[ ! -d "$input" ]]; then
    cecho -r "$input does not exists."
fi

oldpath=$(pwd)
cd $input

for file in *mp4
do
    reso=$(exiftool -ImageSize -s3 $file)
    if [[ "$reso" = "1080x1920" ]];then
        mv $file temp.mp4
        ffmpeg -stats -loglevel error -y -i temp.mp4 -vf "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2,setsar=1" "$file"
        rm temp.mp4
    fi
done

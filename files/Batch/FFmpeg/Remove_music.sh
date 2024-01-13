#!/bin/bash


source /mnt/c/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/bash/source/cecho.sh


# read input user and write to history to get it avalaible with arrow, and allow arrow in read
echo "Give your TV video path : " 
read -e -i "" filev
echo $filev >> ~/.bash_history
history -a
echo "Do you wanna add keyframes (for making the trailer) [y / n]: " 
read -e -i "" kf


echo	# (optional) move to a new line
if [[ -f "$filev" ]]; then
	pathf=$(dirname $filev)
	pathf=$(dirname $pathf)
	video=$(basename $filev)
	patha=${pathf}/Audio
	patho=${pathf}/trailer
	temp=${patho}/${video%.*}_temp.mp4
	audio=${video/__TV.mp4/__AUDIO.mp3}
	nfile=${video/__TV.mp4/__WITHOUT-MUSIC.mp4}
	nfile=$patho/$nfile
	filea=${patha}/$audio
	
	cecho -p "[DEBUG] ---------------"
	cecho -p "filev = $filev"
	cecho -p "pathf = $pathf"
	cecho -p "patha = $patha"
	cecho -p "patho = $patho"
	cecho -p "temp = $temp"
	cecho -p "audio = $audio"
	cecho -p "filea = $filea"
	cecho -p "nfile = $nfile"
	cecho -p "---------------"
	echo
	
	cecho -g "Switch audio --- will be written in " $patho
	ffmpeg -v error -stats -i $filev -i $filea -map 0:v -map 1:a -c:v copy -ac 2 -shortest -y $temp
	# this step to permit smart cut with losslesscut
	if [[ $kf == "y" ]]; then
		cecho -g "\nAdd Keyframes"
		ffmpeg -v error -stats -i $temp -vcodec libx264 -x264-params keyint=15:scenecut=0 -video_track_timescale 30000 -acodec copy -y $nfile
		rm $temp
	else 
		mv $temp $nfile
	fi
	
	
else
	echo "Your file '$file' does not exists."
fi

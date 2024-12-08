#!/bin/bash  -i

# with -i make you bash interactive so take your bashrc


cd /mnt/d/Pictures/GoPro/IMPORT/test || exit

# loop through folders wanted
# declare -a arr=(
# "l0"
# "l1"
# "l2"
# "l3"
# "l4"
# "d1"
# "d2")
# list all directories with ls
ls -d */ | cut -f1 -d'/'
arr=($(ls -d */ | cut -f1 -d'/' | grep -v BU ))


## now loop through the above array
for k in "${arr[@]}"; do
	echo "$k -------------------" 
	cd $k || exit
	renamemp4ext
	# # fix some errors do not know which
	# for i in *mp4; do 
	# 	nname="$(basename $i .mp4)_temp.mp4"
	# 	mv "$i" "$nname"
	# 	ffmpeg -stats -loglevel error -err_detect ignore_err -i $nname -c copy $i
	# 	rm "$nname"
	# done
	for i in *mp4; do
		nname=$(echo $i | perl -pe "s/.*(seg\d).mp4/\1.md5/")
		ffmpeg -stats -v error -i $i -c copy -f framemd5 -y $nname
	done
	concatmp4
	mv concat.mp4 "../concat_${k}.mp4"
	concat2mp4
	mv concat2.mp4 "../concat2_${k}.mp4"
	mergemp4
	mv merge.mp4 "../merge_${k}.mp4"
	cd ..
done

# get the number of files
nlist=$(ls -1 *mp4 | grep -E "concat|merge" | wc -l)
echo $nlist
# get the list of files
listls=$(ls -1 *mp4 | grep -E "concat|merge")
echo $listls
# get the list of files but in array
listfa=($(ls -1 *mp4 | grep -E "concat|merge"))
# get list of file with -i for ffmpeg
listf=$(ls -1 *mp4 | grep -E "concat|merge" | perl -pe "s/\n/ -i /")
listf="-i ${listf::-3}"
echo $listf



# shellcheck disable=SC2068
# prepare the drawtext for all video
# para1=$(for i in ${!listfa[@]}; do echo "[$i]drawtext=text='${listfa[$i]}':fontfile='C\:\\\\Windows\\\\Fonts\\\\calibri.ttf':fontsize=150:fontcolor=white:x=(w-text_w)/2:y=(h-text_h)/2[v$i];";done)
para1=$(for i in ${!listfa[@]}; do echo "[$i]drawtext=text='${listfa[$i]}':fontfile='C\\:\\\\Windows\\\\Fonts\\\\calibri.ttf':fontsize=150:fontcolor=white:x=50:y=50[v$i];";done)
# shellcheck disable=SC2068
# prepare the xstack ffmeg
para2=$(for i in ${!listfa[@]}; do echo "[v$i]";done| perl -pe "s/\n//")
echo $para2

# prepare the matrix xstack layour
# x=3
# y=2
x=$(ls -1 | grep -E "concat|merge" | wc -l )
y=$(ls -l | grep merge | wc -l)
let x/=y
echo $y
echo Matrix: $x x $y

let x-=1
let y-=1


para3=$(for i in $(seq 0 1 $x); do 
	for j in $(seq 0 1 $y);do 
		if [[ $i -eq 0 ]]; then
			wf="0"
		elif [[ $i -eq 1 ]]; then
			wf="w0"
		else 
			wf=$(printf 'w0+%.0s' $(seq $i) | rlc )
		fi
		if [[ $j -eq 0 ]]; then
			hf="0"
		elif [[ $j -eq 1 ]]; then
			hf="h0"
		else 
			hf=$(printf 'h0+%.0s' $(seq $j) | rlc )
		fi
		echo "${wf}_${hf}"
	done
done | perl -pe "s/\n/|/g" | rlc )
echo $para3


cmd2run=$(echo "ffmpeg $listf -filter_complex \"${para1} ${para2}xstack=inputs=$nlist:layout=${para3}[all];[all]scale=1920:-2\" -y output.mp4")
echo $cmd2run > cmd.cmd
cmd.exe /c cmd.cmd
# eval $cmd2run
cmd.exe /c "mpv output.mp4 --loop-file=inf"


# ls -1 | grep -E "concat|merge" | xargs rm
 
 

for k in "${arr[@]}"; do
	cecho -y "${k} -------------------------------------------------------------------"
	# remove space with tr
	# print only line with more that 100 characters
	# tr delete space
	# grep get number of character
	# icdiff ./$k/seg1.md5 ./$k/seg2.md5 | tr -d ' ' |grep '.\{100\}'

	# but best solution
	# tail remove the first 19 lines
	# awk print 6th column
	# fgrep find common lines
	fgrep -f <(tail -n +19 ./$k/seg1.md5 | awk '{print $6}') <(tail -n +19 ./$k/seg2.md5 | awk '{print $6}')
 done 
 
 
 
 
 
 
 
 
#!/bin/bash 


oripath=$PWD
cd $oripath || exit
source "$oripath/functions.sh"
source "$oripath/cecho.sh"

# check depedencies
checkdep ffmpeg perl ffprobe grep awk xargs

[ ! -e output ] && mkdir output

arr=("b" "sc" "bfix")

for k in "${arr[@]}"; do
    if [[ "$k" == "bfix" ]]; then
        cp -r ./original/b ./output/$k
        cd "./output/bfix" || exit 
        rmdf
        cd "$oripath" || exit
    else
        cp -r ./original/$k ./output/$k
    fi
    cd "./output/$k" || exit
    concatmp4
    mv concat.mp4 "../protocol_${k}.mp4"
	mergemp4
	mv merge.mp4 "../demuxer_${k}.mp4"
    cd "$oripath" || exit
    rm -r "./output/$k"
done

cd "$oripath/output" || exit
[ -e "matrix.mp4" ] && rm "matrix.mp4"
matrixmp4

cmd.exe /c "mpv matrix.mp4 --loop-file=inf"

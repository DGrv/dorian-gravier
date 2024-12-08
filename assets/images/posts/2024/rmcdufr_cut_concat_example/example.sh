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
matrixmp4

cmd.exe /c "mpv matrix.mp4 --loop-file=inf"
# cd "$oripath" || exit
# rm -r output

# # compare difference between method ffmpeg ---------------------------------------
# cd "$oripath/output" || exit
# for i in *mp4; do
#     fne=$(basename $i .mp4)                                           # get basename of file mp4
#     ffmpeg -stats -v error -i $i -c copy -f framemd5 -y $fne.md5      # create the md5
#     cat $fne.md5 | grep -E "^0," | awk '{print $6}' > $fne.md5 # remove the headers unwanted, filter only video, get md5 from frame
# done
# cat protocol_bfix.md5 | wc -l
# cat demuxer_bfix.md5 | wc -l
# head -1 protocol_bfix.md5 
# head -1 demuxer_bfix.md5 
# grep -f protocol_bfix.md5 demuxer_bfix.md5

# grep -v -f <(exiftool protocol_bfix.md5) <(exiftool demuxer_bfix.md5)
# icdiff <(exiftool protocol_bfix.md5) <(exiftool demuxer_bfix.md5)
# exiftool protocol_bfix.mp4
# rm ./*.md5 # remove the temp file and the md5

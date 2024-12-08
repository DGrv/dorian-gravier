


checkdep() {
    local args=("$@")
    deps=0
    for name in "${args[@]}"; do
        [[ $(command -v $name 2>/dev/null) ]] || { cecho -y "$name" -r " needs to be installed.";deps=1;}
    done
    [[ $deps -ne 1 ]] && cecho -g "All depedencies fulfilled" || { cecho -r "\nInstall the above and rerun this script\n"; }
}

rlc () {
	perl -pe "s/.$//"
}




concatmp4 () {
    for i in *.mp4; do 
        nname="$(basename $i .mp4).ts"
        ffmpeg -stats -loglevel error -i $i -c copy $nname
    done
    listts=$(ls -1 *.ts | perl -pe "s/\n/|/")
    listts=${listts::-1}
    ffmpeg -stats -loglevel error -i "concat:${listts}" -c copy concat.mp4
    ls -1 |grep -E "*.ts$" | xargs rm
}

mergemp4 () {
    rm listmerge 2> /dev/null
    touch listmerge
    for i in *.mp4; do 
        echo file \'$i\' >> listmerge
    done
    ffmpeg -stats -loglevel error -f concat -safe 0 -i listmerge -c copy merge.mp4
    rm listmerge
}

reducefr30() {
    cecho -c "Check FPS ---------- if you want to set another value use $1"
    if [[ ! -z "$1" ]]; then
        fps=$1
    else
        fps=30
    fi
    for i in *mp4; do
    fr=$(exiftool -n -T -VideoFrameRate -s3 $i)
    fr=$(calc -d "round($fr)")
    fr=$(echo $fr)
    # ts=$(ffprobe -v error -select_streams v:0 -show_entries stream=time_base -of default=noprint_wrappers=1:nokey=1 "$i")
    if [[ "$fr" -gt $fps ]]; then
        cecho -y "${i} - framerate: " -r "${fr}"
        nname="$(basename $i .mp4)___old_fr-$fr.mp4"
        mv "$i" "$nname"
        cecho -g "Convert $i:"
        # ffmpeg -stats -loglevel error -i "$nname" -r $fps -video_track_timescale 30000 "$i"
        ffmpeg -stats -loglevel error -i "$nname" -r $fps "$i"
        rm "$nname"
    else
        cecho -y "${i} - framerate: " -g "${fr}"
    fi
    done
}


check_codec() {
  cecho -c "Check codec ----------"
  for i in *mp4; do
    # t=$(exiftool -n -T -CompressorName -s3 $i)
    t=$(ffprobe -v error -select_streams v:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 "$i")
    if [[ ! "$t" =~ "264" ]]; then
        cecho -y "${i} - Codec: " -r "${t}"
        nname="$(basename $i .mp4)___temp.mp4"
        mv "$i" "$nname"
        ffmpeg -stats -loglevel error  -i "$nname" "$i"
        echo .
        rm "$nname"
        # cecho -r "${i} - ${t}"
    else 
        cecho -y "${i} - Codec: " -g "${t}"
    fi
  done
}

matrixmp4() {

    # important for making a matrix
    # - same codec, fr, time ...

    check_codec
    reducefr30 25

    # get the number of files
    nlist=$(ls -1 *mp4  | wc -l)
    echo $nlist
    # get the list of files
    listls=$(ls -1 *mp4 )
    echo $listls
    # get the list of files but in array
    listfa=($(ls -1 *mp4 ))

    # get the duration of the shortest video in order to set it in listf with -t $mdu
    mdu=99999999
    for i in *mp4; do
        du=$(exiftool -n -T -duration -s3 "$i")
        if (( $(echo "$du < $mdu" | bc -l) )); then
            mdu=$du
        fi
    done


    # get list of file with -i for ffmpeg
    listf=$(ls -1 *mp4 | perl -pe "s/\n/ -i /")
    listf="-t $du -i ${listf::-3}"
    echo $listf



    # shellcheck disable=SC2068
    # prepare the drawtext for all video
    # para1=$(for i in ${!listfa[@]}; do echo "[$i]drawtext=text='${listfa[$i]}':fontfile='C\:\\\\Windows\\\\Fonts\\\\calibri.ttf':fontsize=150:fontcolor=white:x=(w-text_w)/2:y=(h-text_h)/2[v$i];";done)
    para1=$(for i in ${!listfa[@]}; do echo "[$i]drawtext=text='${listfa[$i]//.mp4}':fontfile='C\\:\\\\Windows\\\\Fonts\\\\calibri.ttf':fontsize=150:fontcolor=white:x=50:y=50[v$i];";done)
    # shellcheck disable=SC2068
    # prepare the xstack ffmeg
    para2=$(for i in ${!listfa[@]}; do echo "[v$i]";done| perl -pe "s/\n//")
    echo $para2rm

    # prepare the matrix xstack layour
    # x=3
    # y=2
    x=$(ls -1 *mp4 | wc -l )
    echo $x
    y=$(($x/2))
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


    cmd2run=$(echo "ffmpeg -stats -v error $listf -filter_complex \"${para1} ${para2}xstack=inputs=$nlist:layout=${para3}[all];[all]scale=1920:-2\" -y matrix.mp4")
    echo $cmd2run > cmd.cmd
    cmd.exe /c cmd.cmd
    rm cmd.cmd
    # cmd.exe /c "mpv matrix.mp4 --loop-file=inf"
}

rmdf() {

    [ ! -e BU_rmdf ] && mkdir BU_rmdf

    cecho -y "Create the md5 -------------------------------------------------------------------------------------------"
    for i in *mp4; do
        fne=$(basename $i .mp4)                                           # get basename of file mp4
        [ ! -e "BU_rmdf/$i" ] && cp "$i" BU_rmdf
        ffmpeg -stats -v error -i $i -c copy -f framemd5 -y $fne.md5      # create the md5
        cat $fne.md5 | grep -E "^0," | awk '{print $6}' > $fne.md5 # remove the headers unwanted, filter only video, get md5 from frame
    done

    lmd5=($(ls -1 ./*md5))        # get the list of md5 in folder
    nlmd5=$(ls -1 ./*md5 | wc -l) # count how many md5

    for i in $(seq 1 1 $(($nlmd5 - 1)) ); do
        # loop through file all md5 except through a sequence (last file will not be modified)

        i0=$(($i - 1)) # get file1, i is file2
        cecho -y "Check ----- " -g "${lmd5[$i0]}" -y " ---- " -r "${lmd5[$i]}"
        
        md5f=$(grep -f "${lmd5[$i0]}" "${lmd5[$i]}" | head -1 )   # find common frames with the md5 (modified ones from above) btw file1 and file2, keep the md5 from 1st frame in common
        
        # check if common frame, so if md5f not empty
        if [ ! -z "${md5f}" ]; then
            md5fid=$(grep -n "$md5f" "${lmd5[$i0]}" | cut -d : -f 1) # find which frame it is in file1
            md5fid=$(("$md5fid" - 1))                                # get frame id before the common one
            mp4out=$(basename "${lmd5[$i0]}" .md5).mp4               # conversion md5 filename and mp4

            # Video procession
            cecho -g "\tModify $mp4out at $md5fid"
            mv "$mp4out" temp.mp4                                                                     # make a copy
            ffmpeg -stats -v error -i "temp.mp4" -frames:v "$md5fid" -c:v copy -c:a copy -y "$mp4out" # cut file 1 from frame 0 to common one

            # # debug bu, if you want to compare the number of frame before and after cut
            nfr1=$(ffprobe -v error -count_frames -select_streams v:0 -show_entries stream=nb_read_frames -of csv=p=0 "temp.mp4")
            nfr2=$(ffprobe -v error -count_frames -select_streams v:0 -show_entries stream=nb_read_frames -of csv=p=0 "$mp4out")
            cecho -y "\t\tnfr1=" -g "$nfr1" -y "\tnfr2=" -r "$nfr2" -y "\tLost " -c "$(($nfr1-$nfr2))" -y " frames"

            [ -e temp.mp4 ] && rm temp.mp4 # rm if exists
        else
            cecho -g "\tNo common frames :)"
        fi

    done
    rm ./*.md5 # remove the temp file and the md5
}

#!/bin/sh

# source me in your script or .bashrc/.zshrc if wanna use cecho
# source '/path/to/cecho.sh'



makeitall() {
    cmd.exe /c 'C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\Batch\FFmpeg\Make_it_ALL_v16___FFMPEG.bat "%CD%"'
}



# Alias Dorian
alias rvid='nold=$(ls |grep -i mp4 |grep old| wc -l); if [[ $nold != 0 ]];then mkdir -p old ; mv *old*.mp4 old/ ; fi ; ls | grep -i mp4 | grep -v zzz | grep -v title | cat -n | while read n f; do mv "$f" `printf "temp_%04d.mp4" $n` ; done ; ls | grep mp4 | grep -v zzz | grep -v title | cat -n | while read n f; do mv "$f" `printf "%04d.mp4" $n` ; done'
# escape the $ with \ (\$)

# csv
alias csvv='column -t -s,'

# Get duration
alias mp4d='tts=$(exiftool -n -T -duration -s3 *mp4 | jq -s add);tts=$(calc -d "round($tts)"); ttm=$(calc -d "round($tts / 60, 2)"); echo $tts s - $ttm min'

alias mp3d='tts=$(exiftool -n -T -duration -s3 *mp3 | jq -s add);tts=$(calc -d "round($tts)"); ttm=$(calc -d "round($tts / 60, 2)"); echo $tts s - $ttm min'


# Print all frame rate
alias framerate='for i in *mp4; do fr=$(exiftool -n -T -VideoFrameRate -s3 $i);  fr=$(calc -d "round($fr)"); if [[ "$fr" -gt "30" ]]; then echo $i -- $fr;fi; done'


# reduce the frame rate of all mp4 in folder
alias reduce.fr.60='for i in *mp4; do  fr=$(exiftool -n -T -VideoFrameRate -s3 $i);  fr=$(calc -d "round($fr)");  fr=$(echo $fr);  if [[ "$fr" -gt "60" ]]; then   nname="$(basename $i .mp4)___old_fr-$fr.mp4";   mv "$i" "$nname"; cecho -g "Convert $i:"; ffmpeg -stats -loglevel error -i "$nname" -r 60 "$i"; echo;  fi; done'

alias reduce.fr.30='for i in *mp4; do  fr=$(exiftool -n -T -VideoFrameRate -s3 $i);  fr=$(calc -d "round($fr)");  fr=$(echo $fr);  if [[ "$fr" -gt "30" ]]; then   nname="$(basename $i .mp4)___old_fr-$fr.mp4";   mv "$i" "$nname"; cecho -g "Convert $i:"; ffmpeg -stats -loglevel error -i "$nname" -r 30 "$i"; echo;  fi; done'

alias reduce.fr.24='for i in *mp4; do  fr=$(exiftool -n -T -VideoFrameRate -s3 $i);  fr=$(calc -d "round($fr)");  fr=$(echo $fr);  if [[ "$fr" -gt "24" ]]; then   nname="$(basename $i .mp4)___old_fr-$fr.mp4";   mv "$i" "$nname"; cecho -g "Convert $i:"; ffmpeg -stats -loglevel error -i "$nname" -r 24 "$i"; echo;  fi; done'


# funktion tosearch on youtube and download the first found video and export audio
ytsearch() {  yt-dlp ytsearch1:"$1" -x --audio-format "mp3" --audio-quality 0 -c -o "%(uploader)s__-__%(title)s.%(ext)s"; }


gifx4() {
	# speed up a gif 4 times
	ffmpeg -i "$1" -filter_complex "[0:v]mpdecimate,setpts=0.25*PTS,split[a][b];[a]palettegen[p];[b][p]paletteuse" -y "$(basename $i .gif)_x4.gif"
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


concat2mp4 () {
    # not better than concatmap4
    # not better than concatmap4
    # not better than concatmap4
    for i in *.mp4; do 
        nname="$(basename $i .mp4).ts"
        ffmpeg -stats -loglevel error  -i $i -c copy -bsf:v h264_mp4toannexb -f mpegts $nname
        # ffmpeg -stats -loglevel error -i $i -c copy $nname
    done
    listts=$(ls -1 *.ts | perl -pe "s/\n/|/")
    listts=${listts::-1}
    # ffmpeg -stats -loglevel error -i "concat:${listts}" -c copy concat2.mp4
    ffmpeg -stats -loglevel error -i "concat:${listts}" -c copy -bsf:a aac_adtstoasc concat2.mp4
    ls -1 |grep -E "*.ts$" | xargs rm
}

concatmp4 () {
    for i in *.mp4; do 
        nname="$(basename $i .mp4).ts"
        ffmpeg -stats -loglevel error -i $i -c copy $nname
    done
    listts=$(ls -1 *.ts | perl -pe "s/\n/|/")
    listts=${listts::-1}
    ffmpeg -stats -loglevel error -i "concat:${listts}" -c copy concat.mp4
    ls -1 |grep -E ".*.ts$" | xargs rm
}

mergemp4 () {
    cecho -r "Do not use this function, use concatmp4 instead"
    rm listmerge 2> /dev/null
    touch listmerge
    for i in *.mp4; do 
        echo file \'$i\' >> listmerge
    done
    ffmpeg -stats -loglevel error -f concat -safe 0 -i listmerge -c copy merge.mp4
    rm listmerge
}

# OLD VERSION
# reducemp4 () {
    # cecho -r "Reduce resolution of a video, $1 is x resolution, $2 is inputfile"
    # input=$2
    # reso=$1
    # ffmpeg -stats -loglevel error  -i $input -vf "scale=${reso}:-2" -preset slow -crf 30 -r 24 -acodec aac -y "${input%.*}_r${reso}.mp4"
# }

reducemp4 () {
	cecho -r "Reduce resolution of a video, $1 is x resolution, $2 is inputfile, can also be used 'reducemp4 720 *.mp4'"
    reso=$1
    shift   # removes the first argument so "$@" now contains only the files

    for input in "$@"; do
        cecho -r "Reduce resolution of $input to $reso px"
        ffmpeg -stats -loglevel error \
            -i "$input" \
            -vf "scale=${reso}:-2" \
            -preset slow -crf 30 -r 24 -acodec aac \
            -y "${input%.*}_r${reso}.mp4"
    done
}


restoreBUoverlay() {
    orifold=$PWD
    fold="${orifold}/BU_Music_overlay/"
    cd "$fold"
    for i in *mp4; do
        nname="${i:0:4}.mp4"
        mv "$i" "$orifold/$nname"
    done
    cd "$orifold"
}


renamemp4ext() {
    count=$(ls -1 *.MP4 2>/dev/null | wc -l)
    if [[ "$count" -gt "0" ]]; then
        cecho -c "Rename MP4 to mp4 ----------"
        for i in *MP4; do
            nname="$(basename $i .MP4).mp4"
            tname="$(basename $i .MP4)__rename.mp4"
            mv "$i" "$tname"
            mv "$tname" "$nname"
        done
    fi
}

normamp3() {
    cecho -c "Norma mp3 ----------"
    # if [ ! -d "BU_mp3" ]; then
        # Directory does not exist, so create it
    mkdir -p "BU_music"
    # fi
    for i in *.mp3;do 
        if [[ ! -f "BU_music/${i}" ]]; then
            cp "$i" "BU_music/${i}"
        fi
    done
    mp3gain -r -d 3 -p *mp3
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


check_starttime() {
    cecho -c "repair ----------"
    for i in *mp4; do
        sumstarttime=$(ffprobe -v error -show_entries stream=start_time -of default=noprint_wrappers=1:nokey=1 "$i" | paste -sd+ | bc)
        if (($(echo $sumstarttime '>' 0|bc))); then
            cecho -y "${i} - sumestarttime: " -r "${sumstarttime}"
            nname="$(basename $i .mp4)"
            mv "$i" "${nname}___temp.mp4"
            cecho -g "repair $i:"
            ffmpeg -stats -loglevel error -err_detect ignore_err -i "${nname}___temp.mp4" -c copy "$i"
            rm "${nname}___temp.mp4"
        else
            cecho -y "${i} - sumestarttime: " -g "${sumstarttime}"
        fi
    done
}


check_AR() {
  cecho -c "Check Audio Sample Rate ----------"
  for i in *mp4; do
    t=$(exiftool -n -T -AudioSampleRate -s3 $i)
    # ts=$(ffprobe -v error -select_streams a:0 -show_entries stream=time_base -of default=noprint_wrappers=1:nokey=1 "$i")
    # cecho -y "${i} - AudioSampleRate: ${t} - timescale: ${ts}"
    if [[ "$t" != "48000" ]]; then
        cecho -y "${i} - AudioSampleRate: " -r "${t}"
        nname="$(basename $i .mp4)"
        mv "$i" "${nname}___temp.mp4"
        cecho -g "Change audio sample rate to 48000 $i:"
        ffmpeg -stats -loglevel error -i "${nname}___temp.mp4" -vn -acodec copy "${nname}___temp.aac"
        ffmpeg -stats -loglevel error -i "${nname}___temp.aac" -ar 48000 "${nname}.aac"
        ffmpeg -stats -loglevel error -i "${nname}___temp.mp4" -i "${nname}.aac" -c:v copy -map 0:v:0 -map 1:a:0 "$i"
        # ffmpeg -stats -loglevel error  -i "$nname" -ar 48000 "$i"
        echo .
        rm "${nname}___temp.mp4" "${nname}___temp.aac" "${nname}.aac"
    else
        cecho -y "${i} - AudioSampleRate: " -g "${t}"
    fi
  done
}

check_reso() {
  cecho -c "Check Resolution ----------"
  for i in *mp4; do
    t=$(exiftool -n -T -SourceImageWidth -s3 $i)
    if [[ "$t" != "1920" ]]; then
        cecho -y "${i} - Reso: " -r "${t}"
        nname="$(basename $i .mp4)___temp.mp4"
        mv "$i" "$nname"
        cecho -g "Change resolution to 1920x1080 $i:"
        # ffmpeg -stats -loglevel error  -i "$nname" -vf "scale=1920:-2" "$i"
        ffmpeg -stats -loglevel error  -i "$nname" -vf "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(1920-iw)/2:(1080-ih)/2" -c:a copy "$i"
        echo .
        rm "$nname"
    else
        cecho -y "${i} - Reso: " -g "${t}"
    fi
  done
}

check_duration() {
  cecho -c "Check Duration ----------"
  checkdurationout=0
  count=$(ls -1 *.mp4 2>/dev/null | wc -l)
  if [[ "$count" -gt "0" ]]; then
    tts=$(exiftool -n -T -duration -s3 *mp4 | jq -s add)
    tts=$(calc -d "round($tts)+12+12+12")
    count=$(ls -1 *.mp3 2>/dev/null | wc -l)
    if [[ "$count" -gt "0" ]]; then
      ttsa=$(exiftool -n -T -duration -s3 *mp3 | jq -s add)
      ttsa=$(calc -d "round($ttsa)")
      if [[ "$tts" -gt "$ttsa" ]]; then
        cecho -r "Audio too low"
        echo "mp4:$tts"
        echo "mp3:$ttsa"
        cecho -y "Variable checkdurationout assign to 0"
        checkdurationout=0
        echo 0
      else
        cecho -g "Ok"
        echo "mp4:$tts"
        echo "mp3:$ttsa"
        cecho -y "Variable checkdurationout assign to 1"
        checkdurationout=1
        echo 1
    fi
    else
      checkdurationout=0
      echo 0
      cecho -r "No mp3"
    fi
  else
    checkdurationout=0
    echo 0
    cecho -r "No mp4"
  fi
}


printfps() {
  cecho -c "Show FPS ----------"
  for i in *mp4; do
    fr=$(exiftool -n -T -VideoFrameRate -s3 $i)
    fr2=$(calc -d "round($fr)")
    fr2=$(echo $fr2)
    # ts=$(ffprobe -v error -select_streams v:0 -show_entries stream=time_base -of default=noprint_wrappers=1:nokey=1 "$i")
    if [[ "$fr2" > "30" ]]; then
        cecho -y "${i} - framerate: " -r "${fr}"
        else if [[ "$fr2" < "30" ]]; then  
            cecho -y "${i} - framerate: " -w "${fr}"
        else 
            cecho -y "${i} - framerate: " -g "${fr}"
        fi
    fi
  done
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

check_timescale30() {
  cecho -c "Check timescale ----------"
  for i in *mp4; do
    ts=$(ffprobe -v error -select_streams v:0 -show_entries stream=time_base -of default=noprint_wrappers=1:nokey=1 "$i")
    if [[ "$ts" != "1/30000" ]]; then
        cecho -y "${i} - timescale: " -r "${ts}"
        nname="$(basename $i .mp4)___temp.mp4"
        mv "$i" "$nname"
        cecho -g "Convert $i:"
        # To avoid unintended side effects:
            # Use the -video_track_timescale option carefully with no re-encoding (-c:v copy), as it adjusts only the timescale.
            # If you’re re-encoding the video, ensure the frame rate (-r) is explicitly set to match the original or desired frame rate.
        ffmpeg -stats -loglevel error -i "$nname" -c:v copy -video_track_timescale 30000 "$i"
        rm "$nname"
    else
        cecho -y "${i} - timescale: " -g "${ts}"
    fi
  done
}


# add audio
check_audio() {
  cecho -c "Check Add audio ----------"
  for i in *mp4; do
    t=$(exiftool -n -T -AudioChannels -s3 $i)
    # t2=$(ffprobe -v error -select_streams a:0 -show_entries stream=time_base -of default=noprint_wrappers=1:nokey=1 "$i")
    if [[ "$t" == "-" ]]; then
        cecho -y "${i} - " -r "Add audio"
        bname="$(basename $i .mp4)"
        mv "$i" "${bname}___temp.mp4"
        # ffmpeg -stats -loglevel error  -i "${bname}___temp.mp4" -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=48000 -video_track_timescale 30000 -shortest -y "$i"
        ffmpeg -stats -loglevel error -i "${bname}___temp.mp4" -f lavfi -i aevalsrc=0 -ac 2 -shortest -y -c:v copy "${bname}___temp2.mp4"
        ffmpeg -stats -loglevel error -i "${bname}___temp2.mp4" -ar 48000 -c:v copy "$i" 
        echo .
        rm "${bname}___temp2.mp4" "${bname}___temp.mp4"
    else
        cecho -y "${i} - " -g "Ok"
    fi
  done
}

# remove audio add silence
rm_audio_mp4() {
    for i in *mp4; do 
        nname=$(basename "$i" .mp4)_old_mute.mp4
        mv "$i" "$nname"
        # ffmpeg -stats -loglevel error -i "$nname" -f lavfi -i anullsrc -c:v copy -c:a aac -map 1:a -map 0:v -shortest "$i"
        ffmpeg -stats -loglevel error -i "$nname" -f lavfi -i anullsrc -c:v copy -c:a aac -map 1:a -map 0:v -shortest -ar 48000 "$i"
    done
}



# convert mov to mp4
mov2mp4 () {
   replacespacesfilename
   for i in $(ls -1 |grep -iE "MOV$|mov$"); do
       echo --------------------------------
       cecho -y "Convert $i to mp4"
       filename="${i%.*}"
       ffmpeg -stats -loglevel error  -i "$i" -vcodec libx264 -c:a copy "${filename}.mp4"
       echo .
   done
}



jpg2mp4 () {
    # convert picture to video
    # $1 is video path
    # $2 how many seconds
    cecho -r "Arg1 is the image, arg2 is duration of the mp4, arg3 is T or F is you want to adapt it to 1920x1080"
    if [[ "$3" == "T" ]]; then
		mogrify -resize 1920x1080 -extent 1920x1080 -gravity Center -background black "$1"
	fi
    ffmpeg -stats -loglevel error -r "1/$2" -f image2 -i "$1" -vcodec libx264 -vf "fps=30,format=yuv420p" -y temp.mp4
    filename="${1%.*}"
    ffmpeg -stats -loglevel error -i temp.mp4 -f lavfi -i aevalsrc=0 -ac 2 -shortest -y -c:v copy "${filename}.mp4"
    rm temp.mp4
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

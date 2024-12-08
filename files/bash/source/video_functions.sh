#!/bin/sh

# source me in your script or .bashrc/.zshrc if wanna use cecho
# source '/path/to/cecho.sh'

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
    ls -1 |grep -E "*.ts$" | xargs rm
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

reducemp4 () {
    input=$1
    ffmpeg -stats -loglevel error  -i $input -vf "scale=720:-2" -preset slow -crf 30 -r 24 -acodec aac -y ${input%.*}_r720.mp4
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


checkcodec() {
  cecho -c "Check codec ----------"
  for i in *mp4; do
    # t=$(exiftool -n -T -CompressorName -s3 $i)
    t=$(ffprobe -v error -select_streams v:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 "$i")
    if [[ "$t" =~ "265" ]]; then
        nname="$(basename $i .mp4)___temp.mp4"
        mv "$i" "$nname"
        cecho -y "Convert codec $i:"
        ffmpeg -stats -loglevel error  -i "$nname" "$i"
        echo .
        rm "$nname"
        # cecho -r "${i} - ${t}"
    else 
        cecho -g "${i} - ${t}"
    fi
  done
}


checkstarttime() {
    cecho -c "respair ----------"
    for i in *mp4; do
        sumstarttime=$(ffprobe -v error -show_entries stream=start_time -of default=noprint_wrappers=1:nokey=1 "$i" | paste -sd+ | bc)
        cecho -y "${i} - sumestarttime: ${sumstarttime}"
        if (($(echo $sumstarttime '>' 0|bc))); then
            nname="$(basename $i .mp4)"
            mv "$i" "${nname}___temp.mp4"
            cecho -g "repair $i:"
            ffmpeg -stats -loglevel error -err_detect ignore_err -i "${nname}___temp.mp4" -c copy "$i"
            rm "${nname}___temp.mp4"
        fi
    done
}


checkaudiosamplerate() {
  cecho -c "Check Audio Sample Rate ----------"
  for i in *mp4; do
    t=$(exiftool -n -T -AudioSampleRate -s3 $i)
    # ts=$(ffprobe -v error -select_streams a:0 -show_entries stream=time_base -of default=noprint_wrappers=1:nokey=1 "$i")
    # cecho -y "${i} - AudioSampleRate: ${t} - timescale: ${ts}"
    cecho -y "${i} - AudioSampleRate: ${t}"
    if [[ "$t" != "48000" ]]; then
        nname="$(basename $i .mp4)"
        mv "$i" "${nname}___temp.mp4"
        cecho -g "Change audio sample rate to 48000 $i:"
        ffmpeg -stats -loglevel error -i "${nname}___temp.mp4" -vn -acodec copy "${nname}___temp.aac"
        ffmpeg -stats -loglevel error -i "${nname}___temp.aac" -ar 48000 "${nname}.aac"
        ffmpeg -stats -loglevel error -i "${nname}___temp.mp4" -i "${nname}.aac" -c:v copy -map 0:v:0 -map 1:a:0 "$i"
        # ffmpeg -stats -loglevel error  -i "$nname" -ar 48000 "$i"
        echo .
        rm "${nname}___temp.mp4" "${nname}___temp.aac" "${nname}.aac"
    fi
  done
}

checkresolution() {
  cecho -c "Check Resolution ----------"
  for i in *mp4; do
    t=$(exiftool -n -T -ImageWidth -s3 $i)
    cecho -y "${i} - ${t}"
    if [[ "$t" != "1920" ]]; then
      nname="$(basename $i .mp4)___temp.mp4"
      mv "$i" "$nname"
      cecho -g "Change resolution to 1920x1080 $i:"
      ffmpeg -stats -loglevel error  -i "$nname" -vf "scale=1920:-2" "$i"
      echo .
      rm "$nname"
    fi
  done
}

checkduration() {
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
  cecho -c "Check FPS ----------"
  for i in *mp4; do
    fr=$(exiftool -n -T -VideoFrameRate -s3 $i)
    fr=$(calc -d "round($fr)")
    fr=$(echo $fr)
    # ts=$(ffprobe -v error -select_streams v:0 -show_entries stream=time_base -of default=noprint_wrappers=1:nokey=1 "$i")
    cecho -y "${i} - framerate: ${fr}"
    if [[ "$fr" > "30" ]]; then
      nname="$(basename $i .mp4)___old_fr-$fr.mp4"
      mv "$i" "$nname"
      cecho -g "Convert $i:"
      ffmpeg -stats -loglevel error -i "$nname" -r 30 -video_track_timescale 30000 "$i"
      rm "$nname"
    fi
  done
}

checktimescale30() {
  cecho -c "Check timescale ----------"
  for i in *mp4; do
    ts=$(ffprobe -v error -select_streams v:0 -show_entries stream=time_base -of default=noprint_wrappers=1:nokey=1 "$i")
    cecho -y "${i} - timescale: ${ts}"
    if [[ "$ts" != "1/30000" ]]; then
      nname="$(basename $i .mp4)___temp.mp4"
      mv "$i" "$nname"
      cecho -g "Convert $i:"
      ffmpeg -stats -loglevel error -i "$nname" -video_track_timescale 30000 "$i"
      rm "$nname"
    fi
  done
}


# add audio
addaudio() {
  cecho -c "Check Add audio ----------"
  for i in *mp4; do
    cecho -y "${i}"
    t=$(exiftool -n -T -AudioChannels -s3 $i)
    # t2=$(ffprobe -v error -select_streams a:0 -show_entries stream=time_base -of default=noprint_wrappers=1:nokey=1 "$i")
    if [[ "$t" == "-" ]]; then
      bname="$(basename $i .mp4)"
      mv "$i" "${bname}___temp.mp4"
      cecho -g "Add audio $i:"
      # ffmpeg -stats -loglevel error  -i "${bname}___temp.mp4" -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=48000 -video_track_timescale 30000 -shortest -y "$i"
      ffmpeg -stats -loglevel error -i "${bname}___temp.mp4" -f lavfi -i aevalsrc=0 -ac 2 -shortest -y -c:v copy "${bname}___temp2.mp4"
      ffmpeg -stats -loglevel error -i "${bname}___temp2.mp4" -ar 48000 -c:v copy "$i" 
      echo .
      rm "${bname}___temp2.mp4" "${bname}___temp.mp4"
    fi
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
    cecho -r "Arg1 is the image, arg2 is duration of the mp4"
    mogrify -resize 1920x1080 -extent 1920x1080 -gravity Center -background black "$1"
    ffmpeg -stats -loglevel error -r "1/$2" -f image2 -i "$1" -vcodec libx264 -vf "fps=30,format=yuv420p" -y temp.mp4
    filename="${1%.*}"
    ffmpeg -stats -loglevel error -i temp.mp4 -f lavfi -i aevalsrc=0 -ac 2 -shortest -y -c:v copy "${filename}.mp4"
    rm temp.mp4
}








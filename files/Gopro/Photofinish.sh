#!/bin/bash

# setup

pixel=640


# source files

. /home/pi/Downloads/Software/cecho.sh


# Open gopro

curl --request GET   --url http://172.28.124.51:8080/gopro/camera/shutter/stop
curl --request GET --url http://172.28.124.51:8080/gopro/camera/control/wired_usb?p=0
curl --request GET --url http://172.28.124.51:8080/gopro/camera/control/wired_usb?p=1
curl --request GET --url http://172.28.124.51:8080/gopro/camera/control/wired_usb?p=0
curl --request GET --url http://172.28.124.51:8080/gopro/camera/control/wired_usb?p=1

# Start recording

timestamp1=$(date +%Y%m%d-%H%M%S)
datestamp1=$(date +%Y%m%d)
hourstamp1=$(date +%H-%M-%S)

curl --request GET   --url http://172.28.124.51:8080/gopro/camera/shutter/start

cecho -g "Recording --------"


while true; do
    cecho -b "Started at ${hourstamp1} " -w "--- Press Y to stop recording do not press ENter"
    curl --request GET  --url http://172.28.124.51:8080/gopro/camera/keep_alive
    # In the following line -t for timeout, -N for just 1 character
    read -t 5 -N 1 input
    if [[ $input = "Y" ]] || [[ $input = "Q" ]]; then
        # The following line is for the prompt to appear on a new line.
        break
    fi
done


curl --request GET   --url http://172.28.124.51:8080/gopro/camera/shutter/stop


timestamp2=$(date +%Y%m%d-%H%M%S)
datestamp2=$(date +%Y%m%d)
hourstamp2=$(date +%H-%M-%S)

battery=$(curl --request GET --url http://172.28.124.51:8080/gopro/camera/state | jq .status.\"70\")

cecho -r "Stopped at ${hourstamp2}"
cecho -g "Battery is ${battery} %"
cecho -y "Do you want to continue to record ? [Y/N]   "
read -t 100 -N 1 new


curl --request GET --url http://172.28.124.51:8080/gopro/camera/control/wired_usb?p=1


lastfile=$(curl --request GET   --url http://172.28.124.51:8080/gopro/media/list | jq ".media[].fs[].n" | tail -1 | perl -pe "s/\"//g")


nameoutmp4=$(echo ${datestamp1}____${hourstamp1}__-__${hourstamp2}____${lastfile})
nameoutpng=$(echo ${datestamp1}__${hourstamp1}_${hourstamp2}.png)

curl -o Video/$nameoutmp4 --request GET  --url http://172.28.124.51:8080/videos/DCIM/100GOPRO/${lastfile}

lastfile3=$(curl --request GET   --url http://172.28.124.51:8080/gopro/media/list | jq ".media[].fs[].n" | tail -3 | head -1 | perl -pe "s/\"//g")

curl --request GET --url http://172.28.124.51:8080/gopro/media/delete/file?path=100GOPRO/${lastfile3}


if [[ $new = "Y" ]] || [[ $new = "y" ]]; then
    bash Photofinish.sh
fi

curl --request GET --url http://172.28.124.51:8080/gopro/camera/control/wired_usb?p=0

#ffmpeg -stats -loglevel error -i $nameoutmp4 -vf "crop=2:1080:${pixel}:0" -start_number 1 -c:v pam -f image2pipe pipe:1 | convert - -crop 1x+0+0 +append $nameoutpng
exit












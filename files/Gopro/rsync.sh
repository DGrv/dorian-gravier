#!/bin/bash

source /mnt/c/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/bash/source/cecho.sh
cecho -g "Start rync every 10s"
echo

while sleep 10; do
	cecho -y "Sync ---------------------------------------------"
    # sshpass -p "raspberry" rsync -azP --delete -e ssh pi@192.168.178.67:~/Downloads/Gopro/ /mnt/c/Users/doria/Downloads/GOPRO/pi
    # sshpass -p "raspberry" rsync -azP -e ssh pi@192.168.1.219:~/Downloads/Gopro/ /mnt/c/Users/doria/Downloads/GOPRO/pi
    # sshpass -p "raspberry" rsync -azP -e "ssh -o StrictHostKeyChecking=no" pi@192.168.1.219:~/Downloads/Gopro/ /mnt/c/Users/doria/Downloads/GOPRO/pi
    # sshpass -p "raspberry" rsync -azP -e "ssh -o StrictHostKeyChecking=no" pi@192.168.178.67:~/Downloads/Gopro/ /mnt/c/Users/doria/Downloads/GOPRO/pi
    sshpass -p "raspberry" rsync -azP -e "ssh -o StrictHostKeyChecking=no" pi@20.20.20.219:~/Downloads/Gopro/ /mnt/c/Users/doria/Downloads/GOPRO/pi
	echo
done

--- 
title: "Install_optimzeVideo_in_WSL2" 
date: "2023-05-22 15:27" 
comments_id: 71
--- 

How to install [optimizeVideo](https://gitlab.com/es20490446e/optimizeVideo) in WSL2:

```sh
mkdir optimizeVideo
cd optimizeVideo/
curl -O https://gitlab.com/es20490446e/optimizeVideo.git
cd optimizeVideo/
./install-uninstall.sh 
sudo apt-get install libopus-dev libvpx-dev coreutils doxygen yasm ffmpeg
git clone https://gitlab.com/es20490446e/args
cd args
./install-uninstall.sh 
cd ..
git clone https://gitlab.com/es20490446e/solve.git
cd solve
./install-uninstall.sh 
cd ..
cd optimizeVideo/
./install-uninstall.sh 
sed -i 's/libvpx|opus//d' info/dependencies.txt
# remove the libvpx and opus dependencies in the info/dependencies.txt
sed -i -E "/libvpx|opus/d" ./info/dependencies.txt
./install-uninstall.sh 
```




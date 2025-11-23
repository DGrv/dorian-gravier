

mogrify -resize x120 *.png
mkdir flat
for i in *png; do convert $i -fill "#ff0000" -colorize 100 flat/$i ;done
mkdir level
for i in *png; do convert $i -channel RGB -auto-level +level-colors "#ff0000" level/$i ;done
mkdir rembg1_80 rembg2_80 rembg3_80
for i in *png; do convert $i -fill none -fuzz 80% -draw "color 0,0 floodfill" rembg1_80/$i ;done
for i in *png; do convert $i -fuzz 80% -transparent white rembg2_80/$i ;done
for i in *png; do convert $i -channel RGBA -fuzz 80% -fill none -opaque white rembg3_80/$i ;done
mkdir rembg1_50 rembg2_50 rembg3_50
for i in *png; do convert $i -fill none -fuzz 50% -draw "color 0,0 floodfill" rembg1_50/$i ;done
for i in *png; do convert $i -fuzz 50% -transparent white rembg2_50/$i ;done
for i in *png; do convert $i -channel RGBA -fuzz 50% -fill none -opaque white rembg3_50/$i ;done
mkdir rembg1_25 rembg2_25 rembg3_25
for i in *png; do convert $i -fill none -fuzz 25% -draw "color 0,0 floodfill" rembg1_25/$i ;done
for i in *png; do convert $i -fuzz 25% -transparent white rembg2_25/$i ;done
for i in *png; do convert $i -channel RGBA -fuzz 25% -fill none -opaque white rembg3_25/$i ;done


# create a file to execute to create tsv :
# be sure that is in unix format to execute : dos2unix make_tsv.sh
# clip.exe is copy in the clipboard with wsl
./make_tsv.sh 15 flat level | clip.exe
./make_tsv.sh 15 rembg1_80 rembg2_80 rembg3_80 | clip.exe
./make_tsv.sh 15 rembg1_50 rembg2_50 rembg3_50 | clip.exe
./make_tsv.sh 15 rembg1_25 rembg2_25 rembg3_25 | clip.exe

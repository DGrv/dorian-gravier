--- 
layout: "post" 
title: "Create overlay text with ffmpeg moving in and out" 
date: "2022-12-30 17:38" 
comments_id: 61
--- 
 
 
# Add static overlay text

I could make appear and disappear easily text for my videos with a box around :

```sh
ffmpeg -stats -loglevel error -i in.mp4 -vf "drawtext=text='add overlay where you want': fontcolor=white: fontfile='Arial': fontsize=50: box=1: boxcolor=Black@0.5:boxborderw=10: x=w*0.05: y=h*0.05: enable='between(t,1,4)'" -vcodec libx264 -x264-params keyint=24:scenecut=0 -c:a copy -y normal.mp4
```

Here an example with a white background:

![](/files/posts/2022/normal_fps15_r500.gif#center)


- `w` is the width of the video, `x=w*%xpos%` is `x=w*0.05` so the position will be at pixel 96 if `w` is 1920 (1920/5=96) 
- `h` is the height of the video (same calculation here)
- `between(t,1,4)` means between second 1 to 4
- you can also use to add what is in a textfile, which is easier with multiples lines (unfortunately difficult to center really), replace `text='add overlay where you want'` with `textfile=yourtext.txt`

The position of the text with be taken on the top left corner of the text.
Meaning that you can place it anywhere you wish since you can also know the width and height of your text with `tw` and `th`.

For example you can place this text in:

- top left corner:      `x =w*0.05: y=h*0.05`
- top center:           `x=((w-tw)/2): y=h*0.05 `
- top right corner:     `x=w*0.95-tw: y=h*0.05 `
- center left:          `x=w*0.05: y=h*0.5 `
- center:               `x=((w-tw)/2): y=h*0.5 `
- center right:         `x=w*0.95-tw: y=h*0.5 `
- bottom left corner:   `x=w*0.05: y=h*0.90 `
- bottom center:        `x=((w-tw)/2): y=h*0.90 `
- bottom right corner:  `x=w*0.95-tw: y=h*0.90 `

# Add moving overlay text

You can however add moving text. Using `t` (time in second) and the function `if`, `gte` (greater) or `lt` (less).

Here an example:

```sh 
set time1=2
set time2=7
set timeuser=2,10
set posstay=3
set xpos=0.05
set ypos=0.05
ffmpeg -stats -loglevel error -i input.mp4 -vf "drawtext=text='youhou': fontcolor=white: fontfile='Arial': fontsize=50: box=1: boxcolor=Black@0.5:boxborderw=10: x=if(gte(t\,%time1%+%posstay%)\, w*%xpos%-w/10*(t-%time1%-%posstay%)\,if(gte(-w*0.2-tw+w/10*t\,w*%xpos%)\, w*%xpos%\, -w*0.2-tw+w/10*t)): y=h*%ypos%: enable='between(t,%timeuser%)'" -y test.mp4

```

![](/files/posts/2022/test_fps24_r500.gif#center)

Some explanations for the easiest corner, the top left corner: 
`x=if( gte( t, 2+3 ), w * 0.05 - w / 10 * (t - 2 - 3 ), if( gte( -w * 0.2 - tw + w / 10 * t, w * 0.05), w * 0.05, -w * 0.2 - tw + w / 10 * t ) ) : y=h*0.05`

- You may need 1 `\` to escape a `,` in the code
- here y does not change, only x change so `y=h*0.05`
- `gte( t, 2+3 )` means if `t` (in second) is more than 5, (2 is actually the start of the overlay `between(t,2,7)`), 3 is that I decided that the overlay will not move during 3 seconds
	- if yes
		- `w * 0.05 - w / 10 * (t - 2 - 3 )` 
			- `w * 0.05` 5% if the width so pixel 96, the start position of the movement (the *end position* below)
			- ` - w / 10 * (t - 2 - 3 )` minus 10% of the width pixel (192) per second (this is when the overlay returns out of the frame) that's why we use `* (t - 2 - 3 )`
	- if no
		- `gte( -w * 0.2 - tw + w / 10 * t, w * 0.05), w * 0.05, -w * 0.2 - tw + w / 10 * t ) )`
		- `w * 0.05` this is the *end position*
		- `-w * 0.2 - tw + w / 10 * t` this is the first movement
		- so if the overlay did not reach the end position, do the movement
		- and the movement is the same as before but we start outside the frame meaning minus something here minus 20% of the width minus the width of the text  `-w * 0.2 - tw`

You can test of all this with the code below AND you can find a batch file that will ask you the path of your video, the time wanted, the position and the fontsize, making you all in 1 shot what you need ---> [HERE](/files/Batch/FFmpeg/FFMPEG_Add_text_overlay_v03.bat)

The documentation for `drawtext` from ffmpeg is really good, you can find it [here](https://ffmpeg.org/ffmpeg-all.html#drawtext-1)


# Batch code to test it

```sh
@echo off

ffmpeg -stats -loglevel error -f lavfi -i color=c=white:s=1920x1080:d=8 -video_track_timescale 24000 -y input.mp4

ffmpeg -stats -loglevel error -i input.mp4 -vf "drawtext=text='add overlay where you want': fontcolor=white: fontfile='Arial': fontsize=50: box=1: boxcolor=Black@0.5:boxborderw=10: x=w*0.05:y=h*0.05:enable='between(t,1,4)'" -vcodec libx264 -x264-params keyint=24:scenecut=0 -c:a copy -y normal.mp4

set time1=2
set time2=7
set timeuser=2,10
set posstay=3

:: - top left corner:    
set xpos=0.05
set ypos=0.05
ffmpeg -stats -loglevel error -i input.mp4 -vf "drawtext=text='youhou': fontcolor=white: fontfile='Arial': fontsize=50: box=1: boxcolor=Black@0.5:boxborderw=10: x=if(gte(t\,%time1%+%posstay%)\, w*%xpos%-w/10*(t-%time1%-%posstay%)\,if(gte(-w*0.2-tw+w/10*t\,w*%xpos%)\, w*%xpos%\, -w*0.2-tw+w/10*t)): y=h*%ypos%: enable='between(t,%timeuser%)'" -y test.mp4
del test1.mp4
rename test.mp4 test1.mp4

:: - top center:         
set xpos=0.5
set ypos=0.05
ffmpeg -stats -loglevel error -i test1.mp4 -vf "drawtext=text='youhou': fontcolor=white: fontfile='Arial': fontsize=50: box=1: boxcolor=Black@0.5:boxborderw=10: y=if(gte(t\,%time1%+%posstay%)\, h*%ypos%-h/10*(t-%time1%-%posstay%)\,if(gte(-h*0.2-th+h/10*t\,h*%ypos%)\, h*%ypos%\, -h*0.2-th+h/10*t)): x=w*%xpos%: enable='between(t,%timeuser%)'" -y test.mp4
del test1.mp4
rename test.mp4 test1.mp4

:: - top right corner:   
set xpos=0.95
set ypos=0.05
ffmpeg -stats -loglevel error -i test1.mp4 -vf "drawtext=text='youhou': fontcolor=white: fontfile='Arial': fontsize=50: box=1: boxcolor=Black@0.5:boxborderw=5: x=if(gte(t\,%time1%+%posstay%)\, w*%xpos%-tw+w/10*(t-%time1%-%posstay%)\,if(lt(w+w*0.2-w/10*t\,w*%xpos%-tw)\, w*%xpos%-tw\, w+w*0.2-w/10*t)): y=h*%ypos%: enable='between(t,2,20)'" -y test.mp4
del test1.mp4
rename test.mp4 test1.mp4

:: - center left:        
set xpos=0.05
set ypos=0.5
ffmpeg -stats -loglevel error -i test1.mp4 -vf "drawtext=text='youhou': fontcolor=white: fontfile='Arial': fontsize=50: box=1: boxcolor=Black@0.5:boxborderw=10: x=if(gte(t\,%time1%+%posstay%)\, w*%xpos%-w/10*(t-%time1%-%posstay%)\,if(gte(-w*0.2-tw+w/10*t\,w*%xpos%)\, w*%xpos%\, -w*0.2-tw+w/10*t)): y=h*%ypos%: enable='between(t,%timeuser%)'" -y test.mp4
del test1.mp4
rename test.mp4 test1.mp4

:: - center right:       
set xpos=0.5
set ypos=0.5
set xpos=0.95
set ypos=0.5
ffmpeg -stats -loglevel error -i test1.mp4 -vf "drawtext=text='youhou': fontcolor=white: fontfile='Arial': fontsize=50: box=1: boxcolor=Black@0.5:boxborderw=5: x=if(gte(t\,%time1%+%posstay%)\, w*%xpos%-tw+w/10*(t-%time1%-%posstay%)\,if(lt(w+w*0.2-w/10*t\,w*%xpos%-tw)\, w*%xpos%-tw\, w+w*0.2-w/10*t)): y=h*%ypos%: enable='between(t,2,20)'" -y test.mp4
del test1.mp4
rename test.mp4 test1.mp4

:: - bottom left corner: 
set xpos=0.05
set ypos=0.90
ffmpeg -stats -loglevel error -i test1.mp4 -vf "drawtext=text='youhou': fontcolor=white: fontfile='Arial': fontsize=50: box=1: boxcolor=Black@0.5:boxborderw=10: x=if(gte(t\,%time1%+%posstay%)\, w*%xpos%-w/10*(t-%time1%-%posstay%)\,if(gte(-w*0.2-tw+w/10*t\,w*%xpos%)\, w*%xpos%\, -w*0.2-tw+w/10*t)): y=h*%ypos%: enable='between(t,%timeuser%)'" -y test.mp4
del test1.mp4
rename test.mp4 test1.mp4

:: - bottom center:      
set xpos=0.5
set ypos=0.9
ffmpeg -stats -loglevel error -i test1.mp4 -vf "drawtext=text='youhou': fontcolor=white: fontfile='Arial': fontsize=50: box=1: boxcolor=Black@0.5:boxborderw=10: y=if(gte(t\,%time1%+%posstay%)\, h*%ypos%+h/10*(t-%time1%-%posstay%)\,if(lt(h+h*0.2-h/10*t\,h*%ypos%)\, h*%ypos%\, h+h*0.2-h/10*t)): x=w*%xpos%: enable='between(t,%timeuser%)'" -y test.mp4
del test1.mp4
rename test.mp4 test1.mp4

:: - bottom right corner:
set xpos=0.95
set ypos=0.90
ffmpeg -stats -loglevel error -i test1.mp4 -vf "drawtext=text='youhou': fontcolor=white: fontfile='Arial': fontsize=50: box=1: boxcolor=Black@0.5:boxborderw=5: x=if(gte(t\,%time1%+%posstay%)\, w*%xpos%-tw+w/10*(t-%time1%-%posstay%)\,if(lt(w+w*0.2-w/10*t\,w*%xpos%-tw)\, w*%xpos%-tw\, w+w*0.2-w/10*t)): y=h*%ypos%: enable='between(t,2,20)'" -y test.mp4
del test1.mp4


```




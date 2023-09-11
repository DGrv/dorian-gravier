--- 
title: "Real time animation with krita" 
date: "2022-12-26 18:50" 
comments_id: 58
--- 
 
I wanted to create an animation with krita which is pretty easy AND add some real time animation where I am drawing.
I did not find a way to do it with krita even if it can do a timelaps but with a delay of 1s minimum.

I divided this in 3 little pieces:

- Animation 1 with `transform Mask` from krita
- a real time drawing
- Animation 3 with `transform Mask` from krita

I used for this several tools:

- [Losslesscut](https://mifi.github.io/lossless-cut/)
- [Krita](https://krita.org/)
- [FFMpeg](https://ffmpeg.org/) with several batch script
	- For those later ones you can also just check the code to use what you need :)
	- [Screencapture](/files/Batch/FFmpeg/FFmpeg_ScreenCapture-Audio_v06.bat)
	- [add key frames to cut correctly with Losslesscut](/files/Batch/FFmpeg/FFmpeg_Add_keyframe_v01.bat)
	- [change the speed of the video](/files/Batch/FFmpeg/FFMPEG_SpeedUp_v04.bat)
	- [bind the video](/files/Batch/FFmpeg/FFMPEG_Bind_All_inFolder_v01.bat)

Here are the steps with examples:

- prepare you animation
	- ![](/files/posts/2022/Ko-fi_v01.gif)
- increase the keyframes with [FFmpeg_Add_keyframe_v01.bat](/files/Batch/FFmpeg/FFmpeg_Add_keyframe_v01.bat)
- cut the first part you want as *Animation 1* with [Losslesscut](https://mifi.github.io/lossless-cut/)
- copy the middle frame that you will use and import it in a new document in Krita
	- ![](/files/posts/2022/Ko-fi_v01_middle_frame.png)
- start recording with [FFmpeg_ScreenCapture-Audio_v06.bat](/files/Batch/FFmpeg/FFmpeg_ScreenCapture-Audio_v06.bat)
- in krita open the canvas only via <kbd>Tab</kbd>
	- type <kbd>3</kbd> to have it extended to the screen
	- move it with <kbd>Space</kbd> a bit up until to have the bottom part fitting to the bottom screen
	- start drawing
- stop the screen capture with <kbd>Ctrl</kbd> + <kbd>c</kbd>
- increase keyframe of the output
- cut the output how you need
- increase the output speed if needed with [FFMPEG_SpeedUp_v04.bat](/files/Batch/FFmpeg/FFMPEG_SpeedUp_v04.bat)
	- ![](/files/posts/2022/k02_r500_fps24_r500.gif)
	- **BIG problem you can see the tabs at the top** so create a png from the same size with a black banner at the top or whatever you need as back ground
	- overlay the output above with your png via `ffmpeg -stats -loglevel error -i "input.mp4" -i "input.png"  -filter_complex "[0:v][1:v]overlay" -y -c:a copy "output.mp4"`
		- ![](/files/posts/2022/k02n_f2_fps24_r500.gif)
- copy paste the drawn layer in krita in the middle of the animation
	- ![](/files/posts/2022/Ko-fi_v01_draw_2.png)
- render the animation, cut it and so on to get *Animation 2*
- bind all to get the final animation
	- Animation 1
		- ![](/files/posts/2022/k01_fps24_r500.gif)
	- your drawing 
		- ![](/files/posts/2022/k02n_f2_fps24_r500.gif)
	- Animation 2
		- ![](/files/posts/2022/k04_fps24_r500.gif)
		
Final result:


![](/files/posts/2022/Ko-fi_fps24_r500.gif)



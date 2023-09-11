--- 
title: "Cut_video_with_ffmeg_based_on_frames_instead_of_time" 
date: "2023-09-05 15:25" 
comments_id: 74
--- 

I am not so satisfy about how ffmpeg is handling cutting video because usually you have duplicated frames if you recombined the cut segments.

I tried to cut the video using frames and not time and found a good solution that I integrated in a lua script for [mpv](https://mpv.io/).

I usually use [losslesscut](https://mifi.no/losslesscut/) and would like to have this option in future in this incredible tool so I created a [discussion about this.](https://github.com/mifi/lossless-cut/discussions/1702)

The [lua script](https://github.com/DGrv/dorian.gravier.github.io/blob/master/files/Lua/cut_v04.lua) is cutting your video at the time you press the `a` keyboard touch, creating a seg1 and seg2 mp4 files.



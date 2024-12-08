--- 
title: "fix_cut_video" 
date: "2024-12-07 23:10" 
comments_id: --------------------- 
classes: wide
--- 

# Context

A recurring issue that I encountered along with other people with the marvellous tool [Losslesscut](https://github.com/mifi/lossless-cut) is that if you split a video in segments on keyframes (let's forget about not on keyframes) and that you concat them again afterwards, you usally have duplicate frames making the output video unfluid.


One solution was to not split at the keyframe for *END* of segment1 and to shift further to 2 or more frame *START* of segment 2. This was my way of doing for a long time.
However this is not always working.

The developer from [Losslesscut](https://github.com/mifi/lossless-cut) is highly involved trying to fix this problem since a long time ([#1216](https://github.com/mifi/lossless-cut/issues/1216), [#717](https://github.com/mifi/lossless-cut/issues/717), ... )

# Solution

I tried to find a solution in the past and was on a good track but did not go further ([#1216](https://github.com/mifi/lossless-cut/issues/1216)).

I built a bash script that is checking the duplicate frames in the consecutive segments and remove them without reencoing the videos. 
You will find a reproducible example with videos below.
How it functions:

- cut your segment with losslesscut, you can use the _split_ option *ON KEYFRAMES* for this (shortcut <btn>b</btn>). To navigate on keyframes use <btn>Alt</btn>+<btn>Left or Right</btn>
- run the function _rmdf_ (remove duplicate frames) and works as follow (let's image we have 3 segments: seg1, seg2, seg3):
	- seg1 vs seg2
		- get the frames' md5 of both segments
		- remove the headers of the md5
		- keep only the md5 from the video, remove the audio
		- find the common frames' md5 between seg1/seg2
		- get the first common frame and check where it is in the first segment (seg1)
		- cut seg1 from start to 1 frame before this one (without reencoding)
	- seg2 vs seg3
		- ...
- concat them again with 2 different [ffmpeg method](https://trac.ffmpeg.org/wiki/Concatenate)
	- the concat demuxer 
	- the concat protocol

Actually nothing crazy but works good on my videos (Gopro 11, 1920x1080, mainly 30fps).

# Reproducible example

## Files

[All reproducible code present here](https://dgrv.github.io/dorian-gravier/assets/images/posts/2024/rmcdufr_cut_concat_example)

	├───example.sh              ---> code to run
	├───functions.sh            ---> sourced code with functions
	├───cecho.sh                ---> sourced code with functions
	├───original                ---> original video
	│   ├───b                   ---> segments cut with split option   <────────────────────┐   
	│   └───sc                  ---> segments cut wth smart cut and split option <─────────────┐
	└───output                  ---> output videos                                         │   │
		├───protocol_b.mp4      ---> concat protocol──────┬────────────────────────────────┘   │
		├───demuxer_b.mp4       ---> concat demuxer ──────┘                                    │
		├───protocol_sc.mp4     ---> concat protocol──────┬────────────────────────────────────┘
		├───demuxer_sc.mp4      ---> concat demuxer ──────┘
		├───protocol_bfix.mp4   ---> concat protocol > b folder but with the _rmdf_ function 
		├───demuxer_bfix.mp4    ---> concat demuxer  > b folder but with the _rmdf_ function 
		└───matrix.mp4          ---> output video in a matrix format but unfortunately is not 
		                             fluid enough and single video are better


## Output and conclusion

Here the example of 3 segments splitted with the _split_ option.

![](https://dgrv.github.io/dorian-gravier/assets/images/posts/2024/rmcdufr_cut_concat_example/20241207-225852__LosslessCut.png)

And the 6 different videos: 2 (ffmpeg method) x 3 ( test folder: b, sc and bfix)

<video width="326" height="248" controls loop="" muted = "" autoplay="">
	<source src="https://dgrv.github.io/dorian-gravier/assets/images/posts/2024/rmcdufr_cut_concat_example/output/protocol_b.mp4">
</video>
<video width="326" height="248" controls loop="" muted = "" autoplay="">
	<source src="https://dgrv.github.io/dorian-gravier/assets/images/posts/2024/rmcdufr_cut_concat_example/output/demuxer_b.mp4">
</video>
<video width="326" height="248" controls loop="" muted = "" autoplay="">
	<source src="https://dgrv.github.io/dorian-gravier/assets/images/posts/2024/rmcdufr_cut_concat_example/output/protocol_sc.mp4">
</video>
<video width="326" height="248" controls loop="" muted = "" autoplay="">
	<source src="https://dgrv.github.io/dorian-gravier/assets/images/posts/2024/rmcdufr_cut_concat_example/output/demuxer_sc.mp4">
</video>
<video width="326" height="248" controls loop="" muted = "" autoplay="">
	<source src="https://dgrv.github.io/dorian-gravier/assets/images/posts/2024/rmcdufr_cut_concat_example/output/protocol_bfix.mp4">
</video>
<video width="326" height="248" controls loop="" muted = "" autoplay="">
	<source src="https://dgrv.github.io/dorian-gravier/assets/images/posts/2024/rmcdufr_cut_concat_example/output/demuxer_bfix.mp4">
</video>

So first things to say: demuxer and protocol methods give different results... protocol method is the way to go.




And the matrix, as you see the concat_bfix is not fluid in this matrix in comparison to single video.

<video width="326" height="248" controls loop="" muted = "" autoplay="">
	<source src="https://dgrv.github.io/dorian-gravier/assets/images/posts/2024/rmcdufr_cut_concat_example/output/matrix.mp4">
</video>


**Create issue with:**
cd C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io
gh issue create --title "[Comment] fix_cut_video" --body "" --label Comments



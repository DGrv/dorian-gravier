---
title: "How to normalize audio easily from a video via ffmpeg and ffmpeg-normalize"
date: "2021-01-12 09:00"
comments_id: 43
---

I was actually looking to normalize the audio from a video and realized that this is not so easy.
By going through internet I found a pretty nice solution : [ffmpeg-normalize](https://github.com/slhck/ffmpeg-normalize).

By quoting his github, *This program normalizes media files to a certain loudness level using the EBU R128 loudness normalization procedure.*

This is working perfectly and pretty happy from the result.
You will need python and install the script via pip (take care of the message from it, you will need to have the script path to your PATH on windows to be able to run the cmd `ffmpeg-normalize`)

Example in my case:

```shell
ffmpeg-normalize input.mp4  -c:a aac -b:a 192k -o output.mp4
```

__*Source:*__

- (https://superuser.com/questions/323119/how-can-i-normalize-audio-using-ffmpeg)
- (https://github.com/slhck/ffmpeg-normalize)

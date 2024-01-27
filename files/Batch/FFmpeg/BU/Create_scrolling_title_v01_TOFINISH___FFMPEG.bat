::Source : https://gist.github.com/stekern/de26bee637a37cd20ec61c0dfbb9a5eb
:: and modified Dorian



:: Creates a 20-second video with a scrolling text overlay.
:: The image is named 'input.png', and the textfile it reads from is called 'yourfile.txt'.
:: 
:: Create a video of the image
REM ffmpeg -loop 1 -t 20 -i input.png output.mp4
ffmpeg -stats -loglevel error  -f lavfi -i color=c=black:s=2704x1520:d=20 -video_track_timescale 30000 output.mp4

:: Add scrolling text to the video
ffmpeg -i output.mp4 -filter_complex "[0]split[txt][orig];[txt]drawtext=fontfile=tahoma.ttf:fontsize=55:fontcolor=white:x=(w-text_w)/2+20:y=h-20*t:textfile='yourfile.txt':bordercolor=black:line_spacing=20:borderw=3[txt];[orig]crop=iw:50:0:0[orig];[txt][orig]overlay" -c:v libx265 -y -preset ultrafast -t 20 output_scrolling.mp4


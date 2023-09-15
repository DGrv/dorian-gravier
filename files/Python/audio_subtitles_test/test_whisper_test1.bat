@ echo off
REM ffmpeg -i test.mp4 -vf subtitles=test.srt -y test_srt.mp4
REM ffplay -vf "crop=1024:100:0:500" test_srt.mp4
REM ffmpeg -i test_srt.mp4 -vf "crop=1024:100:0:500" -c:v libx264 -c:a copy -y test_srt_cut.mp4
REM ffmpeg -stats -loglevel error -i test_srt_cut.mp4 -vf "drawtext=text='1': fontcolor=white: fontfile='Arial': fontsize=50: box=1: boxcolor=Black@0.5:boxborderw=10: x=0.05*w: y=0.5*h: enable='between(t,0,500)'" -y test_srt_cut_n.mp4
REM ffmpeg -i input0.mp4 -i input1.mp4 -filter_complex hstack=inputs=2 horizontal-stacked-output.mp4


REM ffmpeg -f lavfi -i color=c=black:s=1024x576:r=5 -i test.mp3 -crf 0 -c:a copy -shortest test_black.mp4

ffmpeg -stats -loglevel error -i test_black.mp4 -vf subtitles=test01.srt -y test01_srt.mp4
ffmpeg -stats -loglevel error -i test_black.mp4 -vf subtitles=test02.srt -y test02_srt.mp4
ffmpeg -stats -loglevel error -i test_black.mp4 -vf subtitles=test03.srt -y test03_srt.mp4
ffmpeg -stats -loglevel error -i test_black.mp4 -vf subtitles=test04.srt -y test04_srt.mp4
ffmpeg -stats -loglevel error -i test_black.mp4 -vf subtitles=test05.srt -y test05_srt.mp4
ffmpeg -stats -loglevel error -i test_black.mp4 -vf subtitles=test06.srt -y test06_srt.mp4
ffmpeg -stats -loglevel error -i test_black.mp4 -vf subtitles=test07.srt -y test07_srt.mp4
ffmpeg -stats -loglevel error -i test_black.mp4 -vf subtitles=test08.srt -y test08_srt.mp4
ffmpeg -stats -loglevel error -i test_black.mp4 -vf subtitles=test09.srt -y test09_srt.mp4
ffmpeg -stats -loglevel error -i test_black.mp4 -vf subtitles=test10.srt -y test10_srt.mp4

ffmpeg -stats -loglevel error -i test01_srt.mp4 -vf "crop=1024:100:0:500" -c:v libx264 -c:a copy -y test01_srt_cut.mp4
ffmpeg -stats -loglevel error -i test02_srt.mp4 -vf "crop=1024:100:0:500" -c:v libx264 -c:a copy -y test02_srt_cut.mp4
ffmpeg -stats -loglevel error -i test03_srt.mp4 -vf "crop=1024:100:0:500" -c:v libx264 -c:a copy -y test03_srt_cut.mp4
ffmpeg -stats -loglevel error -i test04_srt.mp4 -vf "crop=1024:100:0:500" -c:v libx264 -c:a copy -y test04_srt_cut.mp4
ffmpeg -stats -loglevel error -i test05_srt.mp4 -vf "crop=1024:100:0:500" -c:v libx264 -c:a copy -y test05_srt_cut.mp4
ffmpeg -stats -loglevel error -i test06_srt.mp4 -vf "crop=1024:100:0:500" -c:v libx264 -c:a copy -y test06_srt_cut.mp4
ffmpeg -stats -loglevel error -i test07_srt.mp4 -vf "crop=1024:100:0:500" -c:v libx264 -c:a copy -y test07_srt_cut.mp4
ffmpeg -stats -loglevel error -i test08_srt.mp4 -vf "crop=1024:100:0:500" -c:v libx264 -c:a copy -y test08_srt_cut.mp4
ffmpeg -stats -loglevel error -i test09_srt.mp4 -vf "crop=1024:100:0:500" -c:v libx264 -c:a copy -y test09_srt_cut.mp4
ffmpeg -stats -loglevel error -i test10_srt.mp4 -vf "crop=1024:100:0:500" -c:v libx264 -c:a copy -y test10_srt_cut.mp4

ffmpeg -stats -loglevel error -i test01_srt_cut.mp4 -vf "drawtext=text='01': fontcolor=white: fontfile='Arial': fontsize=15: box=1: boxcolor=Black@0.5:boxborderw=10: x=0.05*w: y=0.5*h: enable='between(t,0,500)'" -y test01_srt_cut_n.mp4
ffmpeg -stats -loglevel error -i test02_srt_cut.mp4 -vf "drawtext=text='02': fontcolor=white: fontfile='Arial': fontsize=15: box=1: boxcolor=Black@0.5:boxborderw=10: x=0.05*w: y=0.5*h: enable='between(t,0,500)'" -y test02_srt_cut_n.mp4
ffmpeg -stats -loglevel error -i test03_srt_cut.mp4 -vf "drawtext=text='03': fontcolor=white: fontfile='Arial': fontsize=15: box=1: boxcolor=Black@0.5:boxborderw=10: x=0.05*w: y=0.5*h: enable='between(t,0,500)'" -y test03_srt_cut_n.mp4
ffmpeg -stats -loglevel error -i test04_srt_cut.mp4 -vf "drawtext=text='04': fontcolor=white: fontfile='Arial': fontsize=15: box=1: boxcolor=Black@0.5:boxborderw=10: x=0.05*w: y=0.5*h: enable='between(t,0,500)'" -y test04_srt_cut_n.mp4
ffmpeg -stats -loglevel error -i test05_srt_cut.mp4 -vf "drawtext=text='05': fontcolor=white: fontfile='Arial': fontsize=15: box=1: boxcolor=Black@0.5:boxborderw=10: x=0.05*w: y=0.5*h: enable='between(t,0,500)'" -y test05_srt_cut_n.mp4
ffmpeg -stats -loglevel error -i test06_srt_cut.mp4 -vf "drawtext=text='06': fontcolor=white: fontfile='Arial': fontsize=15: box=1: boxcolor=Black@0.5:boxborderw=10: x=0.05*w: y=0.5*h: enable='between(t,0,500)'" -y test06_srt_cut_n.mp4
ffmpeg -stats -loglevel error -i test07_srt_cut.mp4 -vf "drawtext=text='07': fontcolor=white: fontfile='Arial': fontsize=15: box=1: boxcolor=Black@0.5:boxborderw=10: x=0.05*w: y=0.5*h: enable='between(t,0,500)'" -y test07_srt_cut_n.mp4
ffmpeg -stats -loglevel error -i test08_srt_cut.mp4 -vf "drawtext=text='08': fontcolor=white: fontfile='Arial': fontsize=15: box=1: boxcolor=Black@0.5:boxborderw=10: x=0.05*w: y=0.5*h: enable='between(t,0,500)'" -y test08_srt_cut_n.mp4
ffmpeg -stats -loglevel error -i test09_srt_cut.mp4 -vf "drawtext=text='09': fontcolor=white: fontfile='Arial': fontsize=15: box=1: boxcolor=Black@0.5:boxborderw=10: x=0.05*w: y=0.5*h: enable='between(t,0,500)'" -y test09_srt_cut_n.mp4
ffmpeg -stats -loglevel error -i test10_srt_cut.mp4 -vf "drawtext=text='10': fontcolor=white: fontfile='Arial': fontsize=15: box=1: boxcolor=Black@0.5:boxborderw=10: x=0.05*w: y=0.5*h: enable='between(t,0,500)'" -y test10_srt_cut_n.mp4

ffmpeg -stats -loglevel error ^
-i test01_srt_cut_n.mp4 ^
-i test02_srt_cut_n.mp4 ^
-i test03_srt_cut_n.mp4 ^
-i test04_srt_cut_n.mp4 ^
-i test05_srt_cut_n.mp4 ^
-i test06_srt_cut_n.mp4 ^
-i test07_srt_cut_n.mp4 ^
-i test08_srt_cut_n.mp4 ^
-i test09_srt_cut_n.mp4 ^
-i test10_srt_cut_n.mp4 ^
-filter_complex vstack=inputs=10 -y all.mp4


rm test01_srt.mp4 test01_srt_cut.mp4 test01_srt_cut_n.mp4
rm test02_srt.mp4 test02_srt_cut.mp4 test02_srt_cut_n.mp4
rm test03_srt.mp4 test03_srt_cut.mp4 test03_srt_cut_n.mp4
rm test04_srt.mp4 test04_srt_cut.mp4 test04_srt_cut_n.mp4
rm test05_srt.mp4 test05_srt_cut.mp4 test05_srt_cut_n.mp4
rm test06_srt.mp4 test06_srt_cut.mp4 test06_srt_cut_n.mp4
rm test07_srt.mp4 test07_srt_cut.mp4 test07_srt_cut_n.mp4
rm test08_srt.mp4 test08_srt_cut.mp4 test08_srt_cut_n.mp4
rm test09_srt.mp4 test09_srt_cut.mp4 test09_srt_cut_n.mp4
rm test10_srt.mp4 test10_srt_cut.mp4 test10_srt_cut_n.mp4

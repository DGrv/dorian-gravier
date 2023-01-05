--- 
layout: "post" 
title: "Test your parameters (different option) from whisper (openai) and stable-ts" 
date: "2023-01-03 17:26" 
comments_id: 65 
--- 

Here an example on how to test several option from `whisper` and `stable-ts` and compare them easily.
Here an audio file:

https://github.com/DGrv/dorian.gravier.github.io/files/posts/2023/test-whisper.mp3


I am using right now:

- [whisper](https://github.com/openai/whisper)
- with [stable-ts](https://github.com/jianfch/stable-ts)
- running a [python script I wrote here](/files/Python/whisper_stable-ts_dorian.py)

To test the different option I used this python script:

- my audio input is here `test.mp3` (check code)
- each line of `args2` is a set of option to try
- it will create a srt per set of option from `testN.srt` with `N` from 0 to the length of `args2`
- it will also save the object `result` for each set of option in case I need it

```py
import whisper 
from stable_whisper import modify_model
from stable_whisper import results_to_sentence_srt
from stable_whisper import results_to_word_srt
import pickle

model1 = whisper.load_model('medium')
# normal whisper
# result1 = model.transcribe('test.mp4', language='fr', max_initial_timestamp=None)
modify_model(model1)

args1 = {'audio':'test.mp3', 'language':'fr', 'pbar':True}
args2 = [
{'suppress_silence':True, 'ts_num':40, 'lower_quantile':0.2, 'lower_threshold':0.3},
{'suppress_silence':True, 'ts_num':40, 'lower_threshold':0.5, 'no_speech_threshold':0.1},
{'suppress_silence':True, 'ts_num':40, 'lower_threshold':0.7, 'no_speech_threshold':0.1},
{'suppress_silence':True, 'ts_num':40, 'lower_threshold':0.9, 'no_speech_threshold':0.3},
{'suppress_silence':True, 'ts_num':40, 'lower_threshold':0.5, 'no_speech_threshold':0.6},
{'suppress_silence':True, 'ts_num':40, 'lower_threshold':0.5, 'no_speech_threshold':0.5},
{'suppress_silence':True, 'ts_num':40, 'lower_threshold':0.7, 'no_speech_threshold':0.5},
{'suppress_silence':True, 'ts_num':40, 'lower_threshold':0.9, 'no_speech_threshold':0.5},
]

for i in range(0,len(args2)):
    print('Doing number '+str(i))
    result = model1.transcribe(**args1, **args2[i])
    # Its important to use binary mode
    dbfile = open('pickle'+str(i), 'ab')
    # source, destination
    pickle.dump(result, dbfile)                     
    dbfile.close()
    results_to_sentence_srt(result, 'test'+str(i)+'.srt')                                  

# # for reading also binary mode is important
# dbfile = open('examplePickle', 'rb')     
# db = pickle.load(dbfile)
# for keys in db:
    # print(keys, '=>', db[keys])
# dbfile.close()
```

and compile the all things with this batch script

```sh
@ echo off
SetLocal EnableDelayedExpansion

REM Get silence time stamps
REM ffmpeg -i input.mp3 -af silencedetect -f null -

REM remove silent from mp3
REM ffmpeg -i test.mp3 -af "silenceremove=start_periods=1:start_duration=1:start_threshold=-60dB:detection=peak,aformat=dblp,areverse,silenceremove=start_periods=1:start_duration=1:start_threshold=-60dB:detection=peak,aformat=dblp,areverse" test2.mp3

ffmpeg -f lavfi -i color=c=black:s=1024x576:r=5 -i test.mp3 -crf 0 -c:a copy -shortest -y test_black.mp4

for /f %%p in ('ls -1 ^| grep -E "*.srt$" ^| wc -l') do set /a variable=%%p

set /a var=%variable%-1

FOR /L %%x IN (0,1,%var%) DO (
	ffmpeg -stats -loglevel error -i test_black.mp4 -vf subtitles=test%%x.srt -y test%%x_srt.mp4
	ffmpeg -stats -loglevel error -i test%%x_srt.mp4 -vf "crop=1024:100:0:500" -c:v libx264 -c:a copy -y test%%x_srt_cut.mp4
	ffmpeg -stats -loglevel error -i test%%x_srt_cut.mp4 -vf "drawtext=text='%%x': fontcolor=white: fontfile='Arial': fontsize=15: box=1: boxcolor=Black@0.5:boxborderw=10: x=0.05*w: y=0.5*h: enable='between(t,0,500)'" -y test%%x_srt_cut_n.mp4
)

set list=
for %%a in ("*srt_cut_n.mp4") do set list=!list! -i "%%a"
ffmpeg -stats -loglevel error %list% -filter_complex vstack=inputs=%variable% -y all.mp4

FOR /L %%x IN (0,1,%var%) DO (
	rm test%%x_srt.mp4 test%%x_srt_cut.mp4 test%%x_srt_cut_n.mp4
)
	
```

creating this video to compare each parameter:

https://github.com/DGrv/dorian.gravier.github.io/files/posts/2023/all-whisper.mp4





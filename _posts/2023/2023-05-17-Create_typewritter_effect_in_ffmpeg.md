--- 
title: "Create typewritter effect in ffmpeg" 
date: "2023-05-17 14:43" 
comments_id: 70
--- 

After improving for my case what [Thiago](https://video.stackexchange.com/users/34364/thiago-cond%c3%a9) said.

I arrived to this:

# First the ffmpeg code

For mp4:

```sh
ffmpeg -f lavfi -i color=c=black:s=640x480:d=8 -vf "subtitles=typewriter.ass" -video_track_timescale 24000 output.mp4
```

# ASS file

Then let's create a minimal ASS:
[All Tags info are here](https://aegi.vmoe.info/docs/3.0/ASS_Tags/.)

```txt
[Script Info]
; Comment with ";"
ScriptType: v4.00+

[V4+ Styles]
Format: Name,  Fontname,  Fontsize,  PrimaryColour,  SecondaryColour,  OutlineColour,  BackColour,  Bold,  Italic,  Underline,  StrikeOut,  ScaleX,  ScaleY,  Spacing,  Angle,  BorderStyle,  Outline,  Shadow,  Alignment,  MarginL,  MarginR,  MarginV,  Encoding
Style: style1,  Arial,  30,  &H00FFFFFF, &HFF0000FF, &HFF000000, &H00000000, 0, 0, 0, 0, 100, 100, 0, 0, 1, 0, 0, 7, 20, 20, 20, 1


[Events]
Format: Layer,  Start,  End,  Style,  Name,  MarginL,  MarginR,  MarginV,  Effect,  Text
Dialogue: 0, 0:00:00.5, 0:00:12.00, style1, , 0, 0, 0, , Your text is here
```

Let's the text only as a typewriter style. I will let you play with the tags for your purpose.

Here is the simpler command I do to create the `\k` (karaoke) balise for each letter.
I use a random sequence between 10 and 25 centisecondes with an increment of 5 cs for each character.
You can run in in `bash` (check [WSL for Windows](https://learn.microsoft.com/en-us/windows/wsl/install))

```sh
echo "Let's try to create a type writer text rapidly" | sed 's/./&\n/g' | while read p; do r=$(seq 10 5 25| shuf | head -1); echo {\\k$r}$p; done | tr -d '\n' | sed 's/}{/} {/g'
```

which will output e.g.: `{\k10}L{\k15}e{\k25}t{\k25}'{\k25}s{\k25} {\k15}t{\k10}r{\k10}y{\k25} {\k15}t{\k15}o{\k15} {\k25}c{\k25}r{\k10}e{\k15}a{\k20}t{\k15}e{\k15} {\k10}a{\k25} {\k10}t{\k10}y{\k20}p{\k20}e{\k10} {\k25}w{\k20}r{\k25}i{\k15}t{\k15}e{\k25}r{\k15} {\k15}t{\k15}e{\k15}x{\k10}t{\k15} {\k25}r{\k20}a{\k10}p{\k15}i{\k25}d{\k15}l{\k25}y{\k20}`

You just have to put it in your file :)

![Gif to show the result](/assests/images/posts/2023/typewritter.gif)


# Big example

## ASS

```txt
[Script Info]
; Comment with ";"
ScriptType: v4.00+

[V4+ Styles]
Format: Name,  Fontname,  Fontsize,  PrimaryColour,  SecondaryColour,  OutlineColour,  BackColour,  Bold,  Italic,  Underline,  StrikeOut,  ScaleX,  ScaleY,  Spacing,  Angle,  BorderStyle,  Outline,  Shadow,  Alignment,  MarginL,  MarginR,  MarginV,  Encoding
;Alignment is 1 to 9 I think, 1 is left bottom, 2 middle bottom, 3 right bottom, 4 left middle and so on .... 
Style: style1,  Arial,  15,  &H00FFFFFF, &HFF0000FF, &HFF000000, &H00000000, 0, 0, 0, 0, 100, 100, 0, 0, 1, 0, 0, 7, 20, 20, 20, 1
Style: style2,  Arial,  10,  &H00FFFFFF, &HFF0000FF, &HFF000000, &H00000000, 0, 0, 0, 0, 100, 100, 0, 0, 1, 0, 0, 1, 20, 20, 20, 1

[Events]
Format: Layer,  Start,  End,  Style,  Name,  MarginL,  MarginR,  MarginV,  Effect,  Text
Dialogue: 0, 0:00:01.0, 0:02:00.0, style1, , 0, 0, 0, , {\k1}H{\k1}o{\k3}l{\k5}a{\k1} {\k7}m{\k7}u{\k1}c{\k1}h{\k1}a{\k3}c{\k5}h{\k5}a{\k9}({\k1}o{\k1}){\k5},{\k9} {\k1}I{\k1} {\k5}h{\k7}a{\k1}v{\k1}e{\k3} {\k3}a{\k7} {\k9}s{\k7}m{\k3}a{\k7}l{\k9}l{\k1} {\k9}s{\k7}e{\k1}r{\k9}v{\k5}i{\k1}c{\k1}e{\k3} {\k7}t{\k5}o{\k7} {\k7}a{\k3}s{\k9}k{\k9} {\k7}y{\k1}o{\k7}u{\k5}.{\k1} {\k7}O{\k1}n{\k9}e{\k1} {\k1}o{\k5}f{\k9} {\k5}m{\k9}y{\k5} {\k7}g{\k3}o{\k7}a{\k7}l{\k3} {\k5}w{\k7}a{\k9}s{\k1} {\k1}t{\k1}o{\k5} {\k9}t{\k3}r{\k1}y{\k1} {\k3}t{\k5}o{\k7} {\k7}g{\k5}e{\k9}t{\k7} {\k7}s{\k9}o{\k3}m{\k7}e{\k7} {\k3}f{\k9}i{\k3}n{\k7}a{\k7}n{\k5}c{\k9}i{\k7}a{\k7}l{\k9} {\k3}s{\k1}u{\k9}p{\k9}p{\k1}o{\k1}r{\k1}t{\k9} {\k9}f{\k7}r{\k7}o{\k1}m{\k5} {\k5}Y{\k9}o{\k3}u{\k9}t{\k3}u{\k7}b{\k9}e{\k9} {\k5}v{\k3}i{\k5}a{\k7} {\k1}t{\k7}h{\k1}e{\k1} {\k1}s{\k7}u{\k9}b{\k7}s{\k1}c{\k3}r{\k5}i{\k5}b{\k7}e{\k7}r{\k1}s{\k5} {\k3}t{\k1}o{\k1} {\k5}c{\k1}o{\k7}n{\k7}t{\k3}i{\k7}n{\k1}u{\k1}e{\k1} {\k7}m{\k9}y{\k1} {\k1}t{\k7}r{\k5}i{\k3}p{\k1} {\k3}a{\k1}n{\k1}d{\k7} {\k9}t{\k3}o{\k5} {\k1}s{\k1}h{\k9}a{\k3}r{\k7}e{\k3} {\k5}s{\k7}o{\k3}m{\k7}e{\k3} {\k1}n{\k1}i{\k7}c{\k3}e{\k9} {\k3}e{\k3}x{\k1}p{\k1}e{\k1}r{\k3}i{\k1}e{\k1}n{\k3}c{\k7}e{\k7}s{\k1},{\k1} {\k1}d{\k1}r{\k1}e{\k9}a{\k1}m{\k3}s{\k1} {\k3}a{\k7}n{\k3}d{\k3} {\k1}s{\k1}c{\k9}e{\k9}n{\k3}e{\k7}r{\k1}i{\k9}e{\k1}s{\k7} {\k5}t{\k3}o{\k1} {\k5}e{\k9}m{\k7}p{\k1}o{\k9}w{\k3}e{\k3}r{\k9} {\k7}p{\k9}e{\k7}o{\k1}p{\k5}l{\k3}e{\k5} {\k7}t{\k9}o{\k9} {\k1}f{\k5}o{\k3}l{\k5}l{\k3}o{\k9}w{\k5} {\k3}w{\k3}h{\k9}a{\k1}t{\k9} {\k5}t{\k1}h{\k9}e{\k7}y{\k5} {\k5}w{\k5}i{\k7}s{\k7}h{\k5}.{\k7} {\k1}U{\k9}n{\k7}f{\k3}o{\k9}r{\k9}t{\k3}u{\k7}n{\k9}a{\k1}t{\k3}e{\k9}l{\k3}y{\k9} {\k5}I{\k5} {\k7}d{\k7}o{\k1} {\k5}n{\k1}o{\k7}t{\k3} {\k1}h{\k9}a{\k9}v{\k3}e{\k9} {\k3}e{\k1}n{\k3}o{\k9}u{\k3}g{\k9}h{\k5} {\k7}s{\k3}u{\k7}b{\k9}s{\k7}c{\k5}r{\k9}i{\k9}b{\k1}e{\k5}r{\k9}s{\k1} {\k5}({\k1}I{\k9} {\k1}c{\k1}a{\k5}n{\k5} {\k7}n{\k3}o{\k9}t{\k5} {\k1}e{\k9}v{\k7}e{\k9}n{\k1} {\k3}b{\k9}e{\k5} {\k1}p{\k1}a{\k3}r{\k7}t{\k9} {\k9}o{\k9}f{\k3} {\k7}t{\k3}h{\k5}i{\k9}s{\k7}){\k5} {\k3}s{\k1}i{\k5}n{\k3}c{\k7}e{\k3} {\k1}I{\k7} {\k1}n{\k9}e{\k3}e{\k1}d{\k9} {\k5}a{\k5}t{\k1} {\k7}l{\k7}e{\k1}a{\k5}s{\k3}t{\k5} {\k9}4{\k5}0{\k3}0{\k9}.{\k3} {\k9}A{\k1}s{\k7} {\k7}y{\k7}o{\k9}u{\k7} {\k5}s{\k7}e{\k9}e{\k5} {\k5}I{\k7} {\k7}a{\k9}m{\k1} {\k5}f{\k9}a{\k1}r{\k9} {\k3}f{\k7}r{\k1}o{\k5}m{\k9} {\k5}i{\k7}t{\k1}.{\k5} {\k5}I{\k1}F{\k3} {\k5}y{\k1}o{\k5}u{\k3} {\k5}e{\k7}n{\k5}j{\k9}o{\k9}y{\k7} {\k1}w{\k1}h{\k7}a{\k3}t{\k9}c{\k7}h{\k1}i{\k7}n{\k7}g{\k3} {\k9}t{\k9}h{\k3}o{\k7}s{\k1}e{\k1} {\k5}v{\k5}i{\k9}d{\k9}e{\k3}o{\k5}s{\k1},{\k3} {\k7}m{\k7}a{\k5}y{\k9}b{\k1}e{\k3} {\k3}c{\k5}a{\k1}n{\k5} {\k3}y{\k3}o{\k1}u{\k7} {\k1}s{\k7}h{\k5}a{\k5}r{\k3}e{\k5} {\k3}i{\k5}t{\k9} {\k1}t{\k1}h{\k5}a{\k7}t{\k1} {\k3}t{\k1}h{\k3}e{\k1} {\k3}c{\k5}h{\k5}a{\k3}n{\k5}n{\k1}e{\k3}l{\k7} {\k5}c{\k9}o{\k9}u{\k3}l{\k5}d{\k5} {\k1}t{\k7}r{\k5}y{\k5} {\k5}t{\k3}o{\k1} {\k1}g{\k5}r{\k1}o{\k1}w{\k7} {\k1}a{\k1} {\k9}b{\k3}i{\k9}t{\k3}.{\k7} {\k9}L{\k9}e{\k5}t{\k1}'{\k5}s{\k7} {\k7}t{\k3}r{\k9}y{\k1} {\k9}t{\k5}o{\k1}g{\k9}e{\k9}t{\k5}h{\k7}e{\k1}r{\k3} {\k3}:{\k9}){\k7} {\k1}M{\k7}e{\k9}r{\k9}c{\k5}i{\k7}.{\k3} {\k5}G{\k5}r{\k9}o{\k1}s{\k9} {\k5}b{\k1}i{\k1}s{\k3}o{\k9}u{\k7}s{\k5}.{\k5}
Dialogue: 0, 0:00:01.0, 0:02:00.0, style2, , 0, 0, 0, , {\k9}H{\k7}o{\k7}l{\k3}a{\k5} {\k9}m{\k1}u{\k9}c{\k7}h{\k1}a{\k9}c{\k1}h{\k3}a{\k3}({\k9}o{\k9}){\k3},{\k1} {\k5}J{\k5}'{\k5}a{\k5}i{\k3} {\k1}u{\k3}n{\k1} {\k3}p{\k5}e{\k1}t{\k7}i{\k9}t{\k1} {\k7}s{\k1}e{\k3}r{\k5}v{\k7}i{\k5}c{\k9}e{\k9} {\k9}à{\k1} {\k7}t{\k3}e{\k1} {\k3}d{\k3}e{\k7}m{\k7}a{\k1}n{\k9}d{\k7}e{\k5}r{\k3}.{\k3} {\k9}U{\k5}n{\k9} {\k5}d{\k7}e{\k5} {\k5}m{\k5}e{\k3}s{\k7} {\k1}o{\k1}b{\k5}j{\k1}e{\k3}c{\k1}t{\k5}i{\k9}f{\k7}s{\k5} {\k1}é{\k5}t{\k7}a{\k5}i{\k9}t{\k9} {\k9}d{\k5}e{\k3} {\k5}p{\k1}o{\k5}u{\k9}v{\k5}o{\k1}i{\k3}r{\k9} {\k5}g{\k7}é{\k9}n{\k9}é{\k9}r{\k1}e{\k9}r{\k5} {\k9}u{\k1}n{\k7} {\k1}p{\k5}e{\k1}u{\k7} {\k7}d{\k5}'{\k9}a{\k3}r{\k7}g{\k1}e{\k5}n{\k5}t{\k9} {\k9}a{\k5}v{\k3}e{\k7}c{\k5} {\k7}l{\k7}e{\k1} {\k9}c{\k7}a{\k3}n{\k1}a{\k3}l{\k1} {\k3}Y{\k5}o{\k9}u{\k3}t{\k7}u{\k1}b{\k7}e{\k5} {\k7}p{\k3}o{\k7}u{\k7}r{\k3} {\k7}m{\k9}'{\k1}a{\k1}i{\k3}d{\k9}e{\k1}r{\k9} {\k3}à{\k7} {\k9}c{\k3}o{\k5}n{\k1}t{\k1}i{\k9}n{\k5}u{\k7}e{\k7}r{\k7} {\k9}m{\k9}o{\k9}n{\k9} {\k7}v{\k7}o{\k1}y{\k9}a{\k7}g{\k5}e{\k9} {\k1}e{\k3}t{\k7} {\k1}p{\k3}a{\k5}r{\k5}t{\k9}a{\k3}g{\k1}e{\k1}r{\k3},{\k5} {\k1}c{\k7}e{\k1}s{\k7} {\k3}e{\k3}x{\k1}p{\k3}é{\k7}r{\k5}i{\k5}e{\k3}n{\k9}c{\k9}e{\k9}s{\k1},{\k7} {\k7}c{\k5}e{\k5}s{\k1} {\k9}r{\k7}ê{\k9}v{\k1}e{\k1}s{\k1} {\k7}e{\k3}t{\k9} {\k5}c{\k1}e{\k5}s{\k9} {\k9}p{\k7}a{\k9}y{\k7}s{\k9}a{\k9}g{\k5}e{\k7}s{\k1}.{\k1} {\k3}J{\k3}e{\k3} {\k9}p{\k1}e{\k7}n{\k9}s{\k7}e{\k3} {\k9}q{\k9}u{\k3}e{\k7} {\k3}c{\k7}e{\k1}l{\k9}a{\k7} {\k9}p{\k3}o{\k9}u{\k3}r{\k3}r{\k5}a{\k5}i{\k9}t{\k9} {\k9}m{\k3}o{\k7}t{\k7}i{\k1}v{\k1}e{\k1}r{\k7} {\k5}l{\k9}e{\k3}s{\k3} {\k5}g{\k3}e{\k3}n{\k3}s{\k9} {\k5}à{\k3} {\k5}s{\k1}u{\k7}i{\k3}v{\k5}r{\k9}e{\k9} {\k9}l{\k1}e{\k5}u{\k9}r{\k5}s{\k5} {\k9}e{\k9}n{\k7}v{\k9}i{\k1}e{\k5}s{\k1}.{\k3} {\k5}M{\k1}a{\k9}l{\k5}h{\k3}e{\k5}u{\k3}r{\k3}e{\k7}u{\k3}s{\k7}e{\k1}m{\k5}e{\k1}n{\k1}t{\k5} {\k5}j{\k9}e{\k3} {\k1}n{\k5}'{\k5}a{\k7}i{\k9} {\k9}p{\k5}a{\k7}s{\k9} {\k1}a{\k1}s{\k7}s{\k7}e{\k3}z{\k1} {\k7}d{\k1}e{\k1} {\k5}s{\k5}u{\k7}b{\k3}s{\k1}c{\k3}r{\k5}i{\k7}b{\k5}e{\k5}r{\k7}s{\k3} {\k7}p{\k1}o{\k9}u{\k5}r{\k1} {\k7}a{\k9}d{\k3}h{\k7}é{\k3}r{\k3}e{\k9}r{\k3} {\k9}a{\k1}u{\k9} {\k3}p{\k3}r{\k1}o{\k9}g{\k3}r{\k9}a{\k9}m{\k9}m{\k9}e{\k9} {\k7}d{\k7}e{\k1} {\k5}f{\k3}i{\k3}n{\k7}c{\k3}a{\k1}n{\k7}c{\k3}e{\k5}m{\k3}e{\k7}n{\k7}t{\k3} {\k3}({\k3}i{\k9}l{\k1} {\k5}e{\k3}n{\k5} {\k3}f{\k9}a{\k7}u{\k7}t{\k5} {\k7}m{\k3}i{\k7}n{\k7}i{\k3}m{\k3}u{\k9}m{\k5} {\k5}4{\k3}0{\k9}0{\k9}){\k7}.{\k5} {\k5}S{\k1}i{\k3} {\k9}l{\k9}e{\k7}s{\k9} {\k3}v{\k7}i{\k7}d{\k9}é{\k5}o{\k3}s{\k7} {\k3}v{\k7}o{\k1}u{\k3}s{\k5} {\k1}p{\k1}l{\k3}a{\k1}i{\k1}s{\k9}e{\k9}n{\k5}t{\k3} {\k7}v{\k1}o{\k7}u{\k5}s{\k3} {\k5}p{\k7}o{\k9}u{\k5}r{\k1}r{\k7}i{\k9}e{\k3}z{\k7} {\k1}p{\k3}e{\k7}u{\k9}t{\k7}-{\k1}ê{\k3}t{\k5}r{\k9}e{\k5} {\k7}l{\k5}e{\k3}s{\k7} {\k7}p{\k5}a{\k9}r{\k9}t{\k7}a{\k7}g{\k7}e{\k7}r{\k3} {\k5}d{\k9}'{\k1}u{\k3}n{\k7}e{\k7} {\k3}c{\k9}e{\k3}r{\k5}t{\k5}a{\k3}i{\k3}n{\k9}e{\k3} {\k9}f{\k7}a{\k1}c{\k9}o{\k1}n{\k3}.{\k7} {\k7}E{\k1}s{\k9}s{\k9}a{\k3}y{\k7}o{\k5}n{\k9}s{\k3} {\k5}e{\k9}n{\k3}s{\k9}e{\k3}m{\k1}b{\k5}l{\k9}e{\k3}.{\k9} {\k5}M{\k7}e{\k9}r{\k3}c{\k5}i{\k3} {\k3}e{\k1}t{\k9} {\k7} {\k7}g{\k3}r{\k7}o{\k3}s{\k9} {\k5}b{\k9}i{\k5}s{\k1}o{\k5}u{\k1}s{\k9}.{\k5}


; example to create random time, will be copied to the clipboard
;echo "Hola muchacha(o), I have a small service to ask you. One of my goal was to try to get some financial support from Youtube via the subscribers to continue my trip and to share some nice experiences, dreams and sceneries to empower people to follow what they wish. Unfortunately I do not have enough subscribers (I can not even be part of this) since I need at least 400. As you see I am far from it. IF you enjoy whatching those videos, maybe can you share it that the channel could try to grow a bit. Let's try together :) Merci. Gros bisous." | sed 's/./&\n/g' | while read p; do r=$(seq 1 2 10| shuf | head -1); echo {\\k$r}$p; done | tr -d '\n' | sed 's/}{/} {/g'
;echo "Hola muchacha(o), J'ai un petit service à te demander. Un de mes objectifs était de pouvoir générer un peu d'argent avec le canal Youtube pour m'aider à continuer mon voyage et partager, ces expériences, ces rêves et ces paysages. Je pense que cela pourrait motiver les gens à suivre leurs envies. Malheureusement je n'ai pas assez de subscribers pour adhérer au programme de fincancement (il en faut minimum 400). Si les vidéos vous plaisent vous pourriez peut-être les partager d'une certaine facon. Essayons ensemble. Merci et  gros bisous." | sed 's/./&\n/g' | while read p; do r=$(seq 1 2 10| shuf | head -1); echo {\\k$r}$p; done | tr -d '\n' | sed 's/}{/} {/g'

; can also use {\pos(109,187.5)} for position, do not know exactly yet
; \N to return
; for more tags https://www.nikse.dk/subtitleedit/formats/assa-override-tags

; to create 
; ffmpeg -stats -loglevel error -f lavfi -i color=c=black:s=1920x1080:d=60 -vf "subtitles=test.ass" -video_track_timescale 24000 -y output.mp4 && output.mp4
; gif
; ffmpeg -f lavfi -i color=size=1920x1080:rate=30:color=black -vf "subtitles=test.ass" -t 60 output.gif && output.gif

```


## ffmepg

```sh
ffmpeg -stats -loglevel error -f lavfi -i color=c=black:s=1920x1080:d=60 -vf "subtitles=test.ass" -video_track_timescale 24000 -y output.mp4 && output.mp4
```

## Output

![Gif to show the result](/assests/images/posts/2023/typewritter2.gif)


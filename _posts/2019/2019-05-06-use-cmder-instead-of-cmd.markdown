---
layout: "post"
title: "Cmder a fency terminal"
date: "2019-05-06 15:11"
comments_id: 	28
---

I do a lot of easy coding with batch files. So you can imagine that I could have sometimes several cmd windows open here and there ... what a mess.

[Cmder](https://cmder.net/) solved my problem.

I just used the cmder-mini. To replace the cmd with the cmder :

- Open cmder.exe
- `Win+Alt+P` to open the settings
- go in Integration / Default term
- Check [x] Force ConEmu as default terminal for console applications
- Check [x] Register on OS startup
- Save settings

![Picture](/files/posts/2019/2019-05-06/Cmder_default_term.jpg)

If you use [FreeCommander](https://freecommander.com/en/summary/) (an expolorer much better that the one from Windows), you know that you can open a cmd terminal where your explorer is by pressing `Ctrl+D`. In order to use Cmder as well with this:

- Open cmder.exe
- `Win+Alt+P` to open the settings
- Startup / Task
  - Create a new one by clicking `+`
  - Give the 'cmd' name
  - Task parameters :  `/icon "%CMDER_ROOT%\icons\cmder.ico"`
- Go in Settings / View / DOS Prompt
- Modify DOS box command specification : `<path-of-your-Cmder.exe> /task "cmd" /single`

![Picture](/files/posts/2019/2019-05-06/2019-05-06_Gif_cmder.gif)

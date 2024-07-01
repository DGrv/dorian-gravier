---
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

![Picture](/assets/images/posts/2019/2019-05-06/Cmder_default_term.jpg)

# Integration with FreeCommander

If you use [FreeCommander](https://freecommander.com/en/summary/) (an expolorer much better that the one from Windows), you know that you can open a cmd terminal where your explorer is by pressing `Ctrl+D`. In order to use Cmder as well with this:

- Go in Settings / View / DOS Prompt
- Modify DOS box command specification : `<path-of-your-Cmder.exe> /single /x "/cmd cmd" %ActivDir%`
	- Single permit to open a new tab and to have only one instance

# Batch files

Create a reg file:

```shell
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\batfile\shell\open\command]
@="\"C:\\Users\\doria\\scoop\\apps\\cmder\\current\\Cmder.exe" /single /x \"/cmd %1\""
```

- [Source](https://github.com/cmderdev/cmder/issues/2110#issuecomment-1041922115)

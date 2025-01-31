#Requires AutoHotkey v1.1.33+

#Persistent
MyLabel:

SetKeyDelay, 35 ; might be important for pasting correct characters

F9::
	Loop {
		Send ^b
		Sleep 400
		If WinExist("Append_paste_text_v01.ahk") {
			Break
		}
		SendInput {enter}
		Sleep 300
	}
	ExitApp
Return

Esc::ExitApp


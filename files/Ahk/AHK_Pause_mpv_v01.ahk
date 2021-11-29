;Pause mpv
d::
	WinGetClass, class, A
	WinActivate, ahk_class mpv
	Send, {Blind}{Space}
	WinActivate, ahk_class %class%
	;Send, {Blind}{Alt Down}{Tab}{Alt Up}
Return

;Backward 20s in mpv
f::
	WinGetClass, class, A
	WinActivate, ahk_class mpv
	Send, {Blind}{Left}
	WinActivate, ahk_class %class%
	;Send, {Blind}{Alt Down}{Tab}{Alt Up}
Return


Esc::ExitApp

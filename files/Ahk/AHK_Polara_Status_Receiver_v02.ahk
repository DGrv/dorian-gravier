;#z:: ; Win+Z hotkey
path := "X:\Data\Thermo\"
file1 := "Polara_Status_STOP.txt"
file2 := "Polara_Status_Maximize-window.txt"
sound := "PooPoo.mp3"

SoundSet, 20

If ( FileExist(path) ) {
} else {
	path := StrReplace(path, "X:", "H:")
}

file1 = %path%%file1%
file2 = %path%%file2%
sound = %path%%sound%

Loop {
	if FileExist(file2) {
		MsgBox, , AutoHotKey script,  Call Dorian or Maximize the window on Polara please, 59
		Sleep, 60000
		; Maximize window
		vline(50, 0, 2, 5000, 4, "42f5da")
	} else {
		Sleep, 15000
		if FileExist(file1) {
			;SoundBeep, 750, 500
			;SoundPlay %sound%
			; STOP
			vline(50, 0, 2, 5000, 4, "ff0019")
			MsgBox, , AutoHotKey script, Polara Stopped !!!!!!!!!!!!!!!!!!!!!!!!, 59
			Sleep, 60000
		}
	}
	; Green OK
	vline(50, 0, 2, 5000, 4, "38ff2e")
	Sleep, 60000
}
return

; ------------------- Function -------------------

vline(n,x,y, width, length, color) {
	WinGet, winid ,, A ; get id from last active window
	;n is just an id of a gui give a random number
	length2 := length /2
	y2 := y-length2
	Gui %n%:Color, %color%,0                  ; Black
	Gui %n%:-Caption +ToolWindow +E0x20 ; No title bar, No taskbar button, Transparent for clicks
	Gui %n%: Show, X%x% Y%y2% W%width% H%length%      ; Show it
	WinGet ID, ID, A                    ; ...with HWND/handle ID
	Winset AlwaysOnTop,ON,ahk_id %ID%   ; Keep it always on the top
	WinSet Transparent,255,ahk_id %ID%  ; Opaque
	WinActivate ahk_id %winid% ; activate again the last active window
	Return ID
}

pause::Pause,Toggle
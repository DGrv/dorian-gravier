#Persistent
MyLabel:

state := "run"
ShowOnOff("info", "Append_Copy ON", "Green")

n = 0
Clipboard =

OnClipboardChange:
if (state = "run") {
	If A_EventInfo = 1
	{
		If Clipboard = %Current%
		Return
		If (n = 0) {
			Current := Clipboard
			n += 1
		} Else {
			Current := Current "`n" Clipboard
			Clipboard := Current
		}
	}
}
Return

Esc::ExitApp

; Esc::
; if (state = "run") {
	; state := "pause"
	; ShowOnOff("info", "Append_Copy OFF", "Red")
	; bu := Clipboard
	; KeyWait, Esc
; } else {
	; Clipboard := bu
	; Goto, MyLabel
; }
; ; pause
; return

; source: https://autohotkey.com/board/topic/96876-can-i-append-the-current-clipboard-to-the-clipboard-with-onclipboardchange/


; FUNCTIONS ------------------------------------


ShowOnOff(n, message, colorwanted) {
	;n is just an id of a gui give a random number
	gui %n%:Destroy
	Gui %n%:Color, White
	Gui %n%:-caption +toolwindow +AlwaysOnTop
	Gui %n%:font, s20 bold, Arial
	Gui %n%:add, text, c%colorwanted% TransColor, %message%
	;Gui Show, % "x" A_ScreenWidth*0.55 " y" A_ScreenHeight*0.85, TRANS-WIN
	Gui %n%:Show, % "x" A_ScreenWidth*0.15 " y" A_ScreenHeight*0.0001, TRANS-WIN
	WinSet TransColor, White, TRANS-WIN
}
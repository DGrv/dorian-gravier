#Persistent
MyLabel:

ShowOnOff("info", "Append_Paste ON - will loop", "Purple", 0.15, 0.0001)
ShowOnOff("info2", "Copy your text", "Red", 0.15, 0.05)
FileDelete C:\Users\doria\Downloads\Append_Paste_AHK_temp

clipboard := ""  ; Start off empty to allow ClipWait to detect when the text has arrived.
ClipWait  ; Wait for the clipboard to contain text.
ShowOnOff("info2", "Ready", "Green", 0.15, 0.05)

FileAppend %clipboard%, C:\Users\doria\Downloads\Append_Paste_AHK_temp



Loop, Read, C:\Users\doria\Downloads\Append_Paste_AHK_temp
{
   total_lines = %A_Index%
}


lineNumber = 0

^v::
	lineNumber += 1
	FileReadLine, content, C:\Users\doria\Downloads\Append_Paste_AHK_temp, %lineNumber%
	ClipWait
	; Sendinput %content%`r`n
	Sendinput %content%`n
	If (lineNumber = total_lines) {
		MsgBox Take will loop to line 1 again !
		lineNumber = 0
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


ShowOnOff(n, message, colorwanted, posx, posy) {
	;n is just an id of a gui give a random number
	gui %n%:Destroy
	Gui %n%:Color, White
	Gui %n%:-caption +toolwindow +AlwaysOnTop
	Gui %n%:font, s20 bold, Arial
	Gui %n%:add, text, c%colorwanted% TransColor, %message%
	;Gui Show, % "x" A_ScreenWidth*0.55 " y" A_ScreenHeight*0.85, TRANS-WIN
	Gui %n%:Show, % "x" A_ScreenWidth*posx " y" A_ScreenHeight*posy, TRANS-WIN
	WinSet TransColor, White, TRANS-WIN
}
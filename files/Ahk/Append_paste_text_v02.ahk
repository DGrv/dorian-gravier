#Requires AutoHotkey v1.1.33+

#Persistent
MyLabel:

SetKeyDelay, 35 ; might be important for pasting correct characters

ShowOnOff("info", "Append_Paste ON - will loop - Use Ctrl+b to paste - F9 for auto paste/return", "Purple", 0.15, 0.0001)
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

^b::
	lineNumber += 1
	FileReadLine, content, C:\Users\doria\Downloads\Append_Paste_AHK_temp, %lineNumber%
	ClipWait
	; Sendinput %content%`r`n
	
	; if (content ~= "\^|\+|\!|\#|\{|\}")
		; Sendinput %content%`n
		; ; MsgBox "Contains"
	; else
		; SendRaw %content%`n
		; ; MsgBox "Not contains"
		
	Clipboard = %content%`n
	Send ^v
		
	; Sleep 200
	
	If (lineNumber = total_lines) {
		MsgBox Take will loop to line 1 again !
		lineNumber = 0
	}
Return


F9::
	Loop {
		lineNumber += 1
		FileReadLine, content, C:\Users\doria\Downloads\Append_Paste_AHK_temp, %lineNumber%
		ClipWait
		Clipboard = %content%`n
		Send ^v
		If (lineNumber = total_lines) {
			MsgBox Take will loop to line 1 again !
			lineNumber = 0
			Break
		}
		Sleep 300
		SendInput {enter}
		Sleep 300
	}
	ExitApp
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
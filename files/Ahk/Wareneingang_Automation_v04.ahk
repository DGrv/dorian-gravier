; F8::


Msgbox Be sure that your Wareneingang is open with the cursor on the 'Freier Wareneingang'

Msgbox Be sure that you have your Notepad 'new 1' open


ShowOnOff()

; -------------- Start ------------------
SetTitleMatchMode, 2
CoordMode, Mouse, Screen

Sleep, 100

tt = *new 1 - Notepad++ ahk_class Notepad++
WinWait, %tt%
; IfWinNotActive, %tt%,, WinActivate, %tt%
WinActivate, %tt%

Sleep, 100

Send, {Blind}{left}{left}{PgUp}{PgUp}{PgUp}{PgUp}{PgUp}{PgUp}{PgUp}{PgUp}{PgUp}{Home}

Sleep, 100

line = 1
Loop 400 {
	; ---------- Notepad back and go down ----------
	line := line + 1
	
	Clipboard := 			 	; Clear the clipboard.
	
	Sleep, 100

	tt = *new 1 - Notepad++ ahk_class Notepad++
	WinWait, %tt%
	; IfWinNotActive, %tt%,, WinActivate, %tt%
	WinActivate, %tt%
	
	Sleep, 100

	if (line!=2) {
		Send, {Blind}{left}{Down}{Home}
	}
	
	Sleep, 100
	
	Send, {Blind}{Shift Down}{End}{Shift Up}{Ctrl Down}c{Ctrl Up}

	Sleep, 100

	tt = Lager
	WinWait, %tt%
	; IfWinNotActive, %tt%,, WinActivate, %tt%
	WinActivate, %tt%
	
	Sleep, 100

	Send, {Blind}{backspace}{Ctrl Down}v{Ctrl Up}{NumpadEnter}
	
	
	Sleep, 1500
	
	IfWinExist, Artikel
	{
		Send, {NumpadEnter}
		
		Sleep, 100
		
		tt = Lager
		WinWait, %tt%
		; IfWinNotActive, %tt%,, WinActivate, %tt%
		WinActivate, %tt%
		
		Sleep, 100	
		
		Send, {Blind}{Shift Down}{Tab}{Shift Up}
		Send, {Blind}{Shift Down}{Tab}{Shift Up}
		Send, {Blind}{Shift Down}{Tab}{Shift Up}
		Send, {Blind}{Shift Down}{Tab}{Shift Up}
		Send, {Blind}{Shift Down}{Tab}{Shift Up}
		
		Sleep, 100	
		
		tt = *new 1 - Notepad++ ahk_class Notepad++
		WinWait, %tt%
		; IfWinNotActive, %tt%,, WinActivate, %tt%
		WinActivate, %tt%
		
		Send, {Blind}{Left}{End}{Tab}{Tab}{Shift Down}not found{Shift Up}

	} else {
	
		Send, {NumpadEnter}
		
		Sleep, 100

		tt = Wareneingang
		WinWait, %tt%
		; IfWinNotActive, %tt%,, WinActivate, %tt%
		WinActivate, %tt%
	
		Sleep, 100

		Send, {Blind}{NumpadEnter}

		Sleep, 100

		tt = Lager
		WinWait, %tt%
		; IfWinNotActive, %tt%,, WinActivate, %tt%
		WinActivate, %tt%
		
		Sleep, 100	
		
		Send, {Blind}{Backspace}
		
		tt = *new 1 - Notepad++ ahk_class Notepad++
		WinWait, %tt%
		; IfWinNotActive, %tt%,, WinActivate, %tt%
		WinActivate, %tt%
		
		Send, {Blind}{left}{End}{Tab}{Tab}{Shift Down}ok{Shift Up}
		
	}
	

}

GuiControl % A_IsSuspended ? "Show" : "Hide", TX

ExitApp

ShowOnOff() {
	Static TX
    If (TX = "") {
        Gui Color, White
        Gui -caption +toolwindow +AlwaysOnTop
        Gui font, s40 bold, Arial
        Gui add, text, vTX cRed TransColor, Script running - Press Esc to stop
        Gui Show, % "x" A_ScreenWidth*0.05 " y" A_ScreenHeight*0.1, TRANS-WIN
        WinSet TransColor, White, TRANS-WIN
        TX := "On"
    } Else
        GuiControl % A_IsSuspended ? "Show" : "Hide", TX
}



Esc::ExitApp



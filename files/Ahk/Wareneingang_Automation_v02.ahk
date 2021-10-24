; F8::


Msgbox Be sure that your Wareneingang is open with the cursor on the 'Freier Wareneingang'

Msgbox Be sure that you have your Notepad 'new 1' open


ShowOnOff()

; -------------- Start ------------------
SetTitleMatchMode, 2
CoordMode, Mouse, Screen


tt = *new 1 - Notepad++ ahk_class Notepad++
WinWait, %tt%
; IfWinNotActive, %tt%,, WinActivate, %tt%
WinActivate, %tt%


Send, {Blind}{Shift Down}{PgUp}{Shift Up}


Send, {Blind}{Left}


Send, {Blind}{Home}


Send, {Blind}{Shift Down}{End}{Shift Up}

Send, {Blind}{Ctrl Down}c{Ctrl Up}

Sleep, 100

tt = Lager
WinWait, %tt%
; IfWinNotActive, %tt%,, WinActivate, %tt%
WinActivate, %tt%

Sleep, 100

Send, {Blind}{Ctrl Down}v{Ctrl Up}{NumpadEnter}


Sleep, 1500
	
IfWinExist, Artikel
{
	MsgBox This Article ( %clipboard% ) is not in the DataBank or several article - check again - line %line%
	ExitApp
} 

Send, {NumpadEnter}

Sleep, 100

tt = Wareneingang
WinWait, %tt%
; IfWinNotActive, %tt%,, WinActivate, %tt%
WinActivate, %tt%

Sleep, 100

Send, {Blind}{NumpadEnter}


tt = Lager
WinWait, %tt%
; IfWinNotActive, %tt%,, WinActivate, %tt%
WinActivate, %tt%

line = 2
Loop 100 {
	; ---------- Notepad back and go down ----------
	
	Sleep, 100

	tt = *new 1 - Notepad++ ahk_class Notepad++
	WinWait, %tt%
	; IfWinNotActive, %tt%,, WinActivate, %tt%
	WinActivate, %tt%
	
	Sleep, 100

	Send, {Blind}{Down}

	Sleep, 100

	Send, {Blind}{Home}{Shift Down}{End}{Shift Up}{Ctrl Down}c{Ctrl Up}

	Sleep, 100

	tt = Lager
	WinWait, %tt%
	; IfWinNotActive, %tt%,, WinActivate, %tt%
	WinActivate, %tt%
	
	Sleep, 100

	Send, {Blind}{Ctrl Down}v{Ctrl Up}{NumpadEnter}
	
	
	Sleep, 1500
	
	IfWinExist, Artikel
	{
		MsgBox This Article ( %clipboard% ) is not in the DataBank - check again - line %line%
		ExitApp
	} 
	
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
	
	Clipboard := 			 	; Clear the clipboard.
	
	line := line + 1
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



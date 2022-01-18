;F8::



ShowOnOff(20)


SetTitleMatchMode, 2
CoordMode, Mouse, Screen

number = 0

;MouseClick, R, 1071, 412
;MouseClick, L, 1190, 538
;MouseClick, L, 1418, 545
;MouseClick, L, 850, 940

M1x = 1071
M1y = 432
M2x = 1190
M2y = 558
M3x = 1418
M3y = 565
M4x = 850
M4y = 950

Cross(1, M1x, M1y, 1, 50, "f50b12")
Cross(5, M2x, M2y, 1, 50, "476bf7")
Cross(10, M3x, M3y, 1, 50, "63f748")
Cross(15, M4x, M4y, 1, 50, "dc48f7")



Msgbox Be sure that your you have a list of the video titles (from extraction title cmd - Keep all Pratical also in the list) ready in new1 notepad with a space at the beginning and quote for the title. Cursor should at the first line first character. Check that your page is open with the developper tools (inspect) at a certain place. The cross simulate where the mouse will click.
;Msgbox Be sure that you have your Notepad 'new 1' open


Loop, 38
{

number += 1

Sleep, 1000

tt = Geoff Lawton Permaculture Training – Permaculture, ahk_class Chrome_WidgetWin_1
WinWait, %tt%
IfWinNotActive, %tt%,, WinActivate, %tt%

Sleep, 2000

Send, {Blind}{Ctrl Down}s{Ctrl Up}

Sleep, 200

tt = Save As ahk_class #32770
WinWait, %tt%
IfWinNotActive, %tt%,, WinActivate, %tt%

Sleep, 200

Send, %number%

Sleep, 200

Send, {Blind}{Enter}

Sleep, 200

MouseClick, R, M1x, M1y

Sleep, 200

MouseClick, L, M2x, M2y

Sleep, 200

MouseClick, L, M3x, M3y

Sleep, 200

MouseClick, L, M4x, M4y

Sleep, 2000

Send, {Blind}{Alt Down}{Tab}{Alt Up}

tt = *new 1 - Notepad++ ahk_class Notepad++
WinWait, %tt%
IfWinNotActive, %tt%,, WinActivate, %tt%

Sleep, 200

Send, {Blind}{Ctrl Down}v{Ctrl Up}

Sleep, 200

Send, {Blind}{Home}{Down}

Sleep, 200

Send, {Blind}{Alt Down}{Tab}{Alt Up}


}



GuiControl % A_IsSuspended ? "Show" : "Hide", TX

ExitApp

; -------------Function-----------------

Cross(n,x,y, width, length, color){
	hline(n,x,y, width, length, color)
	vline(n+1,x,y, width, length, color)
}

ShowOnOff(n) {
	Static TX
    If (TX = "") {
        Gui %n%:Color, White
        Gui %n%:-caption +toolwindow +AlwaysOnTop
        Gui %n%:font, s40 bold, Arial
        Gui %n%:add, text, vTX cRed TransColor, Script running - Press Esc to stop
        Gui %n%:Show, % "x" A_ScreenWidth*0.05 " y" A_ScreenHeight*0.1, TRANS-WIN
        WinSet TransColor, White, TRANS-WIN
        TX := "On"
    } Else
        GuiControl %n% A_IsSuspended ? "Show" : "Hide", TX
}

hline(n,x,y, width, length, color) {
	WinGet, winid ,, A ; get id from last active window
	;n is just an id of a gui give a random number
	length2 := length /2
	x2 := x-length2
	Gui %n%:Color, %color% ,0                  ; Black
	Gui %n%:-Caption +ToolWindow +E0x20 ; No title bar, No taskbar button, Transparent for clicks
	Gui %n%: Show, X%x2% Y%y% W%length% H%width%      ; Show it
	WinGet ID, ID, A                    ; ...with HWND/handle ID
	Winset AlwaysOnTop,ON,ahk_id %ID%   ; Keep it always on the top
	WinSet Transparent,255,ahk_id %ID%  ; Opaque
	WinActivate ahk_id %winid% ; activate again the last active window
	Return ID
}

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



Esc::ExitApp

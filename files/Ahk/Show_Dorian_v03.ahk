; F8::

SquareScreen(1, 2, "ff3300")
Square(5, 180, 10, 20, 125, 4, "18cd23")


ShowOnOff(10)

GuiControl % A_IsSuspended ? "Show" : "Hide", TX

; -------------Function-----------------


Square(n, x, y, height, width, thickness, color){
	;n is just an id of a gui give a random number
	height2 := height/2
	width2 := width/2
	x1 := x-width2
	x2 := x+width2
	y1 := y-height2
	y2 := y+height2
	; MsgBox height: %height% height2: %height2% width: %width% width2: %width2% x %x% x1 %x1% x2 %x2% y %y% y1 %y1% y2 %y2%
	vline(n, x1, y1, thickness, height, color)
	vline(n+1, x2-thickness, y1, thickness, height, color)
	hline(n+2, x1, y1, thickness, width, color)
	hline(n+3, x1, y2, thickness, width, color)
}

SquareScreen(n, thickness, color){
	;n is just an id of a gui give a random number
	vline(n, 0, 0, thickness, A_ScreenHeight, color)
	vline(n+1, A_ScreenWidth-thickness, 0, thickness, A_ScreenHeight, color)
	hline(n+2, 0, 0, thickness, A_ScreenWidth, color)
	hline(n+3, 0, A_ScreenHeight-thickness, thickness, A_ScreenWidth, color)
}


hline(n,x,y, width, length, color) {
	WinGet, winid ,, A ; get id from last active window
	;n is just an id of a gui give a random number
	length2 := length /2
	x2 := x-length2
	; MsgBox hline width %width% length %length%
	Gui %n%:Color, %color% ,0                  ; Black
	Gui %n%:-Caption +ToolWindow +E0x20 ; No title bar, No taskbar button, Transparent for clicks
	Gui %n%: Show, X%x% Y%y% W%length% H%width%      ; Show it
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
	Gui %n%:Color, %color% ,0                  ; Black
	Gui %n%:-Caption +ToolWindow +E0x20 ; No title bar, No taskbar button, Transparent for clicks
	Gui %n%: Show, X%x% Y%y% W%width% H%length%      ; Show it
	WinGet ID, ID, A                    ; ...with HWND/handle ID
	Winset AlwaysOnTop,ON,ahk_id %ID%   ; Keep it always on the top
	WinSet Transparent,255,ahk_id %ID%  ; Opaque
	WinActivate ahk_id %winid% ; activate again the last active window
	Return ID
}

ShowOnOff(n) {
	;n is just an id of a gui give a random number
	Static TX
    If (TX = "") {
        Gui %n%:Color, White
        Gui %n%:-caption +toolwindow +AlwaysOnTop
        Gui %n%:font, s20 bold, Arial
        Gui %n%:add, text, vTX cRed TransColor, Dorian ist hier :), einfach machen was ihr braucht ! Achtung nicht in TEST databank zu arbeiten.
        ;Gui Show, % "x" A_ScreenWidth*0.55 " y" A_ScreenHeight*0.85, TRANS-WIN
        Gui %n%:Show, % "x" A_ScreenWidth*0.15 " y" A_ScreenHeight*0.0001, TRANS-WIN
        WinSet TransColor, White, TRANS-WIN
        TX := "On"
    } Else
        GuiControl % A_IsSuspended ? "Show" : "Hide", TX
}






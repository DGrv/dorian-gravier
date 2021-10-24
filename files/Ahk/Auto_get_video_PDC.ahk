;F8::

Msgbox Be sure that your you have a list ready in new1 notepad, inspect at a certain place. Keep all Pratical also in the list
;Msgbox Be sure that you have your Notepad 'new 1' open


ShowOnOff()



Loop, 50
{

SetTitleMatchMode, 2
CoordMode, Mouse, Screen

tt = Geoff Lawton Permaculture Training – Permaculture, ahk_class Chrome_WidgetWin_1
WinWait, %tt%
IfWinNotActive, %tt%,, WinActivate, %tt%

Sleep, 3000

MouseClick, R, 1071, 412

Sleep, 200

MouseClick, L, 1190, 538

Sleep, 200

MouseClick, L, 1418, 545

Sleep, 200

MouseClick, L, 850, 940

Sleep, 1000

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

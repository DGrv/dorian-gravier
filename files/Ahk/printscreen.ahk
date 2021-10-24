PrintScreen::Send #{PrintScreen}
LWin::
RWin::Return

#If GetKeyState("CapsLock","T")
    LWin::
    RWin::Send #{PrintScreen}
#If

F12::
    Suspend
    ShowOnOff()
Return


ShowOnOff() {
	Static TX
    If (TX = "") {
        Gui Color, White
        Gui -caption +toolwindow +AlwaysOnTop
        Gui font, s60 bold, Arial
        Gui add, text, vTX cRed TransColor, Script running - Press Esc to stop
        Gui Show, % "x" A_ScreenWidth*0.1 " y" A_ScreenHeight*0.1, TRANS-WIN
        WinSet TransColor, White, TRANS-WIN
        TX := "On"
    } Else
        GuiControl % A_IsSuspended ? "Show" : "Hide", TX
}
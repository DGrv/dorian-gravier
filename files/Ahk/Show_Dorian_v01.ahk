; F8::

ShowOnOff()

GuiControl % A_IsSuspended ? "Show" : "Hide", TX



ShowOnOff() {
	Static TX
    If (TX = "") {
        Gui Color, White
        Gui -caption +toolwindow +AlwaysOnTop
        Gui font, s20 bold, Arial
        Gui add, text, vTX cRed TransColor, Dorian ist hier :), einfach machen was ihr braucht !
        ;Gui Show, % "x" A_ScreenWidth*0.55 " y" A_ScreenHeight*0.85, TRANS-WIN
        Gui Show, % "x" A_ScreenWidth*0.30 " y" A_ScreenHeight*0.0005, TRANS-WIN
        WinSet TransColor, White, TRANS-WIN
        TX := "On"
    } Else
        GuiControl % A_IsSuspended ? "Show" : "Hide", TX
}



Esc::ExitApp



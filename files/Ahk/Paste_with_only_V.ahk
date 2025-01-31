#Requires AutoHotkey v1.1.33+


ShowOnOff("info", "Paste with V", "Purple", 0.15, 0.0001)

v::
	Send ^v
Return




Esc::ExitApp


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
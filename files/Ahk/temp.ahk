;F8::


MsgB()
Return

MsgB()
{
Gui, -MinimizeBox +AlwaysOnTop +HWNDmsg
Gui, Add, Picture, x0 y0 w900 h800 ,L:\Diverses\Screenshots\2021-03-29 16_53_57-_new 1 - Notepad++.jpg
Gui, Add, Button, x30 y210 w40 h20 Center,Ok
Gui, Show, Center w900 h800,Msgbox
WinWaitClose,ahk_id %msg%
}

Send, {Tab}

GuiClose:
ButtonOk:
Gui,Destroy
Return

Esc::ExitApp


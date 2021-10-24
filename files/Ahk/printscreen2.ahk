; Put the below anywhere in your script that is not part of a subroutine. Not at the point where you want the actual text to appear on screen: just at the bottom of your script is fine.

F10::

OSD(Text="OSD",Colour="Blue",Duration="300",Font="Times New Roman",Size="128")
{   ; Displays an On-Screen Display, a text in the middle of the screen.
Gui, 2:Font, c%Colour% s%Size%, %Font%  ; If desired, use a line like this to set a new default font for the window.
GuiControl, 2:Font, OSDControl  ; Put the above font into effect for a control.
GuiControl, 2:, OSDControl, %Text%
Gui, 2:Show, NoActivate, OSDGui ; NoActivate avoids deactivating the currently active window; add "X600 Y800" to put the text at some specific place on the screen instead of centred.
SetTimer, OSDTimer, -%Duration%
Return 
}

OSDTimer:
Gui, 10:Show, Hide
Return

OSD("I'm an aeroplane", "Red", "500", "Arial", "50")

Esc::ExitApp

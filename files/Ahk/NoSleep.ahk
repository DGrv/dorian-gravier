;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         A.N.Other <myemail@nowhere.com>
;
; Script Function:
;	Template script (you can customize this template by editing "ShellNew\Template.ahk" in your Windows folder)
;

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Persistent

SetTimer, MoveMouse, 120000 ; Run MoveMouse every 2 minute

MoveMouse:
    MouseMove, 1, 0, 1, R  ;Move the mouse one pixel to the right
    MouseMove, -1, 0, 1, R ;Move the mouse back one pixel
	SendMessage 0x112, 0xF140, 0, , Program Manager  ; Start screensaver
	;SendMessage 0x112, 0xF170, 2, , Program Manager  ;
return
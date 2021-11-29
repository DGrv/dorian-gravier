;#z:: ; Win+Z hotkey
wd = X:\Data\Thermo

from="mailrelay@hit-discovery.local"
to="dorian.gravier@hit-discovery.com,dorian.gravier@gmail.com"
name="mailrelay"
pass="uspfhdc"
server="10.13.44.9"
subject="Thermo_Crash"
port="25"
attachment="X:\Data\Thermo\Screenshot_crop_3.jpg|X:\Data\Thermo\Screenshot_crop_2.jpg"


;For Error handling popup polara
DetectHiddenWindows, On 
DetectHiddenText, On 
SetTitleMatchMode Fast 
SetTitleMatchMode RegEx


StatusLine = Running
SentEmail = False
nTry = 0
FileAppend, Script reloaded ------------------------------------------`r`n, %wd%\Polara_Status_Logfile.txt
Loop {

	Run, X:\TEMP\Dorian\Batch_Files\NirCmd\nircmd\nircmd.exe savescreenshot X:\Data\Thermo\Screenshot_crop.jpg 413 140 30 22
	Run, X:\TEMP\Dorian\Batch_Files\NirCmd\nircmd\nircmd.exe savescreenshot X:\Data\Thermo\Screenshot_crop_2.jpg 298 871 961 66
	Run, X:\TEMP\Dorian\Batch_Files\NirCmd\nircmd\nircmd.exe savescreenshot X:\Data\Thermo\Screenshot_crop_3.jpg 280 142 833 672

	;WinActivate, ahk_exe POLARA.exe
	WinActivate, ahk_class ThunderRT6MDIForm ; get class with a ahk script, ahk_exe does not work when windo minimized
	;WinMaximize
	PixelGetColor, colorRunning, 428, 153
	Cross(1, 428, 153, 1, 30, "eaff47")
	PixelGetColor, colorWindow, 235, 102
	Cross(3, 235, 102, 1, 30, "acff47")
	PixelGetColor, colorComplete, 521, 159
	Cross(3, 521, 159, 1, 30, "0000ff")
	
	
	if( colorComplete = "0xFF0000") {
		if ( %SentEmail% = False ) {
			emailcontent = RunCompleted
			subject = RunCompleted
			Run, X:\TEMP\Software\SwithMailv2150\SwithMail.exe /s /from %from% /name %name% /pass %pass% /server %server% /p %port% /to %to% /sub %subject% /b %emailcontent% /a %attachment%
			SentEmail = True
			FileAppend, Run Completed -----------------------------`r`n, %wd%\Polara_Status_Logfile.txt
		}
	} else {
		if( colorWindow = "0xFFFFFF" OR colorWindow = "0xD8E9EC" OR colorWindow = "0xDEEBEF" OR colorWindow = "0x636163" OR colorWindow = "0x818181" OR colorWindow = "0x848284" OR colorWindow = "0x9A9A9A" OR colorWindow = "0x9C9A9C") {
			FileDelete, %wd%\Polara_Status_Maximize-window.txt
			if ( colorRunning = "0x00FF00") {
				nTry = 0
			; 	MsgBox Running
				StatusLine = Running
				FileDelete, %wd%\Polara_Status_STOP.txt
				vline(50, 210, 500, 30, 700, "38ff2e")
			}
			if ( colorRunning = "0x0000FD" OR colorRunning = "0x00FFFF" OR colorRunning = "0x848284" OR colorRunning = "0x555555" OR colorRunning = "0x808080" OR colorRunning = "0x525552") {
			;	MsgBox Run suspended
			;MsgBox nTry = %nTry%, StatusLine = %StatusLine%

				If ( nTry = 2 ) {
					If ( StatusLine = "HadaTry" ) {
						emailcontent = %namewindow%%windowtext%
						subject = %namewindow%
					}
					If ( StatusLine = "STOP" ) {
						subject = "Thermo Crash"
						emailcontent = "Polara stopped"
					}
					;MsgBox Message sent with content: %emailcontent% , namewindow = %namewindow% windowtext = %windowtext%
					Run, X:\TEMP\Software\SwithMailv2150\SwithMail.exe /s /from %from% /name %name% /pass %pass% /server %server% /p %port% /to %to% /sub %subject% /b %emailcontent% /a %attachment%
					FileAppend, Email sent %StatusLine%`r`n, %wd%\Polara_Status_Logfile.txt
				}
				
				nTry := nTry + 1
				FileAppend, Blabla, %wd%\Polara_Status_STOP.txt
				vline(50, 200, 500, 30, 700, "ff0019")
				
				If WinExist("User Pause System|POLARA: echo550|POLARA: Hamamatsu_VAL|POLARA: Lidder_Flip|POLARA: PlateLock|POLARA: Cytomat1_Flip|POLARA: Cytomat2_Flip|POLARA: Cytomat1|POLARA: Cytomat2" ) {
					
					StatusLine = HadaTry				

					If WinExist( "User Pause System" ) {
						namewindow = "User Pause System"
						WinActivate
						WinGetText, text
						windowtext := text
						lenstr := StrLen(text) ; Keep the := for using function
						FileAppend, Length string Win-%namewindow% %lenstr% char---, %wd%\Polara_Status_Logfile.txt
					}
					If WinExist( "POLARA: echo550" ) {
						namewindow = "POLARA: echo550"
						WinActivate
						WinGetText, text
						lenstr := StrLen(text) ; Keep the := for using function
						FileAppend, Length string Win-%namewindow% %lenstr% char---, %wd%\Polara_Status_Logfile.txt
						If (lenstr = 176) {
							Send {enter}
						}
					}
					If WinExist( "POLARA: Hamamatsu_VAL" ) {
						namewindow = "POLARA: Hamamatsu_VAL"
						WinActivate
						WinGetText, text
						lenstr := StrLen(text) ; Keep the := for using function
						FileAppend, Length string Win-%namewindow% %lenstr% char---, %wd%\Polara_Status_Logfile.txt
					}
					If WinExist( "POLARA: Lidder_Flip" ) {
						namewindow = "POLARA: Lidder_Flip"
						WinActivate
						WinGetText, text
						lenstr := StrLen(text) ; Keep the := for using function
						FileAppend, Length string Win-%namewindow% %lenstr% char---, %wd%\Polara_Status_Logfile.txt
						If (lenstr = 263 OR lenstr = 266) {
							Send {enter}
						}
					}
					If WinExist( "POLARA: PlateLock" ) {
						namewindow = "POLARA: PlateLock"
						WinActivate
						WinGetText, text
						lenstr := StrLen(text) ; Keep the := for using function
						FileAppend, Length string Win-%namewindow% %lenstr% char---, %wd%\Polara_Status_Logfile.txt
						If (lenstr = 223) {
							Send {enter}
						}
					}
					If WinExist( "POLARA: Cytomat1_Flip" ) {
						namewindow = "POLARA: Cytomat1_Flip"
						WinActivate
						WinGetText, text
						lenstr := StrLen(text) ; Keep the := for using function
						FileAppend, Length string Win-%namewindow% %lenstr% char---, %wd%\Polara_Status_Logfile.txt
					}
					If WinExist( "POLARA: Cytomat2_Flip" ) {
						namewindow = "POLARA: Cytomat2_Flip"
						WinActivate
						WinGetText, text
						lenstr := StrLen(text) ; Keep the := for using function
						FileAppend, Length string Win-%namewindow% %lenstr% char---, %wd%\Polara_Status_Logfile.txt
					}
					If WinExist( "POLARA: Cytomat1" ) {
						namewindow = "POLARA: Cytomat1"
						WinActivate
						WinGetText, text
						lenstr := StrLen(text) ; Keep the := for using function
						FileAppend, Length string Win-%namewindow% %lenstr% char---, %wd%\Polara_Status_Logfile.txt
					}
					If WinExist( "POLARA: Cytomat2" ) {
						namewindow = "POLARA: Cytomat2"
						WinActivate
						WinGetText, text
						lenstr := StrLen(text) ; Keep the := for using function
						FileAppend, Length string Win-%namewindow% %lenstr% char---, %wd%\Polara_Status_Logfile.txt
					}
				} else {
					StatusLine = STOP
				}
				
			}
		} else {
			FileDelete, %wd%\Polara_Status_STOP.txt
			FileAppend, Blabla, %wd%\Polara_Status_Maximize-window.txt
			StatusLine = MaxWindow
			vline(50, 200, 500, 30, 700, "949e93")
		}
		
		FileAppend, colorRunning:%colorRunning%`tcolorWindow:%colorWindow%`tcolorComplete:%colorComplete%`tStatusLine:%StatusLine%`tnTry:%nTry%`r`n, %wd%\Polara_Status_Logfile.txt

		
	}
	Sleep, 10000
}
return


; -------------Function-----------------


Cross(n,x,y, width, length, color){
	hline(n,x,y, width, length, color)
	vline(n+1,x,y, width, length, color)
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

pause::Pause,Toggle
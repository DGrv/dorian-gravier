Msgbox Use Ctrl+y to write in C:\Users\doria\Downloads\list_copy_ahk.txt

^y::
Send ^c
ClipWait  
FileAppend, %clipboard%, C:\Users\buero.BSPM\Dropbox\Shared_Dorian\AHK\list_copy_ahk.txt
FileAppend, `n, C:\Users\buero.BSPM\Dropbox\Shared_Dorian\AHK\list_copy_ahk.txt

pause::

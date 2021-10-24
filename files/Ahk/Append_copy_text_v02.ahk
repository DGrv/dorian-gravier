#Persistent
Clipboard =
OnClipboardChange:
If A_EventInfo = 1
{
FileAppend, %clipboard%, C:\Users\doria\Dropbox\Shared_Dorian\AHK\list_copy_ahk.txt
FileAppend, `n, C:\Users\doria\Dropbox\Shared_Dorian\AHK\list_copy_ahk.txt
}
Return

; source: https://autohotkey.com/board/topic/96876-can-i-append-the-current-clipboard-to-the-clipboard-with-onclipboardchange/


#Persistent
Clipboard =
OnClipboardChange:
If A_EventInfo = 1
{
If Clipboard = %Current%
Return
Current := Current "`n" Clipboard
Clipboard := Current
}
Return

Esc::ExitApp

; source: https://autohotkey.com/board/topic/96876-can-i-append-the-current-clipboard-to-the-clipboard-with-onclipboardchange/


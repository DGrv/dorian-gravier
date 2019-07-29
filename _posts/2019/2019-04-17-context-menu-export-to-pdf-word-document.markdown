---
layout: "post"
title: "Context menu export to pdf word document"
date: "2019-04-17 15:57"
---

I prefer to read pdf than word document. Word is for me only if the document is unfinished but if I want to look for something, pdf are for me much better and safer (you can not change something there).

When I see word file laying arounf I wanna convert them fast in pdf.
Best way I found is to install a context menu (right click) with .docx document.

Here how to do:

Create a macro in your 'Normal.dotm' file. Normally available under *C:\Users\**username**\AppData\Roaming\Microsoft\Templates*

Example :

```shell
Sub export2pdf()
    Application.ActiveProtectedViewWindow.Edit ' Allow editing of the document wihtout this line the macro will not work
    ChangeFileOpenDirectory ThisDocument.Path
    ActiveDocument.ExportAsFixedFormat _
        OutputFileName:=Left(ActiveDocument.FullName, InStrRev(ActiveDocument.FullName, ".")) + "pdf", _
        ExportFormat:=wdExportFormatPDF, _
        OpenAfterExport:=True, _
        OptimizeFor:=wdExportOptimizeForPrint, _
        Range:=wdExportAllDocument, _
        From:=1, _
        To:=1, _
        Item:=wdExportDocumentContent, _
        IncludeDocProps:=True, _
        KeepIRM:=True, _
        CreateBookmarks:= _
        wdExportCreateHeadingBookmarks, _
        DocStructureTags:=True, _
        BitmapMissingFonts:=True, _
        UseISO19005_1:=False
    Application.Quit SaveChanges:=wdDoNotSaveChanges
End Sub
```

This macro would be then accessible by all word document you use.

Add the context menu via a .reg file (copy this in a txt file and save it as .reg, run it)

```
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\Word.Document.8\shell\Export2pdf]
@="Export2pdf"

[HKEY_CLASSES_ROOT\Word.Document.8\shell\Export2pdf\command]
@="\"C:\\Program Files\\Microsoft Office 15\\root\\Office15\\WINWORD.EXE\" /mexport2pdf /q \"%1\""

[HKEY_CLASSES_ROOT\Word.Document.12\shell\Export2pdf]
@="Export2pdf"

[HKEY_CLASSES_ROOT\Word.Document.12\shell\Export2pdf\command]
@="\"C:\\Program Files\\Microsoft Office 15\\root\\Office15\\WINWORD.EXE\" /mexport2pdf /q \"%1\""

[HKEY_CLASSES_ROOT\Word.Document.6\shell\Export2pdf]
@="Export2pdf"

[HKEY_CLASSES_ROOT\Word.Document.6\shell\Export2pdf\command]
@="\"C:\\Program Files\\Microsoft Office 15\\root\\Office15\\WINWORD.EXE\" /mexport2pdf /q \"%1\""

[HKEY_CLASSES_ROOT\Word.Document\shell\Export2pdf]
@="Export2pdf"

[HKEY_CLASSES_ROOT\Word.Document\shell\Export2pdf\command]
@="\"C:\\Program Files\\Microsoft Office 15\\root\\Office15\\WINWORD.EXE\" /mexport2pdf /q \"%1\""

```


Source:

- [https://superuser.com/questions/541357/add-right-click-save-as-pdf-in-windows-explorer](https://superuser.com/questions/541357/add-right-click-save-as-pdf-in-windows-explorer)
- [https://stackoverflow.com/questions/31042383/vba-to-enable-editing](https://stackoverflow.com/questions/31042383/vba-to-enable-editing)

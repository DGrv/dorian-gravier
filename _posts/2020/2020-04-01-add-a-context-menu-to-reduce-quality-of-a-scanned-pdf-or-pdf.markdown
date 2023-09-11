---
title: "Add a context menu to reduce quality of a scanned pdf (or pdf)"
date: "2020-04-01 21:09"
comments_id: 34
---

I have already done 2 posts for adding a context menu for [convertir jpeg to pdf](/2019/03/02/add-a-context-menu-for-a-specific-extension-right-click.html) and [word to pdf](/2019/04/17/context-menu-export-to-pdf-word-document.html).
Right now I found something interesting to reduce the quality of pdf when you can a document.
As you know when you scan a document and convert it in pdf (usually already the case), you get a pretty heavy file. In essence this is just a pdf with a image with a certain dpi.

Without going into details (I do not know them anyway), this context menu will use a command to reduce the quality of those images and reducing a lot the weight of your pdf.
The software use behind is [Ghostscript](https://www.ghostscript.com/). I found the command on [Ask-Ubuntu](https://askubuntu.com/questions/113544/how-can-i-reduce-the-file-size-of-a-scanned-pdf-file).
And the idea came for the little freeware [freepdfcompressort](http://www.freepdfcompressor.com/) where actually I could try the efficiency of this command (I guess it is a pretty similar one).

I decided to create only 3 context menus (next step will be to use a cascade menu :)). Only the first 3:

![Picture](../assets/20200401_picture_1.jpg)




```shell
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\SystemFileAssociations\.pdf\shell\Reduce PDF Quality 72 dpi - Screen\command]
@="\"P:\\software\\PortableApps\\Ghostscript\\bin\\gswin64c.exe\" -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH -sOutputFile=\"%1_screen.pdf\" \"%1\""

[HKEY_CLASSES_ROOT\SystemFileAssociations\.pdf\shell\Reduce PDF Quality 150 dpi - eBook\command]
@="\"P:\\software\\PortableApps\\Ghostscript\\bin\\gswin64c.exe\" -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=\"%1_ebook.pdf\" \"%1\""

[HKEY_CLASSES_ROOT\SystemFileAssociations\.pdf\shell\Reduce PDF Quality 300 dpi - Printer\command]
@="\"P:\\software\\PortableApps\\Ghostscript\\bin\\gswin64c.exe\" -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dNOPAUSE -dQUIET -dBATCH -sOutputFile=\"%1_printer.pdf\" \"%1\""
```

Here the result.
![Picture2](../assets/20200401_picture_2.jpg)



[Here the reg file](/files/Context_menu/Add_Context-Menu_Reduce-PDF-Quality_with_Ghostscript.reg)

[And the usefull files if needed](/files/Context_menu/Ghostscript_2files_toreduce_pdf_quality.zip)

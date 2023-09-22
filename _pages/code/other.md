---
title: "Other"
permalink: /code/other/
toc: true
author_profile: false
layout: code
---


# Add context menu (right clik) for files

The only good solution I found a really working is : https://superuser.com/questions/1097054/shell-context-menu-registry-extension-doesnt-work-when-default-program-is-other

Add keys in HKEY_CLASSES_ROOT\\**your.extension**\shell Modify the last key with the command you wanna do.

For my purpose it was :

`"C:\Program Files (x86)\GPSBabel\gpsbabel.exe" -r -i gpx -f "%1" -x simplify,count=1000 -o gpx -F "%1.gpx"`

If I export the it I get a .reg :

    [HKEY_CLASSES_ROOT\SystemFileAssociations\.gpx\shell\Simplify gpx\command]
    @="\"C:\\Program Files (x86)\\GPSBabel\\gpsbabel.exe\" -r -i gpx -f \"%1\" -x simplify,count=1000 -o gpx -F \"%1.gpx\""

I created for example a small reg file to be able to convert rapidly my gpx. I guess a dropdown menu is possible but I was satisfied with this:

    [HKEY_CLASSES_ROOT\SystemFileAssociations\.gpx\shell\Simplify gpx 500pts\command]
    @="\"C:\\Program Files (x86)\\GPSBabel\\gpsbabel.exe\" -r -i gpx -f \"%1\" -x simplify,count=500 -o gpx -F \"%1_500.gpx\""

    [HKEY_CLASSES_ROOT\SystemFileAssociations\.gpx\shell\Simplify gpx 250pts\command]
    @="\"C:\\Program Files (x86)\\GPSBabel\\gpsbabel.exe\" -r -i gpx -f \"%1\" -x simplify,count=250 -o gpx -F \"%1_250.gpx\""

    [HKEY_CLASSES_ROOT\SystemFileAssociations\.gpx\shell\Simplify gpx 100pts\command]
    @="\"C:\\Program Files (x86)\\GPSBabel\\gpsbabel.exe\" -r -i gpx -f \"%1\" -x simplify,count=100 -o gpx -F \"%1_100.gpx\""

[Posted on Stackoverflow](https://stackoverflow.com/a/54953717/2444948)

# Get event sleep hibernate active battery windows 10

```batchfile
powercfg /sleepstudy
```

Sleep Study report saved to file path C:-report.html.

Source: <https://superuser.com/questions/1258473/display-all-power-related-events-turn-on-off-sleep-hibernate>

# HTML

# Image adjustement via css filter and slider

I discovered that the user can have the possibility to modify image (brightness, contrast and so on - [more info here](https://www.w3schools.com/cssref/css3_pr_filter.asp)).

I finally wrote with help of google and all those nice programmers posting () a little script giving the possibility to modify the brigntess of all ‘img’ balise in a html page.

``` js
<div class="slidecontainer">
    <input type="range" min="-500" max="1000" value="10" class="slider" id="myRange">
<p><font color="white">Brightness (%): <span id="demo"></span></font></p>
</div>

<button onclick="reset()">Reset</button><br><br>

<script>
    function reset() {
        var input = document.getElementsByTagName("img");
        var inputList = Array.prototype.slice.call(input);
        for(i = 0;i < inputList.length; i++) {
            inputList[i].style = "filter: brightness(100%)";
        };
    };

    var slider = document.getElementById("myRange");
    var output = document.getElementById("demo");
    output.innerHTML = slider.value;
    slider.oninput = function() {
        output.innerHTML = this.value;
        var input = document.getElementsByTagName("img");
        var inputList = Array.prototype.slice.call(input);
        for(i = 0;i < inputList.length; i++) {
            inputList[i].style = "filter: brightness(" + this.value + "%)";
        };
    };

</script>
```

Here a little example:

<div class="example">

    <div class="slidecontainer">
        <input type="range" min="-500" max="1000" value="10" class="slider" id="myRange">
    <p><font color="white">Brightness (%): <span id="demo"></span></font></p>

</div>

    <button onclick="reset()">Reset</button><br><br>

    <script>
        function reset() {
            var input = document.getElementsByTagName("img");
            var inputList = Array.prototype.slice.call(input);
            for(i = 0;i < inputList.length; i++) {
                inputList[i].style = "border-radius: 0px; box-shadow: none; filter: brightness(100%)";
            };
        };

        var slider = document.getElementById("myRange");
        var output = document.getElementById("demo");
        output.innerHTML = slider.value;
        slider.oninput = function() {
            output.innerHTML = this.value;
            var input = document.getElementsByTagName("img");
            var inputList = Array.prototype.slice.call(input);
            for(i = 0;i < inputList.length; i++) {
                inputList[i].style = "border-radius: 0px; box-shadow: none; filter: brightness(" + this.value + "%)";
            };
        };

    </script>

<tr>
<td id="tableHTML_column_3">
<img style="border-radius: 0px; box-shadow: none" src='/assets/images/microscope/001001000Channel1_0.jpg'  />
</td>

        <td id="tableHTML_column_4"><img style="border-radius: 0px; box-shadow: none" src='/assets/images/microscope/001002000Channel1_0.jpg'  />   </td>
        <td id="tableHTML_column_5"><img style="border-radius: 0px; box-shadow: none" src='/assets/images/microscope/001003000Channel1_0.jpg'  />   </td></tr>

<tr>
<td id="tableHTML_column_3">
<img style="border-radius: 0px; box-shadow: none" src='/assets/images/microscope/001001000Channel1_1.jpg'  />
</td>

        <td id="tableHTML_column_4"><img style="border-radius: 0px; box-shadow: none" src='/assets/images/microscope/001002000Channel1_1.jpg'  />   </td>
        <td id="tableHTML_column_5"><img style="border-radius: 0px; box-shadow: none" src='/assets/images/microscope/001003000Channel1_1.jpg'  />   </td></tr>

<tr>
<td id="tableHTML_column_3">
<img style="border-radius: 0px; box-shadow: none" src='/assets/images/microscope/001001000Channel1_2.jpg' />
</td>

        <td id="tableHTML_column_4"><img style="border-radius: 0px; box-shadow: none" src='/assets/images/microscope/001002000Channel1_2.jpg' />    </td>
        <td id="tableHTML_column_5"><img style="border-radius: 0px; box-shadow: none" src='/assets/images/microscope/001003000Channel1_2.jpg' />    </td></tr>

</div>

# Office

# Add a context menu to right click export to pdf

I prefer to read pdf than word document. Word is for me only if the document is unfinished but if I want to look for something, pdf are for me much better and safer (you can not change something there).

When I see word file laying arounf I wanna convert them fast in pdf. Best way I found is to install a context menu (right click) with .docx document.

Here how to do:

Create a macro in your ‘Normal.dotm’ file. Normally available under \*C:\\**username**

Example :

```batchfile
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

For Office 365 it will be :

    Windows Registry Editor Version 5.00

    [HKEY_CLASSES_ROOT\Word.Document.8\shell\Export2pdf]
    @="Export2pdf"

    [HKEY_CLASSES_ROOT\Word.Document.8\shell\Export2pdf\command]
    @="\"C:\\Program Files\\Microsoft Office\\root\\Office16\\WINWORD.EXE\" /mexport2pdf /q \"%1\""

    [HKEY_CLASSES_ROOT\Word.Document.12\shell\Export2pdf]
    @="Export2pdf"

    [HKEY_CLASSES_ROOT\Word.Document.12\shell\Export2pdf\command]
    @="\"C:\\Program Files\\Microsoft Office\\root\\Office16\\WINWORD.EXE\" /mexport2pdf /q \"%1\""

    [HKEY_CLASSES_ROOT\Word.Document.6\shell\Export2pdf]
    @="Export2pdf"

    [HKEY_CLASSES_ROOT\Word.Document.6\shell\Export2pdf\command]
    @="\"C:\\Program Files\\Microsoft Office\\root\\Office16\\WINWORD.EXE\" /mexport2pdf /q \"%1\""

    [HKEY_CLASSES_ROOT\Word.Document\shell\Export2pdf]
    @="Export2pdf"

    [HKEY_CLASSES_ROOT\Word.Document\shell\Export2pdf\command]
    @="\"C:\\Program Files\\Microsoft Office\\root\\Office16\\WINWORD.EXE\" /mexport2pdf /q \"%1\""

Source:

- <https://superuser.com/questions/541357/add-right-click-save-as-pdf-in-windows-explorer>
- <https://stackoverflow.com/questions/31042383/vba-to-enable-editing>
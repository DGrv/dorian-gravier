---
title: "Add a context menu for a specific extension (right-click)"
date: "2019-03-02 00:32"
comments_id: 	17
---

The only good solution I found a really working is : https://superuser.com/questions/1097054/shell-context-menu-registry-extension-doesnt-work-when-default-program-is-other

Add keys in HKEY_CLASSES_ROOT\SystemFileAssociations\\**your.extension**\\shell\command
Modify the last key with the command you wanna do.

For my purpose it was :

`"C:\Program Files (x86)\GPSBabel\gpsbabel.exe" -r -i gpx -f "%1" -x simplify,count=1000 -o gpx -F "%1.gpx"`


If I export the it I get a .reg :


```
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\SystemFileAssociations\.gpx\shell\Simplify gpx\command]
@="\"C:\\Program Files (x86)\\GPSBabel\\gpsbabel.exe\" -r -i gpx -f \"%1\" -x simplify,count=1000 -o gpx -F \"%1.gpx\""
```

I created for example a small reg file to be able to convert rapidly my gpx. I guess a dropdown menu is possible but I was satisfied with this:

```
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\SystemFileAssociations\.gpx\shell\Simplify gpx 500pts\command]
@="\"C:\\Program Files (x86)\\GPSBabel\\gpsbabel.exe\" -r -i gpx -f \"%1\" -x simplify,count=500 -o gpx -F \"%1_500.gpx\""

[HKEY_CLASSES_ROOT\SystemFileAssociations\.gpx\shell\Simplify gpx 250pts\command]
@="\"C:\\Program Files (x86)\\GPSBabel\\gpsbabel.exe\" -r -i gpx -f \"%1\" -x simplify,count=250 -o gpx -F \"%1_250.gpx\""

[HKEY_CLASSES_ROOT\SystemFileAssociations\.gpx\shell\Simplify gpx 100pts\command]
@="\"C:\\Program Files (x86)\\GPSBabel\\gpsbabel.exe\" -r -i gpx -f \"%1\" -x simplify,count=100 -o gpx -F \"%1_100.gpx\""
```

[Posted on Stackoverflow](https://stackoverflow.com/a/54953717/2444948)


Edit:

New example to convert jpg file to pdf via Magick

```
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\SystemFileAssociations\.jpg\shell\Convert to pdf\command]
@="\"H:\\TEMP\\Software\\Pictures\\ImageMagick-7.0.8-28-portable-Q16-x86\\magick.exe\" convert \"%1\" \"%1.pdf\""
```


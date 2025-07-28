for /f %%H in ('magick identify -format "%%h" Logo.png') do set width1=%%H
for /f %%W in ('magick identify -format "%%w" Logo.png') do set /a halfW=%%W / 2
magick Logo.png -crop %halfW%x%width1%+0+0 +repage cropped.png
magick RR.png -resize x%width1% resized.png
magick convert +append cropped.png resized.png Whatsapp.png
del cropped.png
del resized.png
    

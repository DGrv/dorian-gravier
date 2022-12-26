from PIL import Image
import os
import re

path = input("Give me a folder path :\n")
question = input("It will overwrite your pictures are you ok ? [y/n]\n")

path = path.replace("\\", "/")
os.chdir(path)



if question == "y":
    list = os.listdir(path)
    list = [x for x in list if re.match(".*png", x)]
    n = len(list)
    counter = 1
    for x in list:
        im = Image.open(x)
        # im.size
        # im.getbbox()  # (64, 89, 278, 267)
        im2 = im.crop(im.getbbox())
        # im2.size  # (214, 178)
        im2.save(x)
        # to fix PNG IDAT error chunk https://superuser.com/questions/1160962/fixing-corrupt-pngs-missing-the-iend-chunk
        im = Image.open(x)
        im.save(x)
        print(counter, "/", n)
        counter = counter + 1
    
    
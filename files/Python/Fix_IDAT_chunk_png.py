from PIL import Image
import os
import re

path = input("Give me a folder path :\n")

path = path.replace("\\", "/")
os.chdir(path)

# exec(open("C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/Python/Fix_IDAT_chunk_png.py").read())

list = os.listdir(path)
list = [x for x in list if re.match(".*png", x)]
n = len(list)
counter = 1
for x in list:
    # to fix PNG IDAT error chunk https://superuser.com/questions/1160962/fixing-corrupt-pngs-missing-the-iend-chunk
    im = Image.open(x)
    im.save(x)
    print(counter, "/", n)
    counter = counter + 1

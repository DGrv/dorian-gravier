---
title: "Python"
permalink: /code/python/
toc: true
author_profile: false
layout: code
---



# Function

\*\* TO FINISH \*\*

``` python
# dictionary used to map from wells (A1, B2, etc) to the actual numbers (0, 1, ...)
# for Kinetics

def createWellIDDic(wellCount):
    rowlist = map(chr, range(65, 65 + 26)) + ['A' + s for s in map(chr, range(65, 65 + (32 - 26)))]
    wellIDDic = {}
    for row in range(rowCount):
        for col in range(columnCount):
            colText = str(col+1)
            if len(colText) == 1:
                colText = "0"+colText
            wellIDDic[rowlist[row]+colText] = int(int(row)*columnCount +int(col)) # A start at chr(65)
    return wellIDDic


#Method used to create an empity plate where to store the values
def createEmptyPlate(layerCount):
    empty = []
    for j in range(0, layerCount):
      empty2=[]
      for i in range(wellCount):
        empty2.append("NaN")
      empty.append(empty2)
    return empty



# function to get unique values
def unique(list1):
    # intilize a null list
    unique_list = []
    # traverse for all elements
    for x in list1:
        # check if exists in unique_list or not
        if x not in unique_list:
            unique_list.append(x)
        # print list
    for x in unique_list:
        return x


def whichCol(list1, string1): # function to find for a list of string where is a specific string (id)
    for i in range(0, len(list1)):
        if (string1 in list1[i]):
            temp = i
            return temp

def grep(yourlist, yourstring):
    ide = [i for i, item in enumerate(yourlist) if re.search(yourstring, item)]
    return ide
```

# Tips

## gsub R equivalent in python (extract regex group)

``` python
barcode = re.sub("([0-9]*)_(.*)_([0-9]*)_([0-9]*)_(.*)", "\\5", barcode)
```

## Replace certain string in all element from a list

``` python
content2 = [w.replace('"', '') for w in content] # replace all quotes and remove first row
```

## Convert unicode string to string

``` python
a = u"jkasdkhasd"
a.encode('ascii','ignore')
```

## Apply function to all item from a list

``` python
map(function, yourlist)
```

Source: https://stackoverflow.com/questions/25082410/apply-function-to-each-element-of-a-list

## Concat a string to each item of a list

``` python
[s + mystring for s in mylist]
```

Source: https://stackoverflow.com/questions/2050637/appending-the-same-string-to-a-list-of-strings-in-python

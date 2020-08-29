---
layout: "post"
title: "Create a pdf from a batch of photos, batch convertion jpg to pdf, scan a book with a camera"
date: "2020-08-29 09:00"
comments_id: 41
---

This technique may be used for special occasion but I do not recommend to do it for scanning an entire book.

The process is simple and usually this can be done quickly with a Smartphone and dedicated apps.
However to keep the quality and to gain in speed I decided to scan a book via a mirror reflex (Camera), crop them and reduce the quality of the picture in batch and convert them in 1 pdf.

I would use then for this:

- Irfanview or ImageMagick for rotation if needed
- Irfanview for the croping and resizing
- [Gow](https://github.com/bmatzelle/gow)
- ImageMagick for the convertion in pdf, 


__*Steps:*__

- Rotation using ImageMagick
	- `shell 	mogrify -rotate "-90" *.jpg`
- Crop and resize with Irfanview. It is done in batch, meaning that the position your book in your picture should stay the same throughout the all process.
	- Open Irfanview
	- Open a picture and select what you wanna crop
	- Press B or menu File/Batch Conversion rename ...
	- Select Conversion, select your output format (jpg)
	- Use Advanced options and define then: Click on Advanced
		- Select crop (click on "get current selection")
		- Select resize, set a new size in percentage (up to you, you have to try)
	- Select your files
	- Select your output folder (other folder that input)
	- Start Batch
- Convert in pdf with ImageMagick
	- Open a command prompt in the folder where your crop and resized pictures are
	- Run `shell for /F "usebackq delims=" %A in (`ls ^|grep -s jpg ^| tr "\n" " "`) do convert -quality 85 %A output.pdf
`
		- `ls ^|grep -s jpg ^| tr "\n" " "` will get the file of the jpg and put them in 1 line
		- the rest will convert it, I need to use a loop because windows is not as flexible as linux to pass the output of a cmd as parameter for another one.
	


__*Source:*__

- Info on Gow and other linux tools : https://tinyapps.org/blog/201606040700_tiny_unix_tools_windows.html
- https://askubuntu.com/questions/303849/create-a-single-pdf-from-multiple-text-images-or-pdf-files/887953?newreg=46666755550348dfa59952b528b90745
- https://stackoverflow.com/questions/43225925/windows-cmd-pass-output-of-one-command-as-parameter-to-another


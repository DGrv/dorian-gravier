---
layout: post
title: Export vectors information from OSM, add elevation profiles with SRTM and convert to Adobe Illustrator
---

Source: http://UNSET/blog/export-vectors-information-from-osm-add-elevation-profiles-with-srtm-and-convert-to-adobe-illustrator

A friend was in the past preparing a master thesis in architecture. She is working on a foreign area and the language make the access to plans a bit more difficult than usually.  
  
In order to help her i decided to have a look what were the possibilities to get detailed data from open sources. [OpenStreetMap](http://www.openstreetmap.org/) of course. After several google research, and different test I finally found one option that was as detailed as requested.   
I did not invent it and all information are mainly coming from the website of "ulrik". Thanks to him :  
[Hacking Urban Planning with OpenStreetMap and SRTM](https://ulrik.is/writing/using-openstreetmap-and-srtm-data-for-urban-planning/)  
  
What is interesting here is those information could be exported in other format like shape file, kmz or other nice extension for GIS software.  
However what I am explaining now is certainly highly directed to people working for urban planing.  
  
So let's begin.

#Getting Elevation data : SRTM


Hmmm let's ask wikipedia :  
_The **Shuttle Radar Topography Mission** (**SRTM**) is an international research effort that obtained [digital elevation models](https://en.wikipedia.org/wiki/Digital_elevation_model) on a near-global scale from 56° S to 60° N,[\[2\]](https://en.wikipedia.org/wiki/Shuttle_Radar_Topography_Mission#cite_note-NikP2-2) to generate the most complete high-resolution digital topographic database of Earth prior to the release of the [ASTER GDEM](https://en.wikipedia.org/wiki/ASTER_GDEM) in 2009. _  
...  
_The elevation models derived from the SRTM data are used in [Geographic Information Systems](https://en.wikipedia.org/wiki/Geographic_Information_Systems). They can be downloaded freely over the Internet, and their file format (.hgt) is supported by several software developments._  
  
  
OSM created a great tool to extract incredibly easily those information : [Srtm2Osm](http://wiki.openstreetmap.org/wiki/Srtm2Osm) (why making it complicated...).  
  
  
Then :   

- Download [Srtm2Osm](http://osm.michis-pla.net/code/Srtm2Osm-1.12.1.0.zip)  
- Extract it  
- Go in the folder where strm2osm.exe is, in the explorer   
- Alt-D -> type in the adress bar "cmd" and click enter  
- You should have now a command prompt with the path of where you were in the explorer  
- Now you will need to run some code :  
  
  
Whitout entering in detail, here the syntax to use :   
_**Srtm2Osm.exe -bounds2 <latitude> <longitude> <area> -step <stepsize> -o output.osm**_  
  
Latitude and longitude is the center of the area you wanna download, area the area in square km and stepsize in the detail you want. For example 1 will give you elevation lines every 1m.  
  
Example :  

 ![Photo][assets/1094120_orig.jpg](assets/1094120_orig.jpg) 

 ![Photo][assets/6888434_orig.jpg](assets/6888434_orig.jpg) 

This will create a .osm file with the name specified that you will open with [JOSM](https://josm.openstreetmap.de/)...

# Load SRTM data in JOSM and import OSM data

An easy way to download at a small scale OSM data is with [JOSM](https://josm.openstreetmap.de/) which is an extensible editor for [​OpenStreetMap](https://www.openstreetmap.org/) (OSM) written in [​Java](https://www.java.com/) 7.  
Download it, install it and  open it.  
  
Let's first have a look to our elevation data :   

- just open the osm file created via josm

 ![Photo][assets/905061_orig.jpg](assets/905061_orig.jpg) 

Then it is time to download the data from the area you are interested in :  

- File\\Download from OSM  
- Choose you area  
- Download  

 ![Photo][assets/7874726_orig.jpg](assets/7874726_orig.jpg) 

You now have 2 layers that you can merge via the merge button :  
  

 ![Photo][assets/97958_orig.jpg](assets/97958_orig.jpg) 

Save the project osm.  
  

# Conversion in .ai


For this part you will need [Perl](https://www.perl.org/).  
Download, install and open the command line.  
You need to install a special module by running : **cpan Geo::Coordinates::OSGB**  
Once ready you will need to download a great tool from OSM again : [osm2ai.pl](https://nuxx.net/files/osm2ai.pl).  
Save it where you have you .osm file.  
Open a command prompt as described before where your .osm and osm2ai.pl are.  
Run : **perl osm2ai.pl --input <inputfile.osm> --output <illustrator-file.ai>**  
  
  
>>>> Done you have your .ai files with different layers:  
  

 ![Photo][assets/838468174.png](assets/838468174_orig.png) 

#Elevation missing and not enough detailed


Mmmm you would like the elevation of course and maybe to have more divided layers.  
Then first go back to JOSM. Identify the tag of the layers you are interested in :  
  

 ![Photo][assets/5900834_orig.jpg](assets/5900834_orig.jpg) 

Why not building, architects are interested in buildings right ?  
We will now create a .txt file that will tell the osm2ai.pl script to differentiate the entity with the tag we want.  
Here the help of the script on the subject :  
  

* * *

Options : <--filters> filename  
  
Specifies a file containing a list of 'filters'. These are   
used to put appropriately tagged ways in the right layers.  
  
  
FILTERS  
Rather than just bunching everything into one layer, this  
script can filter by tag. So you could put primary roads in   
one layer, secondary in another, and ignore canals   
completely.  
  
Create a plain text file, and add lines like this:  
  
motorway: highway=motorway  
  
Means "put ways tagged with highway=motorway in a 'motorway'   
layer".  
  
railway: railway=\*  
  
Means "put ways with any railway tag whatsoever in a 'railway'   
layer.  
  
other: =  
  
Means "put anything else in an 'other' layer".  
  
The tests are carried out in the order you give them. A way   
will only ever be put into one layer, even if it fulfils   
two conditions.

* * *

Here an example, [file available here](assets/d_filters.txt) :   
_railway: railway=\*  
motorway: highway=motorway  
trunk: highway=trunk  
primary: highway=primary  
secondary: highway=secondary  
tertiary: highway=tertiary  
residential: highway=residential  
unclassified: highway=unclassified  
path: highway=path  
track: highway=track  
other highway: highway=\*  
coastline: natural=coastline  
beach: natural=beach  
scrub: natural=scrub  
natural: natural=\*  
waterway: waterway=\*  
elevation: contour=\*  
building: building=\*  
Wood: wood=\*  
Name: name=\*  
other: =_  
  
  
Now you just have to put your .txt in the folder with your .osm data, the osm2ai.pl script, open a cmd prompt and run :same code as before with the --filter option:  
**perl osm2ai.pl --input <inputfile.osm> --output <illustrator-file.ai> ****\--filter D\_filters.txt**  
  

 ![Photo][assets/6634892_orig.jpg](assets/6634892_orig.jpg) 

Isn't that nice :)

 ![Photo][assets/7107445_orig.jpg](assets/7107445_orig.jpg) 

Save it in .dxf and work with ArchiCad :)  
Have fun.
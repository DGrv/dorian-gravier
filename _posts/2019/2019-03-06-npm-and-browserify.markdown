---
layout: "post"
title: "npm and browserify"
date: "2019-03-06 15:58"
---

I faced a problem by continuing tp program on the leaflet page of the webpage.
My goal is to give the possibility to draw gpx (or at the end to export gpx) following roads. I choose the open solution from [GraphHopper](https://www.graphhopper.com/). You can see a first test [here](/2019/03/02/leaflet-graphhopper-test.html).

This CodePen is actually a hack of the real lrm-graphhopper ... I say a hack, it is here meaning a dirty non sense of a noobie that I am or was :p.
I posted an [issue](https://github.com/perliedman/lrm-graphhopper/issues/26) on the github of this repository. And got great answer where I could start new things to learn.

In summary I learn the existence of Node.js and npm. A tool ... blabla, let's ask google, or our friend [Stackoverflow](https://stackoverflow.com/a/31930422/2444948).
Then I landed on [browserify](http://browserify.org/#install).
Try to understand the all thing and begin to try it out:

- install Node.js
- create a package with `npm init`
- install my first package: `npm install lrm-graphhopper`
- install browserify `npm install -g browserify`
  - here the g is meaning global, so it will be accessible to all your new package that you will create
- learn how to use it [here](https://scotch.io/tutorials/getting-started-with-browserify)
  - You will have to add the path of where your browserify is to your PATH. Check the [batch file](/Code.html#add-variable-to-system-variable-path-windows) I created to do such things rapidly. Mine was in *C:\Users\gravier\AppData\Roaming\npm*
- use it `browserify L.Routing.GraphHopper.js -o bundle.js`
  - *bundle.js* is then here your output that you will be able to use in your html code
  - for this example `<script src="bundle.js"></script>`

--- 
title: "Create_UML_diagram_with_d2" 
date: "2024-04-29 17:28" 
comments_id: 85
--- 

How to create nice diagram from text files.

Use [d2](https://d2lang.com/), you can install it via [scoop](https://scoop.sh/)

# d2

```sh
d2 -w your.d2 your.svg
```

edit your d2 file and see the result in the browser

# export in png

[Source](https://stackoverflow.com/a/26048343/2444948)

```sh
npm install svgexport -g
svgexport input.svg output.png 64x

```


# Example

```txt
vars: {
  d2-config: {
    layout-engine: dagre
	sketch: true
	theme-id: 301
	theme-overrides: {
      B2: "#E73331"
	  B1: "#E73331"
	  B4: "#fad2d1"
	  
    }
  }
}

grid-columns: 2

H: Hardware

H: {
class: block
	C: Computer
	C.style.font-size: 30
	C.shape: diamond
	
	S: Switch
	S.style.font-size: 30
	S.shape: hexagon

	Ca: Camera
	Ca.style.font-size: 30
	P: Power Box for \nCamera (POI)
	P.style.font-size: 30

	D: Decoder
	D.style.font-size: 30

	I: InfraRed
	I.shape: circle
}

Ce: Explanation
Ce.style.stroke-dash: 5
Ce: {
	grid-columns: 1
	C1.shape: image
	C2.shape: image
	C3.shape: image
	C1.icon: C:/Users/doria/Downloads/Drive/RR/Software/Camera_IR_diagram/IDCamPro__settings__001.png
	C2.icon: C:/Users/doria/Downloads/Drive/RR/Software/Camera_IR_diagram/IDCamPro__settings__003.png
	C3.icon: C:/Users/doria/Downloads/Drive/RR/Software/Camera_IR_diagram/IDCamPro__settings__002.png
	C1.width: 1200
	C2.width: 1200
	C3.width: 1200
	C1.height: 400
	C2.height: 400
	C3.height: 400
	
	C1->C2->C3
}

De: Explanation
De.style.stroke-dash: 5
De: {
	grid-columns: 1
	D2.shape: image
	D3.shape: image
	D2.icon: C:/Users/doria/Downloads/Drive/RR/Software/Camera_IR_diagram/IMG_20240429_095340.jpg
	D3.icon: C:/Users/doria/Downloads/Drive/RR/Software/Camera_IR_diagram/IMG_20240429_095356.jpg
	D2.width: 1100
	D3.width: 1100
	D2.height: 300
	D3.height: 300
}

Ie: Explanation
Ie.style.stroke-dash: 5
Ie: {
	grid-columns: 2
	
	explanation: |md
		## Turn on or off
		- Keep pressing the On/Off button until the led turn green
		- Release
		- Press again and keep pressing, led turns orange, until led turn red
		## Config
		All led should be on with the config button
		## Cable 
		Try to switch the 2 cable if it is not working (blue and black)
	|  {
		width: 500
	}
	I1
	I2 
	I1.shape: image
	I2.shape: image
	I1.icon: C:/Users/doria/Downloads/Drive/RR/Software/Camera_IR_diagram/IMG_20240429_095135.jpg
	I2.icon: C:/Users/doria/Downloads/Drive/RR/Software/Camera_IR_diagram/IMG_20240429_095225.jpg
	I1.height: 300
	I2.width: 400
	I2.height: 400
}

H: {
	S <-> D: lan
	S <-> P <-> Ca: lan
	D <-> I: IR cable
	S <-> C : lan
}

H.C -> Ce { style: {stroke-dash: 5}}
H.I -> Ie { style: {stroke-dash: 5}}
H.D -> De { style: {stroke-dash: 5}}

```

![](https://dgrv.github.io/dorian-gravier/assets/images/posts/2024/RR_diagram_Camera-IR-Decoder.png)
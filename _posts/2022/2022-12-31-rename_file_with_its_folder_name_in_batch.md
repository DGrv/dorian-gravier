--- 
title: "Rename files with its folder name" 
date: "2022-12-31 22:20" 
comments_id: 63
--- 
 
Let's imagine we have folders like this :

```console
C:.
│
├───Etape_1_Bike_Trip_2022_Vosges_to_Morvan_AUDIO
│       vocals.wav
│
├───Etape_2_Bike_Trip_2022_Du_Morvan_a_la_montagne_Bourbonaise_AUDIO
│       vocals.wav
│
├───Etape_3_Bike_Trip_2022_Du_Morvan_a_la_montagne_Bourbonaise_AUDIO
│       vocals.wav
│
├───Etape_4-_Bike_Trip_2022_-_De_Champeix_a_Aurillac_AUDIO
│       vocals.wav
│
├───Etape_5_Bike_Trip_2022_L'Aubrac_AUDIO
│       vocals.wav
│
├───Etape_6_Bike_Trip_2022_Les_Gorges_du_Tarn_et_de_la_Jonte_AUDIO
│       vocals.wav
│
├───Etape_7_BikeTrip2022_La_Dourbie_et_Navacelles_AUDIO
│       vocals.wav
│
├───Etape_8_BikeTrip2022_La_Vallée_de_l'Orb__AUDIO
│       vocals.wav
│
└───Etape_9_BikeTrip2022_Le_debut_des_Pyrenees_AUDIO
        vocals.wav
```

Using this bat file based on `*.wav`:

```sh
@echo off
SetLocal EnableDelayedExpansion

for /r %%i in (*.wav) do (
	set pathh=%%~dpi
	set pathh=!pathh:~,-1!
	set ext=%%~xi
	set cd2=%cd:\=\\\\%
	set cd2=!cd2::=\:!
	for /f %%p in ('echo !pathh! ^| sed "s/!cd2!\\\\//"') do set dirname=%%p
	rename %%i !dirname!!ext!
	:: or do something else :
	::ffmpeg -stats -loglevel error -i %%i -y !dirname!.mp3
)
```


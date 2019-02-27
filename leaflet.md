---
title: Leaflet
layout: page
show_in_nav: false
---
<html>
	<head>

		<title>A Leaflet map!</title>
		<link rel="stylesheet" href="https://unpkg.com/leaflet@1.4.0/dist/leaflet.css" />
		<script src="https://unpkg.com/leaflet@1.4.0/dist/leaflet.js"></script>

		<!-- Copyright (C) 2013 Maxime Petazzoni <maxime.petazzoni@bulix.org> -->
		<script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet-gpx/1.4.0/gpx.min.js"></script>

		<!-- Copyright (c) 2013 Michael Lawrence Evans -->
		<script src="js/leaflet-hash.js"></script>
		<script src="js/togeojson.js"></script>


		<!-- For full screen -->
		<script src='https://api.mapbox.com/mapbox.js/plugins/leaflet-fullscreen/v1.0.1/Leaflet.fullscreen.min.js'></script>
		<link href='https://api.mapbox.com/mapbox.js/plugins/leaflet-fullscreen/v1.0.1/leaflet.fullscreen.css' rel='stylesheet' />

		<style>
			#map{ width: 100%; height: 500px; }
    </style>

	</head>
	<body>

		<br>
		<!-- To display the map -->
		<div id="map"></div>
		<br>
		<br>

		<script>





					// VARIABLE START
					// create file
					var Bike = ['gpx/Bike/B_201511_mtb.gpx',
					'gpx/Bike/B_2017_Stockach_DonauTalRadoflzell-Konstanz.gpx.gpx',
					'gpx/Bike/B_201709_Bike_Travel.gpx',
					'gpx/Bike/B_201808_Schwarzwald.gpx',
					'gpx/Bike/B_201809_Bike_Switzerland.gpx',
					'gpx/Bike/B_201812_LesForges.gpx']

					var Hike = ['gpx/Hike/2017_Grosser_Mythen.gpx',
					'gpx/Hike/2017_KS_2TAllgauerHochalpen-NebelhornzuGrosserDaumen.gpx',
					'gpx/Hike/2017_KS1T_Hinterstein-Rotspitze.gpx',
					'gpx/Hike/2017_Luetispitze.gpx',
					'gpx/Hike/2017_Nord_LechtalElbigenalp-Krotenkopf-Ubeleskarspitze-Hinterbornbach.gpx',
					'gpx/Hike/201708_Druesberg.gpx',
					'gpx/Hike/201711_Wgausflug.gpx',
					'gpx/Hike/2018_W_HochYbrig_Druesberg.gpx',
					'gpx/Hike/201804_Bockmattli.gpx',
					'gpx/Hike/201804_Pfaender.gpx',
					'gpx/Hike/201805_WG_Hike_0001.gpx',
					'gpx/Hike/201805_WG_Hike_0002.gpx',
					'gpx/Hike/201806_Zimba.gpx',
					'gpx/Hike/201808_Feldberg.gpx',
					'gpx/Hike/201809_Ottenhofen_imSchwarzwaldHiking.gpx',
					'gpx/Hike/201810_Pizol.gpx',
					'gpx/Hike/201811_Silberplatte_Klettern.gpx',
					'gpx/Hike/brunnenhochflue-t4.gpx',
					'gpx/Hike/chaeserrugg_vonwalenstadt.gpx',
					'gpx/Hike/hohenschwangauwildsulzhuette-saeuling-saeulinghau.gpx',
					'gpx/Hike/murgtal_murgseeturm.gpx',
					'gpx/Hike/plattberg_upssitzeostreich.gpx',
					'gpx/Hike/saentis_vonsudden.gpx',
					'gpx/Hike/sarek_2016.gpx',
					'gpx/Hike/um_herumdergimpel.gpx',
					'gpx/Hike/via_dellebochette.gpx',
					'gpx/Hike/W_2013_Ebenalp.gpx',
					'gpx/Hike/W_2013_Marwees.gpx',
					'gpx/Hike/W_2015_Rosteinpass.gpx',
					'gpx/Hike/W_2015_Saxer-luecke.gpx',
					'gpx/Hike/W_2016_Santis.gpx',
					'gpx/Hike/W_2017_Alpstein.gpx']

					var HikeProject = ['gpx/Hike/Project/AKD_project.gpx',
					'gpx/Hike/Project/moe_saladinspitze_rotewand_.gpx',
					'gpx/Hike/Project/moew-paiserspitze_.gpx']

					var SchitourProject = ['gpx/Schitour/Project/P_ST_moe-st-2t-carschinahuette.gpx',
					'gpx/Schitour/Project/P_ST_moe-st-2t-carschinahuette_2.gpx',
					'gpx/Schitour/Project/P_ST_moe-st-2t-claridenhuette.gpx',
					'gpx/Schitour/Project/P_ST_moe-st-2t-heilbronner_huette.gpx',
					'gpx/Schitour/Project/P_ST_moe-st-hirschberg.gpx',
					'gpx/Schitour/Project/P_ST_moe-st-mattjischhorn.gpx',
					'gpx/Schitour/Project/P_ST_moe-st_alpilakopf.gpx',
					'gpx/Schitour/Project/P_ST_moe-st_analperjoch.gpx',
					'gpx/Schitour/Project/P_ST_moe-st_gafier.gpx',
					'gpx/Schitour/Project/P_ST_moe-st_gampapingalpe.gpx',
					'gpx/Schitour/Project/P_ST_moe-st_gerenspitze.gpx',
					'gpx/Schitour/Project/P_ST_moe-st_windeggerspitze.gpx',
					'gpx/Schitour/Project/P_ST_st-moematona.gpx',
					'gpx/Schitour/Project/P_ST_st-moemoerzelspitze.gpx']

					var Schitour = ['gpx/Schitour/ST_2016_biet_weglosen.gpx',
					'gpx/Schitour/ST_2016_ober_kamorschitour.gpx',
					'gpx/Schitour/ST_2017_Innerlatenrns.gpx',
					'gpx/Schitour/ST_201711_LindauHutte.gpx',
					'gpx/Schitour/ST_2018_Fullfirst.gpx',
					'gpx/Schitour/ST_2018_Gross-Chaerpf.gpx',
					'gpx/Schitour/ST_201901_Gamperdun.gpx',
					'gpx/Schitour/ST_201901_Stockberg.gpx',
					'gpx/Schitour/ST_201902_Schneeglocke.gpx']

					var SchneeSProject = ['gpx/SchneeS/Project/P_SW_Malans-Tschugga.gpx',
					'gpx/SchneeS/Project/P_SW_Mattner_first.gpx',
					'gpx/SchneeS/Project/P_SW_Nussen_innertal.gpx',
					'gpx/SchneeS/Project/P_SW_Silberen.gpx',
					'gpx/SchneeS/Project/P_SW_Wilhaus_1.gpx']

					// VARIABLE END



					// VARIABLE DAVHUTTEN START
					var DAVhutten = [
					['Blueemlisalphuette SAC, SAC Sektion Bluemlisalp',7.7717084,46.5102283,'https://www.alpsonline.org/reservation/calendar?hut_id=1'],
					['Glecksteinhuette SAC, SAC Burgdorf',8.096521,46.6251159,'https://www.alpsonline.org/reservation/calendar?hut_id=2'],
					['Capanna da lAlbigna CAS, SAC Hoher Rohn',9.65512,46.3299,'https://www.alpsonline.org/reservation/calendar?hut_id=3'],
					['Kesch-Huette SAC, SAC Davos',9.8751716,46.6451659,'https://www.alpsonline.org/reservation/calendar?hut_id=4'],
					['Lidernenhuette SAC, SAC Mythen',8.6925125,46.9351944,'https://www.alpsonline.org/reservation/calendar?hut_id=5'],
					['Monte Rosa Huette SAC, SAC Monte Rosa',7.8145789,45.9569375,'https://www.alpsonline.org/reservation/calendar?hut_id=6'],
					['Capanna di Sciora CAS, SAC Hoher Rohn',9.6111967,46.3125,'https://www.alpsonline.org/reservation/calendar?hut_id=7'],
					['Capanna Basodino (Robiei) CAS, CAS Locarno',8.514105,46.4395411,'https://www.alpsonline.org/reservation/calendar?hut_id=8'],
					['Britanniahuette SAC, CAS Genevoise',7.9350557,46.0601385,'https://www.alpsonline.org/reservation/calendar?hut_id=9'],
					['Cabane des Dix CAS, CAS Monte Rosa',7.8145789,45.9569375,'https://www.alpsonline.org/reservation/calendar?hut_id=10'],
					['Doldenhornhuette SAC, SAC Emmental',7.697394,46.4868822,'https://www.alpsonline.org/reservation/calendar?hut_id=11'],
					['Konkordiahuette SAC, SAC Grindelwald',8.053211,46.500441,'https://www.alpsonline.org/reservation/calendar?hut_id=12'],
					['Leglerhuette SAC, SAC Toedi',9.080237,46.927409,'https://www.alpsonline.org/reservation/calendar?hut_id=13'],
					['Mutthornhuette SAC, SAC Weissenstein',7.8301079,46.4862468,'https://www.alpsonline.org/reservation/calendar?hut_id=14'],
					['Oberaarjochhuette SAC, SAC Biel',8.173025,46.526039,'https://www.alpsonline.org/reservation/calendar?hut_id=15'],
					['Terrihuette SAC, SAC Piz Terri',9.00493,46.6346,'https://www.alpsonline.org/reservation/calendar?hut_id=16'],
					['Geltenhuette SAC, SAC Oldenhorn',7.339079,46.369614,'https://www.alpsonline.org/reservation/calendar?hut_id=17'],
					['Capanna del Forno CAS, SAC Rorschach',9.7007906,46.390809,'https://www.alpsonline.org/reservation/calendar?hut_id=18'],
					['Fruendenhuette SAC, SAC Altels',7.74181,46.4836,'https://www.alpsonline.org/reservation/calendar?hut_id=19'],
					['Capanna Cristallina CAS, CAS Ticino',8.526377,46.471889,'https://www.alpsonline.org/reservation/calendar?hut_id=20'],
					['Badushuette, SAC Manegg',8.6683981,46.6365737,'https://www.alpsonline.org/reservation/calendar?hut_id=21'],
					['Cabane des Diablerets CAS, CAS Jaman',7.2154776,46.3386795,'https://www.alpsonline.org/reservation/calendar?hut_id=22'],
					['Hohganthuette, SAC Emmental',7.90613,46.7826,'https://www.alpsonline.org/reservation/calendar?hut_id=24'],
					['Camona da Maighels CAS, SAC Piz Terri',8.6900692,46.6252899,'https://www.alpsonline.org/reservation/calendar?hut_id=26'],
					['Gaulihuette SAC, SAC Bern',7.4362607,46.9412299,'https://www.alpsonline.org/reservation/calendar?hut_id=27'],
					['Trifthuette SAC, SAC Bern',8.3766021,46.6779203,'https://www.alpsonline.org/reservation/calendar?hut_id=28'],
					['Zwinglipasshuette, SAC Toggenburg',9.3762035,47.2332194,'https://www.alpsonline.org/reservation/calendar?hut_id=30'],
					['Dossenhuette SAC, SAC Oberaargau',8.0529396,46.6340468,'https://www.alpsonline.org/reservation/calendar?hut_id=31'],
					['Hundsteinhuette SAC, SAC Saentis',9.4222242,47.25486,'https://www.alpsonline.org/reservation/calendar?hut_id=32'],
					['Chamonna Tuoi CAS, SAC Engiadina Bassa',10.0287409,46.650234,'https://www.alpsonline.org/reservation/calendar?hut_id=33'],
					['Capanna Cadlimo CAS, SAC Uto',8.6952215,46.5716143,'https://www.alpsonline.org/reservation/calendar?hut_id=34'],
					['Hoernlihuette - Matterhorn Base Camp, Burgergemeinde Zermatt',7.6770693,45.9823021,'https://www.alpsonline.org/reservation/calendar?hut_id=35'],
					['Capanna Campo Tencia CAS, CAS Ticino',8.73274,46.4442,'https://www.alpsonline.org/reservation/calendar?hut_id=36'],
					['Brunnihuette SAC, SAC Engelberg',8.4106484,46.8409072,'https://www.alpsonline.org/reservation/calendar?hut_id=37'],
					['Capanna Sasc Furae CAS, CAS Bregaglia',9.5824,46.315328,'https://www.alpsonline.org/reservation/calendar?hut_id=38'],
					['Glattalphuette SAC, SAC Mythen',8.8749737,46.9168148,'https://www.alpsonline.org/reservation/calendar?hut_id=39'],
					['Baergbeizli Underbaergli',7.7322387,46.5054343,'https://www.alpsonline.org/reservation/calendar?hut_id=40'],
					['Rugghubelhuette SAC, SAC Titlis',8.4627557,46.8461725,'https://www.alpsonline.org/reservation/calendar?hut_id=41'],
					['Capanna Adula CAS, CAS Ticino',8.9957999,46.4991,'https://www.alpsonline.org/reservation/calendar?hut_id=42'],
					['Cabane du Velan CAS, CAS Genevoise',7.2454686,45.9169428,'https://www.alpsonline.org/reservation/calendar?hut_id=43'],
					['Gspaltenhornhuette SAC, SAC Bern',7.81025,46.5128,'https://www.alpsonline.org/reservation/calendar?hut_id=44'],
					['Windgaellenhuette AACZ, AACZ',8.7557867,46.790173,'https://www.alpsonline.org/reservation/calendar?hut_id=45'],
					['Carschinahuette SAC, SAC Raetia',9.827314,47.007077,'https://www.alpsonline.org/reservation/calendar?hut_id=46'],
					['Oberaletschhuette SAC, CAS Chasseral',7.9738641,46.4249239,'https://www.alpsonline.org/reservation/calendar?hut_id=47'],
					['Cabane des Violettes CAS, CAS Montana-Vermala',7.50007,46.3423,'https://www.alpsonline.org/reservation/calendar?hut_id=48'],
					['Capanna Bovarina, UTOE Bellinzona',8.888438,46.560075,'https://www.alpsonline.org/reservation/calendar?hut_id=49'],
					['Chamanna Cluozza, Schweizerischer Nationalpark',10.1177572,46.6628872,'https://www.alpsonline.org/reservation/calendar?hut_id=50'],
					['Taeschhuette SAC, SAC Uto',7.830011,46.051538,'https://www.alpsonline.org/reservation/calendar?hut_id=51'],
					['Berghaus Maenndlenen',7.96885,46.669,'https://www.alpsonline.org/reservation/calendar?hut_id=52'],
					['Igloo des Pantalons Blancs, CAS Sion',7.36837,46.0405,'https://www.alpsonline.org/reservation/calendar?hut_id=53'],
					['Grathaus Moron, SAC Angenstein',7.2690611,47.263082,'https://www.alpsonline.org/reservation/calendar?hut_id=54'],
					['Chelenalphuette SAC, SAC Aarau',8.4398738,46.6717492,'https://www.alpsonline.org/reservation/calendar?hut_id=55'],
					['Spitzsteinhaus, Sektion Bergfreunde Muenchen',11.7081726,48.1046511,'https://www.alpsonline.org/reservation/calendar?hut_id=57'],
					['Neue Prager Huette, DAV Bundesverband',12.3922729,47.1230665,'https://www.alpsonline.org/reservation/calendar?hut_id=58'],
					['Chalet de Roseyres, CAS Diablerets',7.2154776,46.3386795,'https://www.alpsonline.org/reservation/calendar?hut_id=60'],
					['Duemlerhuette OeAV, Sektion TK Linz',14.2775488,47.6733116,'https://www.alpsonline.org/reservation/calendar?hut_id=61'],
					['Glungezerhuette, Alpenverein Hall in Tirol',11.5268218,47.2097716,'https://www.alpsonline.org/reservation/calendar?hut_id=62'],
					['Ascher Huette, Sektion Pfaffenhofen-Asch',11.5076584,48.5378697,'https://www.alpsonline.org/reservation/calendar?hut_id=63'],
					['La Borbuintze, CAS Diablerets',6.9616253,46.5097215,'https://www.alpsonline.org/reservation/calendar?hut_id=64'],
					['Wildstrubelhuette SAC, SAC Wildhorn-Kaiseregg',7.46814,46.3825999,'https://www.alpsonline.org/reservation/calendar?hut_id=65'],
					['Gelmerhuette SAC, SAC Brugg',8.3427752,46.6312317,'https://www.alpsonline.org/reservation/calendar?hut_id=66'],
					['Cabane Barraud, CAS Diablerets',7.1630947,46.2842855,'https://www.alpsonline.org/reservation/calendar?hut_id=67'],
					['Chalet Lacombe, CAS Diablerets',7.158056,46.351389,'https://www.alpsonline.org/reservation/calendar?hut_id=68'],
					['Rotstockhuette, Skiclub Stechelberg',7.8383092,46.5451557,'https://www.alpsonline.org/reservation/calendar?hut_id=69'],
					['Bettelwurf Huette, Alpenverein Innsbruck',11.507628,47.33856,'https://www.alpsonline.org/reservation/calendar?hut_id=72'],
					['Hoellentalangerhuette, Sektion Muenchen',11.0251746,47.4379503,'https://www.alpsonline.org/reservation/calendar?hut_id=73'],
					['Cabane du Petit Mountet',7.6333134,46.0922824,'https://www.alpsonline.org/reservation/calendar?hut_id=74'],
					['Schesaplana Huette, SAC Pfannenstiel',9.6836949,47.0440718,'https://www.alpsonline.org/reservation/calendar?hut_id=75'],
					['Refuge des Petoudes, CAS Diablerets',7.0111632,46.0200699,'https://www.alpsonline.org/reservation/calendar?hut_id=76'],
					['Moenchsjochhuette, Genossenschaft Moenchsjochhuette',8.0057314,46.55474,'https://www.alpsonline.org/reservation/calendar?hut_id=77'],
					['Chamonna Lischana CAS, CAS Engiadina Bassa',10.3345232,46.7655628,'https://www.alpsonline.org/reservation/calendar?hut_id=78'],
					['Silvrettahuette SAC, SAC St.Gallen',10.0414342,46.8545346,'https://www.alpsonline.org/reservation/calendar?hut_id=80'],
					['Blaueishuette, Sektion Berchtesgaden',12.975706,47.622179,'https://www.alpsonline.org/reservation/calendar?hut_id=81'],
					['Hallerangerhaus, Sektion Schwaben',11.477182,47.3547403,'https://www.alpsonline.org/reservation/calendar?hut_id=82'],
					['Fritz-Putz Huette, Sektion Fuessen',10.7735919,47.5379338,'https://www.alpsonline.org/reservation/calendar?hut_id=83'],
					['Staufner Haus, Sektion Oberstaufen-Lindenberg',10.0689088,47.4916171,'https://www.alpsonline.org/reservation/calendar?hut_id=85'],
					['Frassenhuette, Alpenverein Vorarlberg',9.8274553,47.1897725,'https://www.alpsonline.org/reservation/calendar?hut_id=86'],
					['Karwendelhaus, Sektion Maenner Turnverein Muenchen',11.421597,47.427288,'https://www.alpsonline.org/reservation/calendar?hut_id=87'],
					['Sarotlahuette, Alpenverein Vorarlberg',9.8209244,47.1563674,'https://www.alpsonline.org/reservation/calendar?hut_id=88'],
					['Heinrich-Hueter-Huette, Alpenverein Vorarlberg',9.7837375,47.0785125,'https://www.alpsonline.org/reservation/calendar?hut_id=89'],
					['Freschenhaus, Alpenverein Vorarlberg',9.7779141,47.2979775,'https://www.alpsonline.org/reservation/calendar?hut_id=90'],
					['Tilisunahuette, Alpenverein Vorarlberg',9.8209244,47.1563674,'https://www.alpsonline.org/reservation/calendar?hut_id=91'],
					['Totalphuette, Alpenverein Vorarlberg',9.7270525,47.0526433,'https://www.alpsonline.org/reservation/calendar?hut_id=92'],
					['Peter-Anich-Huette, Sektion TK Innsbruck',11.0540938,47.274823,'https://www.alpsonline.org/reservation/calendar?hut_id=93'],
					['Klinkehuette, Sektion Admont-Gesaeuse',14.5137616,47.5393638,'https://www.alpsonline.org/reservation/calendar?hut_id=94'],
					['Kaltenberghuette, Sektion Reutlingen',9.209287,48.493223,'https://www.alpsonline.org/reservation/calendar?hut_id=95'],
					['Neue Reutlinger Huette, Sektion Reutlingen',9.209287,48.493223,'https://www.alpsonline.org/reservation/calendar?hut_id=96'],
					['Freiburgerhuette, Sektion Freiburg',9.9905413,47.162732,'https://www.alpsonline.org/reservation/calendar?hut_id=97'],
					['Edmund-Graf-Huette, Sektion TK Innsbruck',10.3557478,47.1060187,'https://www.alpsonline.org/reservation/calendar?hut_id=98'],
					['Berghaus Au, Sektion Ueberlingen',9.9637906,47.3180982,'https://www.alpsonline.org/reservation/calendar?hut_id=99'],
					['Gaudeamushuette, Sektion Main-Spessart',12.324513,47.549263,'https://www.alpsonline.org/reservation/calendar?hut_id=100'],
					['Saupsdorfer Huette, Sektion Saechischer Bergsteigerbund',14.3355328,50.9279506,'https://www.alpsonline.org/reservation/calendar?hut_id=101'],
					['Neue Heilbronner Huette, Sektion Heilbronn',9.208417,49.171874,'https://www.alpsonline.org/reservation/calendar?hut_id=103'],
					['Rotwandhaus, Sektion Turner Alpenkraenzchen',11.9351138,47.6461586,'https://www.alpsonline.org/reservation/calendar?hut_id=104'],
					['Goiserer Huette, OeAV, Alpenverein Bad Goisern',13.561572,47.620745,'https://www.alpsonline.org/reservation/calendar?hut_id=106'],
					['Gablonzer Huette, Alpenverein Neugablonz Enns',14.4794854,48.2056246,'https://www.alpsonline.org/reservation/calendar?hut_id=108'],
					['Zollnersee Huette, Alpenverein Obergailtal-Lesachtal',13.0007035,46.6591713,'https://www.alpsonline.org/reservation/calendar?hut_id=109'],
					['Geraerhuette, Sektion Landshut',11.628163,47.043388,'https://www.alpsonline.org/reservation/calendar?hut_id=110'],
					['Hofpuerglhuette, Alpenverein Linz',14.282633,48.31609,'https://www.alpsonline.org/reservation/calendar?hut_id=111'],
					['Linzerhaus / Wurzeralm, Alpenverein Linz',14.2874068,47.6478661,'https://www.alpsonline.org/reservation/calendar?hut_id=112'],
					['Linzer Tauplitz-Haus, Alpenverein Linz',14.282633,48.31609,'https://www.alpsonline.org/reservation/calendar?hut_id=113'],
					['Alpenrosenhuette, Sektion Schorndorf',9.528683,48.80537,'https://www.alpsonline.org/reservation/calendar?hut_id=114'],
					['Ruesselsheimer Huette, Sektion Ruesselsheim',8.43358,49.97765,'https://www.alpsonline.org/reservation/calendar?hut_id=115'],
					['Bamberger Huette, Sektion Bamberg',10.884673,49.896252,'https://www.alpsonline.org/reservation/calendar?hut_id=116'],
					['Moedlinger Huette, Alpenverein Moedling',16.2816448,48.0836402,'https://www.alpsonline.org/reservation/calendar?hut_id=117'],
					['Nebelsteinhuette, Alpenverein Waldviertel',14.778675,48.672846,'https://www.alpsonline.org/reservation/calendar?hut_id=118'],
					['Olpererhuette, Sektion Neumarkt i.d.Oberpfalz',11.6883642,47.0420174,'https://www.alpsonline.org/reservation/calendar?hut_id=119'],
					['Hannoverhaus, Sektion Hannover',13.2148761,47.0406827,'https://www.alpsonline.org/reservation/calendar?hut_id=121'],
					['Greizer Huette, Sektion Greiz Sitz Marktredwitz',12.0899816,50.0035483,'https://www.alpsonline.org/reservation/calendar?hut_id=122'],
					['Lizumerhuette, Alpenverein Hall in Tirol',11.640415,47.1667162,'https://www.alpsonline.org/reservation/calendar?hut_id=123'],
					['Nuernberger Huette, Sektion Nuernberg',11.07516,49.4492687,'https://www.alpsonline.org/reservation/calendar?hut_id=124'],
					['Edelweisshuette/Schneeberg, Alpenverein Edelweiss',15.814893,47.791823,'https://www.alpsonline.org/reservation/calendar?hut_id=125'],
					['Meraner Huette, AVS Meran',11.281923,46.683204,'https://www.alpsonline.org/reservation/calendar?hut_id=126'],
					['Reintalangerhuette, Sektion Muenchen',11.5478539,48.0996311,'https://www.alpsonline.org/reservation/calendar?hut_id=128'],
					['Neue Magdeburger Huette, Sektion Geltendorf',11.035917,48.11597,'https://www.alpsonline.org/reservation/calendar?hut_id=129'],
					['Hochrieshuette, Sektion Rosenheim',12.1131081,47.8566381,'https://www.alpsonline.org/reservation/calendar?hut_id=130'],
					['Dessauer Huette, Sektion Bergfreunde Anhalt Dessau',12.2423302,51.8308166,'https://www.alpsonline.org/reservation/calendar?hut_id=131'],
					['Clarahuette, Sektion Essen',12.2459295,47.0159002,'https://www.alpsonline.org/reservation/calendar?hut_id=132'],
					['Essener und Rostocker Huette, Sektion Essen',12.2978783,47.0548857,'https://www.alpsonline.org/reservation/calendar?hut_id=133'],
					['Capanna Scaletta, SAT Sezione Lucomagno',8.9404915,46.6076183,'https://www.alpsonline.org/reservation/calendar?hut_id=135'],
					['Lenggrieser Huette, Sektion Lenggries',11.6311156,47.6518362,'https://www.alpsonline.org/reservation/calendar?hut_id=139'],
					['Peter-Wiechenthaler-Huette, Alpenverein Saalfelden',12.8754212,47.4636952,'https://www.alpsonline.org/reservation/calendar?hut_id=141'],
					['Hinteralmhaus, Alpenverein Edelweiss',15.5156625,47.722054,'https://www.alpsonline.org/reservation/calendar?hut_id=142'],
					['Bremer Huette, Sektion Bremen',11.2633199,46.9948808,'https://www.alpsonline.org/reservation/calendar?hut_id=143'],
					['Ingolstaedter Haus, Sektion Ingolstadt',11.4160325,48.7502893,'https://www.alpsonline.org/reservation/calendar?hut_id=144'],
					['Riemannhaus, Sektion Ingolstadt',12.9147124,47.4580157,'https://www.alpsonline.org/reservation/calendar?hut_id=145'],
					['Annaberger Haus, Oesterreichischer Gebirgsverein',15.4211849,47.8735601,'https://www.alpsonline.org/reservation/calendar?hut_id=146'],
					['Julius-Seitner-Huette, Oesterreichischer Gebirgsverein',15.4423761,47.9591903,'https://www.alpsonline.org/reservation/calendar?hut_id=147'],
					['Gufferthuette, Sektion Kaufering',10.86155,48.08959,'https://www.alpsonline.org/reservation/calendar?hut_id=148'],
					['Knorrhuette, Sektion Muenchen',11.012772,47.4099586,'https://www.alpsonline.org/reservation/calendar?hut_id=149'],
					['Muenchner Haus, Sektion Muenchen',11.5742104,48.1366209,'https://www.alpsonline.org/reservation/calendar?hut_id=150'],
					['Watzmannhaus, Sektion Muenchen',12.933974,47.571213,'https://www.alpsonline.org/reservation/calendar?hut_id=151'],
					['Heinrich-Schwaiger-Haus, Sektion Muenchen',12.7390708,47.1623815,'https://www.alpsonline.org/reservation/calendar?hut_id=152'],
					['Gruttenhuette, Sektion Turner Alpenkraenzchen',12.3110068,47.5534685,'https://www.alpsonline.org/reservation/calendar?hut_id=154'],
					['DAV Edelweisshaus, Sektion Stuttgart',10.301136,47.2159767,'https://www.alpsonline.org/reservation/calendar?hut_id=155'],
					['Bordierhuette SAC, CAS Genevoise',7.8498,46.1445,'https://www.alpsonline.org/reservation/calendar?hut_id=156'],
					['Gruenburger Huette, Gruenburg',14.284616,47.921181,'https://www.alpsonline.org/reservation/calendar?hut_id=158'],
					['Salmhuette, Alpenverein Wien',12.7206824,47.047044,'https://www.alpsonline.org/reservation/calendar?hut_id=159'],
					['Muttekopfhuette, Alpenverein Imst Oberland',10.669766,47.262442,'https://www.alpsonline.org/reservation/calendar?hut_id=160'],
					['Berglihuette SAC, SAC Grindelwald',8.0206445,46.5668057,'https://www.alpsonline.org/reservation/calendar?hut_id=161'],
					['Neue Bonner Huette, Sektion Bonn',7.1172178,50.7387867,'https://www.alpsonline.org/reservation/calendar?hut_id=162'],
					['Toelzer Huette am Schafreuter, Sektion Toelz',11.285,47.32,'https://www.alpsonline.org/reservation/calendar?hut_id=163'],
					['Wildhornhuette SAC, SAC Moleson',7.388016,46.3792564,'https://www.alpsonline.org/reservation/calendar?hut_id=164'],
					['Cufercalhuette SAC, SAC Raetia',9.3590427,46.5933581,'https://www.alpsonline.org/reservation/calendar?hut_id=165'],
					['Topalihuette SAC, CAS Genevoise',7.7620554,46.1569901,'https://www.alpsonline.org/reservation/calendar?hut_id=166'],
					['Chamanna dal Linard CAS, CAS Engiadina Bassa',10.0829,46.7794,'https://www.alpsonline.org/reservation/calendar?hut_id=167'],
					['Capanna Monte Bar, CAS Ticino',9.0138038,46.1000113,'https://www.alpsonline.org/reservation/calendar?hut_id=168'],
					['Gamshuette, Sektion Otterfing',11.6739441,47.9148075,'https://www.alpsonline.org/reservation/calendar?hut_id=169'],
					['Riffelseehuette, Sektion Frankfurt',8.6861941,50.159868,'https://www.alpsonline.org/reservation/calendar?hut_id=171'],
					['Bad Kissinger Huette, Sektion Bad Kissingen',10.0815788,50.2071483,'https://www.alpsonline.org/reservation/calendar?hut_id=174'],
					['Bietschhornhuette AACB',7.8171135,46.3949395,'https://www.alpsonline.org/reservation/calendar?hut_id=175'],
					['Calandahuette SAC, SAC Raetia',9.4821802,46.8829834,'https://www.alpsonline.org/reservation/calendar?hut_id=176'],
					['Kampthalerhuette, Alpenverein Edelweiss',16.3727888,48.2029238,'https://www.alpsonline.org/reservation/calendar?hut_id=177'],
					['Kasseler Huette, Sektion Kassel',9.45601,51.2926,'https://www.alpsonline.org/reservation/calendar?hut_id=178'],
					['Pfeishuette, Alpenverein Innsbruck',11.4257041,47.3301092,'https://www.alpsonline.org/reservation/calendar?hut_id=179'],
					['Furtschaglhaus, Sektion Berlin',11.7470179,47.0014481,'https://www.alpsonline.org/reservation/calendar?hut_id=180'],
					['Brandenburger Haus, Sektion Berlin',10.7779044,46.8444159,'https://www.alpsonline.org/reservation/calendar?hut_id=181'],
					['Chamonas dEla CAS, SAC Sektion Davos',9.8359701,46.8027453,'https://www.alpsonline.org/reservation/calendar?hut_id=182'],
					['Goeppinger Huette, Sektion Hohenstaufen',10.0455581,47.2148028,'https://www.alpsonline.org/reservation/calendar?hut_id=183'],
					['Stripsenjochhaus, Alpenverein Kufstein',12.3105763,47.5771402,'https://www.alpsonline.org/reservation/calendar?hut_id=184'],
					['Porzehuette, Alpenverein Austria',12.5823167,46.6597167,'https://www.alpsonline.org/reservation/calendar?hut_id=185'],
					['Rottenmanner Huette, Alpenverein Rottenmann',14.3760093,47.4900301,'https://www.alpsonline.org/reservation/calendar?hut_id=187'],
					['Schwarzwasserhuette, Sektion Schwaben',10.0869853,47.3312129,'https://www.alpsonline.org/reservation/calendar?hut_id=189'],
					['Sudetendeutsche Huette, Sektion Schwaben',12.5762936,47.0493135,'https://www.alpsonline.org/reservation/calendar?hut_id=190'],
					['Stuttgarter Huette, Sektion Schwaben',10.2048037,47.1803495,'https://www.alpsonline.org/reservation/calendar?hut_id=192'],
					['Schwabenhaus, Sektion Schwaben',9.760138,47.1483112,'https://www.alpsonline.org/reservation/calendar?hut_id=194'],
					['Kaerlingerhaus, Sektion Berchtesgaden',12.975706,47.622179,'https://www.alpsonline.org/reservation/calendar?hut_id=195'],
					['Grubenberghuette, SAC Oldenhorn',7.2514896,46.5497411,'https://www.alpsonline.org/reservation/calendar?hut_id=196'],
					['Capanna Corno-Gries CAS, SAC Rossberg',8.4100383,46.4670767,'https://www.alpsonline.org/reservation/calendar?hut_id=197'],
					['Capanna dAlzasca CAS, CAS Locarno',8.5892442,46.2713266,'https://www.alpsonline.org/reservation/calendar?hut_id=198'],
					['Sepp-Ruf-Huette, Sektion Hamburg',10.2965222,51.8024144,'https://www.alpsonline.org/reservation/calendar?hut_id=199'],
					['Straubinger Haus, Sektion Straubing',12.4995397,47.620779,'https://www.alpsonline.org/reservation/calendar?hut_id=200'],
					['Bayreuther Huette, Sektion Bayreuth',11.5654251,49.939053,'https://www.alpsonline.org/reservation/calendar?hut_id=201'],
					['Noerdlinger Huette, Sektion Noerdlingen',10.4762954,48.8477589,'https://www.alpsonline.org/reservation/calendar?hut_id=202'],
					['Karl-von-Edel-Huette, Sektion Wuerzburg',11.8974624,47.1304726,'https://www.alpsonline.org/reservation/calendar?hut_id=203'],
					['Schreckhornhuette SAC, SAC Basel',8.09872,46.5818687,'https://www.alpsonline.org/reservation/calendar?hut_id=204'],
					['Rastkogelhuette, Sektion Oberkochen',10.11117,48.79825,'https://www.alpsonline.org/reservation/calendar?hut_id=205'],
					['Brochhuette, SAC Oberhasli',8.13895,46.6805,'https://www.alpsonline.org/reservation/calendar?hut_id=206'],
					['Almagellerhuette SAC, SAC Niesen',8.0079026,46.1074926,'https://www.alpsonline.org/reservation/calendar?hut_id=208'],
					['Weissmieshuetten SAC, SAC Olten',7.977908,46.1437406,'https://www.alpsonline.org/reservation/calendar?hut_id=209'],
					['Bruennsteinhaus, Rosenheim',12.098465,47.644601,'https://www.alpsonline.org/reservation/calendar?hut_id=210'],
					['Zellerhuette, Sektion TK Windischgarsten',14.2268215,47.6783315,'https://www.alpsonline.org/reservation/calendar?hut_id=211'],
					['Tutzinger Huette, Sektion Tutzing',11.2911084,47.8222,'https://www.alpsonline.org/reservation/calendar?hut_id=212'],
					['Finsteraarhornhuette SAC, SAC Oberhasli',8.1145084,46.5219173,'https://www.alpsonline.org/reservation/calendar?hut_id=213'],
					['Windegghuette SAC, SAC Bern',8.3480255,46.6949836,'https://www.alpsonline.org/reservation/calendar?hut_id=214'],
					['Landsberger Huette, Sektion Landsberg',10.8816114,48.0497003,'https://www.alpsonline.org/reservation/calendar?hut_id=215'],
					['Weidener Huette, Sektion Weiden',12.163318,49.676625,'https://www.alpsonline.org/reservation/calendar?hut_id=216'],
					['Friedrichshafener Huette, Sektion Friedrichshafen',9.49768,47.65195,'https://www.alpsonline.org/reservation/calendar?hut_id=217'],
					['Simonyhuette, Alpenverein Austria',13.6236333,47.5008167,'https://www.alpsonline.org/reservation/calendar?hut_id=219'],
					['Capanna Motterascio CAS, CAS Ticino',9.0054552,46.5933495,'https://www.alpsonline.org/reservation/calendar?hut_id=221'],
					['Biberacher Huette, Sektion Biberach',9.7876486,48.100229,'https://www.alpsonline.org/reservation/calendar?hut_id=222'],
					['Wanderheim Kreuzmoos, Private Huette',7.97712,48.18936,'https://www.alpsonline.org/reservation/calendar?hut_id=224'],
					['Cabane des Vignettes CAS, CAS Monte Rosa',7.4758754,45.9897678,'https://www.alpsonline.org/reservation/calendar?hut_id=226'],
					['Dammahuette SAC, SAC Pilatus',8.4577803,46.6448718,'https://www.alpsonline.org/reservation/calendar?hut_id=228'],
					['Muttseehuette SAC, SAC Winterthur',9.0187224,46.857442,'https://www.alpsonline.org/reservation/calendar?hut_id=229'],
					['Passauer Huette, Sektion Passau',13.4228,48.5611,'https://www.alpsonline.org/reservation/calendar?hut_id=232'],
					['Reuttener Huette, Alpenverein Reutte',10.7204775,47.4900772,'https://www.alpsonline.org/reservation/calendar?hut_id=233'],
					['Augsburger Huette, Sektion Augsburg',10.895196,48.37173,'https://www.alpsonline.org/reservation/calendar?hut_id=235'],
					['Vernagthuette, Sektion Wuerzburg',9.9028981,49.7967424,'https://www.alpsonline.org/reservation/calendar?hut_id=238'],
					['Pforzheimer Huette, Sektion Pforzheim',8.6597954,48.9062189,'https://www.alpsonline.org/reservation/calendar?hut_id=239'],
					['Camona da Punteglias CAS, SAC Winterthur',8.9560699,46.7772227,'https://www.alpsonline.org/reservation/calendar?hut_id=240'],
					['Fergenhuette SAC, SAC Praettigau',9.96471,46.8688999,'https://www.alpsonline.org/reservation/calendar?hut_id=241'],
					['Seetalhuette SAC, SAC Praettigau',10.0094,46.8739,'https://www.alpsonline.org/reservation/calendar?hut_id=242'],
					['Lobhornhuette, SAC Lauterbrunnen',7.868979,46.6185168,'https://www.alpsonline.org/reservation/calendar?hut_id=243'],
					['Spannorthuette SAC, SAC Uto',8.5423492,47.3806841,'https://www.alpsonline.org/reservation/calendar?hut_id=244'],
					['Ramozhuette SAC, SAC Arosa',9.6437458,46.7308916,'https://www.alpsonline.org/reservation/calendar?hut_id=246'],
					['Rieder Huette, Alpenverein Ried im Innkreis',13.4769218,48.1916662,'https://www.alpsonline.org/reservation/calendar?hut_id=248'],
					['Berggasthaus Alpenblick',8.6421946,46.7695849,'https://www.alpsonline.org/reservation/calendar?hut_id=250'],
					['Ybbstaler Huette, Alpenverein Austria',15.0250667,47.8075833,'https://www.alpsonline.org/reservation/calendar?hut_id=253'],
					['Bifertenhuette AACB',9.0265386,46.814554,'https://www.alpsonline.org/reservation/calendar?hut_id=254'],
					['Chalet du Hohberg, CAS Moleson',7.3355027,46.675724,'https://www.alpsonline.org/reservation/calendar?hut_id=255'],
					['Huette Hammer, Sektion Muenchen',11.5819805,48.1351253,'https://www.alpsonline.org/reservation/calendar?hut_id=256'],
					['Hochfeilerhuette, AVS Sterzing',11.7085069,46.9623095,'https://www.alpsonline.org/reservation/calendar?hut_id=257'],
					['Jonsdorfer Huette, Sektion Zittau',14.6952157,50.8513108,'https://www.alpsonline.org/reservation/calendar?hut_id=258'],
					['Voralphuette SAC, SAC Uto',8.4858583,46.6903402,'https://www.alpsonline.org/reservation/calendar?hut_id=259'],
					['Guttenberghaus, Alpenverein Austria',13.6125667,47.4735833,'https://www.alpsonline.org/reservation/calendar?hut_id=260'],
					['Seethalerhuette, Alpenverein Austria',13.6125667,47.4735833,'https://www.alpsonline.org/reservation/calendar?hut_id=261'],
					['Winteregghuette, SAC Biel',7.6499947,46.4601548,'https://www.alpsonline.org/reservation/calendar?hut_id=263'],
					['Binntalhuette SAC, SAC Delemont',7.3451555,47.365837,'https://www.alpsonline.org/reservation/calendar?hut_id=264'],
					['Zittauerhuette, Alpenverein Warnsdorf-Krimml',12.1242362,47.162766,'https://www.alpsonline.org/reservation/calendar?hut_id=266'],
					['Wolayerseehuette, Alpenverein Austria',12.8670667,46.6122333,'https://www.alpsonline.org/reservation/calendar?hut_id=267'],
					['Sewenhuette SAC, SAC Pfannenstiel',8.52104,46.7466,'https://www.alpsonline.org/reservation/calendar?hut_id=269'],
					['Kaunergrathuette, Sektion Mainz',8.2270668,50.0194179,'https://www.alpsonline.org/reservation/calendar?hut_id=271'],
					['Otto- Mayr-Huette, Sektion Augsburg',10.6187153,47.5093016,'https://www.alpsonline.org/reservation/calendar?hut_id=272'],
					['Millstaetter Huette, Alpenverein Millstatt',13.5596976,46.8109219,'https://www.alpsonline.org/reservation/calendar?hut_id=273'],
					['Kroentenhuette SAC, SAC Gotthard',8.575412,46.800128,'https://www.alpsonline.org/reservation/calendar?hut_id=274'],
					['Neue Regensburger Huette, Sektion Regensburg',12.1071877,49.013344,'https://www.alpsonline.org/reservation/calendar?hut_id=275'],
					['Sesvennahuette, AVS Mals, Lana, Untervinschgau',10.4354761,46.7344829,'https://www.alpsonline.org/reservation/calendar?hut_id=276'],
					['Cabane de lA Neuve CAS, CAS Diablerets',7.0672085,45.9487942,'https://www.alpsonline.org/reservation/calendar?hut_id=277'],
					['Cabane du Mountet CAS, CAS Diablerets',7.6535476,46.0600599,'https://www.alpsonline.org/reservation/calendar?hut_id=278'],
					['Cabane dOrny CAS, CAS Diablerets',7.062902,46.001892,'https://www.alpsonline.org/reservation/calendar?hut_id=279'],
					['Cabane Rambert CAS, CAS Diablerets',7.13415,46.2302,'https://www.alpsonline.org/reservation/calendar?hut_id=280'],
					['Cabane du Trient CAS, CAS Diablerets',7.043674,45.9995954,'https://www.alpsonline.org/reservation/calendar?hut_id=281'],
					['Schlernboedelehuette, AVS Schlern',11.5843762,46.5227112,'https://www.alpsonline.org/reservation/calendar?hut_id=284'],
					['Radlseehuette, AVS Brixen',11.5801457,46.7078792,'https://www.alpsonline.org/reservation/calendar?hut_id=285']
					];
					// VARIABLE DAVHUTTEN END





























			// test your script on https://plnkr.co

			var topo = L.tileLayer('https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png', {
				attribution: 'Map data: &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors, <a href="http://viewfinderpanoramas.org">SRTM</a> | Map style: &copy; <a href="https://opentopomap.org">OpenTopoMap</a> (<a href="https://creativecommons.org/licenses/by-sa/3.0/">CC-BY-SA</a>)',
					maxZoom: 17,
					minZoom: 1
				}),
				OpenStreetMap_France = L.tileLayer('https://{s}.tile.openstreetmap.fr/osmfr/{z}/{x}/{y}.png', {
					maxZoom: 20,
					attribution: '&copy; Openstreetmap France | &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
				}),
				OpenCycleMap = L.tileLayer('https://{s}.tile.thunderforest.com/cycle/{z}/{x}/{y}.png?apikey={apikey}', {
					attribution: '&copy; <a href="http://www.thunderforest.com/">Thunderforest</a>, &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
					apikey: 'e2ca2754befd4a5ea91cbafc804c47fe',
					maxZoom: 22
				}),
				outdoors = L.tileLayer('https://tile.thunderforest.com/outdoors/{z}/{x}/{y}.png?apikey=e2ca2754befd4a5ea91cbafc804c47fe', {
					attribution: 'Maps © <a href="http://www.thunderforest.com">Thunderforest</a>, Data © <a href="http://www.openstreetmap.org/copyright">OpenStreetMap contributors</a>',
					maxZoom: 17,
					minZoom: 1,
					apikey: 'e2ca2754befd4a5ea91cbafc804c47fe'
				}),
				Stamen_Toner = L.tileLayer('https://stamen-tiles-{s}.a.ssl.fastly.net/toner/{z}/{x}/{y}{r}.{ext}', {
					attribution: 'Map tiles by <a href="http://stamen.com">Stamen Design</a>, <a href="http://creativecommons.org/licenses/by/3.0">CC BY 3.0</a> &mdash; Map data &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
					subdomains: 'abcd',
					minZoom: 0,
					maxZoom: 20,
					ext: 'png'
				}),
				Stamen_Terrain = L.tileLayer('https://stamen-tiles-{s}.a.ssl.fastly.net/terrain/{z}/{x}/{y}{r}.png', {
					attribution: 'Map tiles by <a href="http://stamen.com">Stamen Design</a>, <a href="http://creativecommons.org/licenses/by/3.0">CC BY 3.0</a> &mdash; Map data &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
					subdomains: 'abcd',
					minZoom: 0,
					maxZoom: 18
				}),
				GeoAdmin = L.tileLayer('https://wmts20.geo.admin.ch/1.0.0/ch.swisstopo.pixelkarte-farbe/default/current/3857/{z}/{x}/{y}.jpeg', {
					minZoom: 1,
					maxZoom: 18
				});
;


				// initialize the map
			// only add 1 layer here to avoid the 2 layers to load
			var map = L.map('map', {
				center: [47.5, 9.6],
				zoom: 8,
				layers: Stamen_Toner,
				fullscreenControl: {
					pseudoFullscreen: true // if true, fullscreen to page width and height
				},
				crs: L.CRS.EPSG3857,
				continuousWorld: true,
				worldCopyJump: false
			});

			var baseLayers = {
				"OpenTopo": topo,
				"OpenStreetMapFR": OpenStreetMap_France,
				"OpenCycleMap": OpenCycleMap,
				"StamenToner": Stamen_Toner,
				"StamenTerrain": Stamen_Terrain,
				"Thunderforest Outdoors": outdoors,
				"GeoAdmin": GeoAdmin
			};

			// create layers
			var hill = L.tileLayer('https://tiles.wmflabs.org/hillshading/{z}/{x}/{y}.png', {
				maxZoom: 17,
				minZoom: 1,
				attribution: 'Hillshading: SRTM3 v2 (<a href="http://www2.jpl.nasa.gov/srtm/">NASA</a>)'
			}),
			OpenSlopeMap_HR = L.tileLayer('https://tileserver{s}.openslopemap.org/OSloOVERLAY_UHR_AlpsEast_16/{z}/{x}/{y}.png', {
				subdomains: '1234',
				maxZoom: 17,
				minZoom: 1,
				opacity: 0.5,
				attribution: 'Map data: &copy; <a href="https://www.openslopemap.org/">OpenSlopeMap</a>'
			}),
			OpenSlopeMap_LR = L.tileLayer('https://tileserver{s}.openslopemap.org/OSloOVERLAY_LR_All_16/{z}/{x}/{y}.png', {
				subdomains: '1234',
				maxZoom: 17,
				minZoom: 1,
				opacity: 0.5,
				attribution: 'Map data: &copy; <a href="https://www.openslopemap.org/">OpenSlopeMap</a>'
			}),
			 OpenPtMap = L.tileLayer('http://openptmap.org/tiles/{z}/{x}/{y}.png', {
					maxZoom: 17,
					attribution: 'Map data: &copy; <a href="http://www.openptmap.org">OpenPtMap</a> contributors'
			}),
			OpenRailwayMap = L.tileLayer('https://{s}.tiles.openrailwaymap.org/standard/{z}/{x}/{y}.png', {
					maxZoom: 19,
					minZoom: 1,
					attribution: 'Map data: &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors | Map style: &copy; <a href="https://www.OpenRailwayMap.org">OpenRailwayMap</a> (<a href="https://creativecommons.org/licenses/by-sa/3.0/">CC-BY-SA</a>)'
			})
			cycleroutes = L.tileLayer('https://tile.waymarkedtrails.org/cycling/{z}/{x}/{y}.png', {
				maxZoom: 17,
				minZoom: 1,
				attribution: 'Map Data: © <a href="https://cycling.waymarkedtrails.org">Waymarked Trails Cycling</a> contributors'
			}),
			hiketrails = L.tileLayer('https://tile.waymarkedtrails.org/hiking/{z}/{x}/{y}.png', {
				maxZoom: 17,
				minZoom: 1,
				attribution: 'Map Data: © <a href="https://hiking.waymarkedtrails.org">Waymarked Trails Hiking</a> contributors'
			}),
			pistes = L.tileLayer('https://tile.waymarkedtrails.org/slopes/{z}/{x}/{y}.png', {
				maxZoom: 17,
				minZoom: 1,
				attribution: 'Map Data: © <a href="https://slopes.waymarkedtrails.org">Waymarked Trails Slopes</a> contributors'
			});

			var lBike = L.layerGroup();
			var lBikeProject = L.layerGroup();
			var lHike = L.layerGroup();
			var lSchneeS = L.layerGroup();
			var lHikeProject = L.layerGroup();
			var lSchitour = L.layerGroup();
			var lSchitourProject = L.layerGroup();
			var lSchneeSProject = L.layerGroup();
			var Hutten = L.layerGroup();


			var overlays = {
				"DAV-SAC-CAS Hutten": Hutten,
				"Hillshading": hill,
				"Slope - OpenSlopeMapHR": OpenSlopeMap_HR,
				"Slope - OpenSlopeMapLR": OpenSlopeMap_LR,
				"Transport - Pt": OpenPtMap,
				"Transport - Train": OpenRailwayMap,
				"Ways - Hiking trails": hiketrails,
				"Ways - Cycling routes": cycleroutes,
				"Ways - Ski pistes": pistes,
				"DG - Bike": lBike,
				"DG - Hike": lHike,
				"DG - SchiTour": lSchitour,
				"DG - SchneeSchuhe": lSchneeS,
				"DG - Project Bike": lBikeProject,
				"DG - Project Hike": lHikeProject,
				"DG - Project SchiTour": lSchitourProject,
				"DG - Project SchneeSchuhe": lSchneeSProject
			};

			L.control.layers(baseLayers, overlays).addTo(map);

			var hutteIcon = L.icon({
				iconUrl: 'icon/hutte.png',
				iconSize: [30] // size of the icon
			});

			var loopinfo = {
				what: [Bike, Hike, HikeProject, Schitour, SchitourProject, SchneeSProject],
				layer: [lBike, lHike, lHikeProject, lSchitour, lSchitourProject, lSchneeSProject],
				trackcolor: ['green', 'red', 'red', 'blue', 'blue', 'purple'],
				project: [false, false, true, false, true, true]
			};


			// popup info : https://meggsimum.de/webkarte-mit-gps-track-vom-sport/

			//Bike -------------------------------------------------------------------------------------


			for (var j = 0; j < loopinfo.what.length; j += 1) {
				for (var i = 0; i < loopinfo.what[j].length; i += 1) {

					var g = new L.GPX(loopinfo.what[j][i], {async: true, parseElements: ['track'], polyline_options: { color: loopinfo.trackcolor[j]}});

					var link = loopinfo.what[j][i];

					g.on('loaded', function(e) {
						var gpx = e.target,
							distM = gpx.get_distance(),
							distKm = distM / 1000,
							distKmRnd = distKm.toFixed(1),
							eleGain = gpx.get_elevation_gain().toFixed(0),
							eleLoss = gpx.get_elevation_loss().toFixed(0),
							cen = gpx.getBounds().getCenter();

						var share = 'https://dgrv.github.io/dorian.gravier.github.io/leaflet.html?lat=' + cen.lat + '&lng=' + cen.lng;

						var info = "Name: " + link + "</br>" +
							"Distance: " + distKmRnd + " km </br>" +
							"Elevation Gain: " + eleGain + " m </br>" +
							"<a href='" + link + "' target='_blank'>Link</a></br>" +
							"<a href='" + share + "' target='_blank'>Share location</a> </br>";
							// register popup on click
	 					gpx.getLayers()[0].bindPopup(info);

						if ( loopinfo.project[j] == true ) {
							gpx.setStyle({opacity: 0.95, dashArray: '3 6'});
						};
					});

					g.on('mouseover', function(e) {
	      		e.target.setStyle({opacity: 0.7, weight: 6});
	    		});

					g.on('mouseout', function(e) {
	      		e.target.setStyle({opacity: 1, weight: 3});
	    		});

					g.addTo(loopinfo.layer[j]);
				};
			};

			for (var i = 0; i < DAVhutten.length; i++) {
				var p = new L.marker([DAVhutten[i][2], DAVhutten[i][1]], {icon: hutteIcon}).bindPopup("Name: " + DAVhutten[i][0] + "</br>" +
				"<a href='" + DAVhutten[i][3] + "' target='_blank'>Check places</a> </br>");
				p.addTo(Hutten);
			};


			// Copyright (c) 2013 Michael Lawrence Evans
			var hash = new L.Hash(map);





		</script>
	</body>
</html>

// create file
var ModernZeiten = ['../files/Batch/Gpx/th3cr4g_Listen/ModernZeiten/ModernZeiten.gpx',
var Bike_trip_2022 = ['../files/gpx/Bike_trip_2022/BT22_2022-07-07.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-07-08.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-07-09.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-07-10.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-07-13.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-07-14.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-07-17.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-07-18.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-07-20.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-08-26.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-08-27.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-08-29.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-08-30.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-08-31.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-09-01.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-09-02.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-09-03.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-09-10.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-09-11.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-09-27.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-09-29.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-09-30.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-10-02.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-10-03.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-10-05.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-10-06.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-10-07.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-10-08.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-10-09.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-10-10.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-10-11.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-10-12.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-10-14.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-10-16.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-10-17.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-10-18.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-10-19.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-10-21.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-10-22.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-10-24.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-10-25.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-10-26.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-10-27.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-10-28.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-10-29.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-10-30.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-10-31.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-11-02.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-11-03.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-11-05.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-11-06.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-11-07.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-11-08.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-11-09.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-11-10.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-11-11.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-11-14.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-11-15.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-11-16.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-11-17.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-11-19.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-11-20.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-11-26.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-11-27.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-11-30.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-12-01.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-12-02.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-12-03.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-12-04.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-12-05.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-12-06.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-12-07.gpx',
'../files/gpx/Bike_trip_2022/BT22_2022-12-08.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-04-20.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-04-20a.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-04-22.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-04-24.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-04-25.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-04-26.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-04-27.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-04-29.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-04-30.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-05-01.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-05-02.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-05-03.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-05-04.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-05-06.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-05-07.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-05-08.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-05-09.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-05-10.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-05-11.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-05-12.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-05-13.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-05-15.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-05-15b.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-05-25.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-05-26.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-05-27.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-05-28.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-05-29.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-05-30.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-05-31.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-06-01.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-06-02.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-06-03.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-06-04.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-06-05.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-06-06.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-06-10.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-06-11.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-06-12.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-06-13.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-06-14.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-06-15.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-07-20.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-07-21.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-07-22.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-07-23.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-07-24.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-08-04.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-08-04b.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-09-25.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-09-26.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-09-27.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-09-28.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-09-29.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-09-30.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-10-01.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-10-01b.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-10-02.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-10-03.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-10-04.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-10-05.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-10-06.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-10-07.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-10-08.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-10-09.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-10-14.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-10-15.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-10-16.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-10-17.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-10-18.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-10-19.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-10-20.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-10-21.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-10-22.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-10-22b.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-10-23.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-10-25.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-10-26.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-10-28.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-10-29.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-10-30.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-10-31.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-11-02.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-11-08.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-11-12.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-11-13.gpx',
'../files/gpx/Bike_trip_2022/BT22_2023-11-14.gpx']

var Climbing = ['../files/gpx/Climbing/ModernZeiten.gpx',
'../files/gpx/Climbing/Pause.gpx']

var Bike = ['../files/gpx/Leaflet/Bike/B_2013_Epinal-KN.gpx',
'../files/gpx/Leaflet/Bike/B_201511_mtb.gpx',
'../files/gpx/Leaflet/Bike/B_2017_Stockach_DonauTalRadoflzell-Konstanz.gpx',
'../files/gpx/Leaflet/Bike/B_201709_Bike_Travel.gpx',
'../files/gpx/Leaflet/Bike/B_201808_Schwarzwald.gpx',
'../files/gpx/Leaflet/Bike/B_201809_Bike_Switzerland.gpx',
'../files/gpx/Leaflet/Bike/B_201812_LesForges.gpx',
'../files/gpx/Leaflet/Bike/B_201904_Ruegen_insel_runde.gpx',
'../files/gpx/Leaflet/Bike/B_201906_FrankenJura_0001.gpx',
'../files/gpx/Leaflet/Bike/B_201906_FrankenJura_0002.gpx',
'../files/gpx/Leaflet/Bike/B_201906_FrankenJura_0003.gpx',
'../files/gpx/Leaflet/Bike/B_201906_FrankenJura_0004.gpx',
'../files/gpx/Leaflet/Bike/B_201906_FrankenJura_0005.gpx',
'../files/gpx/Leaflet/Bike/B_201906_FrankenJura_0006.gpx',
'../files/gpx/Leaflet/Bike/B_201906_FrankenJura_0007.gpx',
'../files/gpx/Leaflet/Bike/B_201906_FrankenJura_0008.gpx',
'../files/gpx/Leaflet/Bike/B_201906_FrankenJura_0009.gpx',
'../files/gpx/Leaflet/Bike/B_201906_FrankenJura_0010.gpx',
'../files/gpx/Leaflet/Bike/B_201906_FrankenJura_0011.gpx',
'../files/gpx/Leaflet/Bike/B_201906_FrankenJura_0012.gpx',
'../files/gpx/Leaflet/Bike/B_201906_FrankenJura_0013.gpx',
'../files/gpx/Leaflet/Bike/B_201906_FrankenJura_0014.gpx',
'../files/gpx/Leaflet/Bike/B_20200424_Olima.gpx',
'../files/gpx/Leaflet/Bike/B_20200426_Olima.gpx',
'../files/gpx/Leaflet/Bike/B_20200428_Olima.gpx',
'../files/gpx/Leaflet/Bike/B_20200501_Olima.gpx',
'../files/gpx/Leaflet/Bike/B_20200503_Olima.gpx',
'../files/gpx/Leaflet/Bike/B_20200508_Olima.gpx',
'../files/gpx/Leaflet/Bike/B_20200510_Olima.gpx',
'../files/gpx/Leaflet/Bike/B_20200512_Olima.gpx',
'../files/gpx/Leaflet/Bike/B_202006_Ehrenschwangertal.gpx',
'../files/gpx/Leaflet/Bike/B_202006_Jugethoehe.gpx',
'../files/gpx/Leaflet/Bike/B_202109_Fahrrad_Klettern_Jura.gpx',
'../files/gpx/Leaflet/Bike/B_202111_Chartreuse.gpx',
'../files/gpx/Leaflet/Bike/B_202111_Grenoble-LesForges.gpx',
'../files/gpx/Leaflet/Bike/B_202205_Bike_01.gpx',
'../files/gpx/Leaflet/Bike/B_202205_Bike_02.gpx',
'../files/gpx/Leaflet/Bike/B_202205_Bike_03.gpx',
'../files/gpx/Leaflet/Bike/B_202205_Bike_04.gpx',
'../files/gpx/Leaflet/Bike/B_202205_Bike_05.gpx',
'../files/gpx/Leaflet/Bike/B_202205_Bike_06.gpx',
'../files/gpx/Leaflet/Bike/B_202205_Bike_07.gpx',
'../files/gpx/Leaflet/Bike/B_20240221_Vosges-Konstanz.gpx',
'../files/gpx/Leaflet/Bike/B_20240222_Vosges-Konstanz.gpx',
'../files/gpx/Leaflet/Bike/B_20240223_Vosges-Konstanz.gpx',
'../files/gpx/Leaflet/Bike/B_20240224_Vosges-Konstanz.gpx']

var Hike = ['../files/gpx/Leaflet/Hike/2017_Grosser_Mythen.gpx',
'../files/gpx/Leaflet/Hike/2017_KS1T_Hinterstein-Rotspitze.gpx',
'../files/gpx/Leaflet/Hike/2017_Luetispitze.gpx',
'../files/gpx/Leaflet/Hike/2017_Nord_LechtalElbigenalp-Krotenkopf-Ubeleskarspitze-Hinterbornbach.gpx',
'../files/gpx/Leaflet/Hike/201708_Druesberg.gpx',
'../files/gpx/Leaflet/Hike/201711_Wgausflug.gpx',
'../files/gpx/Leaflet/Hike/2018_W_HochYbrig_Druesberg.gpx',
'../files/gpx/Leaflet/Hike/201804_Bockmattli.gpx',
'../files/gpx/Leaflet/Hike/201804_Pfaender.gpx',
'../files/gpx/Leaflet/Hike/201805_WG_Hike_0001.gpx',
'../files/gpx/Leaflet/Hike/201805_WG_Hike_0002.gpx',
'../files/gpx/Leaflet/Hike/201806_Zimba.gpx',
'../files/gpx/Leaflet/Hike/201808_Feldberg.gpx',
'../files/gpx/Leaflet/Hike/201809_Ottenhofen_imSchwarzwaldHiking.gpx',
'../files/gpx/Leaflet/Hike/201810_Pizol.gpx',
'../files/gpx/Leaflet/Hike/201811_Silberplatte_Klettern.gpx',
'../files/gpx/Leaflet/Hike/201903_Saechsische_Schweiz.gpx_250.gpx',
'../files/gpx/Leaflet/Hike/201910_Donautal.gpx',
'../files/gpx/Leaflet/Hike/201910_Tajakante.gpx',
'../files/gpx/Leaflet/Hike/202008_Klettern_Wogesen.gpx',
'../files/gpx/Leaflet/Hike/202008_Pont-de-Barret_Trail.gpx',
'../files/gpx/Leaflet/Hike/202011_Buergbergerhörnle.gpx',
'../files/gpx/Leaflet/Hike/202012_Rottachberg.gpx',
'../files/gpx/Leaflet/Hike/brunnenhochflue-t4.gpx',
'../files/gpx/Leaflet/Hike/BT22_2023-05-10b.gpx',
'../files/gpx/Leaflet/Hike/BT22_2023-05-11.gpx',
'../files/gpx/Leaflet/Hike/chaeserrugg_vonwalenstadt.gpx',
'../files/gpx/Leaflet/Hike/H_20230701_LaMorte.gpx',
'../files/gpx/Leaflet/Hike/H_20230702_LaMorte.gpx',
'../files/gpx/Leaflet/Hike/H_20230727_Pizzo_del_Chent.gpx',
'../files/gpx/Leaflet/Hike/murgtal_murgseeturm.gpx',
'../files/gpx/Leaflet/Hike/plattberg_upssitzeostreich.gpx',
'../files/gpx/Leaflet/Hike/saentis_vonsudden.gpx',
'../files/gpx/Leaflet/Hike/sarek_2016.gpx',
'../files/gpx/Leaflet/Hike/um_herumdergimpel.gpx',
'../files/gpx/Leaflet/Hike/via_dellebochette.gpx',
'../files/gpx/Leaflet/Hike/W_2013_Ebenalp.gpx',
'../files/gpx/Leaflet/Hike/W_2013_Marwees.gpx',
'../files/gpx/Leaflet/Hike/W_2015_Rosteinpass.gpx',
'../files/gpx/Leaflet/Hike/W_2015_Saxer-luecke.gpx',
'../files/gpx/Leaflet/Hike/W_2016_Santis.gpx',
'../files/gpx/Leaflet/Hike/W_2017_Alpstein.gpx',
'../files/gpx/Leaflet/Hike/W_202006_BucheneggerWasserfaelle.gpx',
'../files/gpx/Leaflet/Hike/W_202006_Hochgrat.gpx',
'../files/gpx/Leaflet/Hike/W_202006_Rubihorn.gpx',
'../files/gpx/Leaflet/Hike/W_202007_Fohlenhaus_Baerenhoele.gpx',
'../files/gpx/Leaflet/Hike/W_202007_Jubilaumsgrat_01.gpx',
'../files/gpx/Leaflet/Hike/W_202007_Jubilaumsgrat_02.gpx',
'../files/gpx/Leaflet/Hike/W_202007_Kramerspitz.gpx',
'../files/gpx/Leaflet/Hike/W_202008_Tannheim-Hinterhornbach_01.gpx',
'../files/gpx/Leaflet/Hike/W_202008_Tannheim-Hinterhornbach_02.gpx',
'../files/gpx/Leaflet/Hike/W_202102_Hirschberg.gpx',
'../files/gpx/Leaflet/Hike/W_202111_Chartreuse_LaPinea.gpx',
'../files/gpx/Leaflet/Hike/W_202205_Stockflue.gpx',
'../files/gpx/Leaflet/Hike/W_202210_Gorges-d-heric.gpx',
'../files/gpx/Leaflet/Hike/W_202210_Gorges-d-heric_2.gpx']

var Schitour = ['../files/gpx/Leaflet/Schitour/202203_Grand-pic-Belledonne.gpx',
'../files/gpx/Leaflet/Schitour/ST_2016_biet_weglosen.gpx',
'../files/gpx/Leaflet/Schitour/ST_2016_ober_kamorschitour.gpx',
'../files/gpx/Leaflet/Schitour/ST_2017_Innerlatenrns.gpx',
'../files/gpx/Leaflet/Schitour/ST_201711_LindauHutte.gpx',
'../files/gpx/Leaflet/Schitour/ST_2018_Fullfirst.gpx',
'../files/gpx/Leaflet/Schitour/ST_2018_Gross-Chaerpf.gpx',
'../files/gpx/Leaflet/Schitour/ST_201901_Gamperdun.gpx',
'../files/gpx/Leaflet/Schitour/ST_201901_Stockberg.gpx',
'../files/gpx/Leaflet/Schitour/ST_201902_Schneeglocke.gpx',
'../files/gpx/Leaflet/Schitour/ST_201903_Klostertaler-Egghorn.gpx',
'../files/gpx/Leaflet/Schitour/ST_201903_Sonntagspitze.gpx',
'../files/gpx/Leaflet/Schitour/ST_201911_Stotzigen_Firsten.gpx',
'../files/gpx/Leaflet/Schitour/ST_202101_Rangiswangerhorn.gpx',
'../files/gpx/Leaflet/Schitour/ST_202101_Rindalphorn.gpx',
'../files/gpx/Leaflet/Schitour/ST_202101_Sylvester_001.gpx',
'../files/gpx/Leaflet/Schitour/ST_202101_Sylvester_002.gpx',
'../files/gpx/Leaflet/Schitour/ST_202101_Wannenkopf.gpx',
'../files/gpx/Leaflet/Schitour/ST_20210116_Rottachberg.gpx',
'../files/gpx/Leaflet/Schitour/ST_202102_Heubatspitze.gpx',
'../files/gpx/Leaflet/Schitour/ST_202102_Toreck.gpx',
'../files/gpx/Leaflet/Schitour/ST_20210320_Guentlespitze-Hochstarzel.gpx']

var SchitourProject = ['../files/gpx/Leaflet/Schitour/Project/P_ST_moe-st-2t-carschinahuette.gpx',
'../files/gpx/Leaflet/Schitour/Project/P_ST_moe-st-2t-carschinahuette_2.gpx',
'../files/gpx/Leaflet/Schitour/Project/P_ST_moe-st-2t-claridenhuette.gpx',
'../files/gpx/Leaflet/Schitour/Project/P_ST_moe-st-2t-heilbronner_huette.gpx',
'../files/gpx/Leaflet/Schitour/Project/P_ST_moe-st-hirschberg.gpx',
'../files/gpx/Leaflet/Schitour/Project/P_ST_moe-st-mattjischhorn.gpx',
'../files/gpx/Leaflet/Schitour/Project/P_ST_moe-st_alpilakopf.gpx',
'../files/gpx/Leaflet/Schitour/Project/P_ST_moe-st_analperjoch.gpx',
'../files/gpx/Leaflet/Schitour/Project/P_ST_moe-st_gafier.gpx',
'../files/gpx/Leaflet/Schitour/Project/P_ST_moe-st_gampapingalpe.gpx',
'../files/gpx/Leaflet/Schitour/Project/P_ST_moe-st_gerenspitze.gpx',
'../files/gpx/Leaflet/Schitour/Project/P_ST_moe-st_windeggerspitze.gpx',
'../files/gpx/Leaflet/Schitour/Project/P_ST_st-moematona.gpx',
'../files/gpx/Leaflet/Schitour/Project/P_ST_st-moemoerzelspitze.gpx',
'../files/gpx/Leaflet/Schitour/Project/P_ST_Vogelberg-Zapporthutte-SAC.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_A1_Schwarzwasserhuette.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_A10_Mahdtaltour.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_A2_OchsenhoferKoepfe.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_A3_Gruenhorn.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_A4_Steinmandl.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_A5_FalzerKopf.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_A6_1_Haehlekopf_Sued.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_A6_2_Haehlekopf_Ost.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_A7_Berlingerskoepfle.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_A8_1_IfenSued.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_A8_2_IfenNord.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_A9_1_Toreck.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_A9_2_ToreckIfenbahn.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_B1_Gruenhorn.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_B2_1_GuentlespitzeNordost.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_B2_2_GuentlespitzeSuedost.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_B2_3_GuentlespitzeAbfahrtSchoppernau.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_B3_Uentschenspitze.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_B4_1_UnspitzeDerrarinne.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_B4_Unspitze.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_B5_Gamsfuss.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_B6_Hoeferspitze.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_B7_WeisserSchrofen.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_B8_Widderstein.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_B9_1_KarlstorOstabfahrt.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_B9_Karlstor.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_C1_Geisshorn.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_C10_MittlererSchafalpenkopf.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_C10_MittlererSchafalpenkopfFiderepass.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_C11_Kuhgehrenspitze.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_C2_1_LiechelkopfWildental.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_C2_2_LiechelkopfGemsteltal.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_C3_1_ElferkopfGemsteltal.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_C3_2_Winterelfer.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_C3_3_Elferrinne.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_C4_MittlererSchafalpkopf.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_C5_Hochgehrenspitze.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_C6_1_FiderepassWildental.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_C6_2_FiderepassStillachtal.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_C6_3_FiderepassKanzelwand.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_C7_1_AlpgundkopfStillachtal.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_C7_1_AlpgundOstabfahrt.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_C8_1_MindelheimerHuetteWildental.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_C8_2_MindelheimerHuetteGemsteltal.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_C8_3_MindelheimerHuetteVomFiderepass.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_C9_1_NoerdlicherSchafalpenkopfUeberschreitung.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_D1_1_RappenseehuetteVonNorden.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_D1_2_RappenseehuetteVonSueden.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_D1_3_RappenseehuetteVonLechleiten.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_D10_Bockkar.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_D11_KreuzeckRaueck.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_D2_1_Rappenseekopf.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_D2_2_Rothgundspitze.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_D2_3_HohesLicht.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_D4_1_Muttlerkopf.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_D4_2_Hornbachspitze.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_D4_3_GrosserKrottenkopf.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_D5_1_Kratzerfeld.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_D5_Kratzer.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_D6_2_Trettachrinne.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_D6_3_MaedelegabelHolzgau.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_D6_Maedelegabel.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_D7_Heilbronnerweg.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_D8_Linkerskopf.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_D9_1_TrettachEinstieg.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_D9_Wildengundkopf.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_E0_OytalBisKaeseralpe.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_E1_Aelpelesattel.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_E2_RotesLoch.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_E3_1_RauheckAelpelesattel.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_E3_2_RauheckEisseeNordgrat.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_E3_3_RauheckLechlerKanz.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_E4_1_JochspitzeAbfahrtLechlerKanz.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_E4_Hoellhorn.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_E4_JochspitzeAufstieg.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_E5_WildenfeldscharteGrosserWilder.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_E6_Schneck.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_F3_1_GrSeekopf.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_F4_Laufbacher_Eck_vom_Neblehorn.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_F5_3_Daumen_Retterschwang.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_F6_1_Abfahrt_Laufbacherecke_ins_Oytal.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_F6_1_Abfahrt_Laufbacherecke_nach_Osten.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_F6_Rubinger_Houte_Route_Entschen.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_G1_Schwarzenberghuette.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_G10_1_Glasfelderkopf.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_G10_2_Kesselspitze.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_G10_3_Bockkarscharte_Erzbergtal.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_G10_4_Fuchskarumrundung.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_G11_1_Kreuzkopf.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_G11_2_Weittalkopf.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_G12_1_Hochvogel_Kalter_Winkel.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_G12_2_Hochvogel-Kreuzkopf.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_G13_2_Schaenzle.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_G13_2_Schaenzlekopf.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_G13_2_Schaenzlespitze.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_G13_3_Lahnerkopf.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_G13_4_Lahnerkopfueberschreitung.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_G13_Erzbergtal.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_G6_1_Laufbacher_Eck_Obertal.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_G6_2 _Laufbacher_Eck_Baerguendeletal.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_G7_Schneck.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_G9_Prinz-Luitpold-Haus.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_H1_Rauhhorn.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_H1_Willersalpe.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_H2_1_Gaishorn.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_H2_2_Zirleseck.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_H2_3_Rohnenspitze .gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_H2_4Ponten.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_H3_1_Heubatspitze_Abfahrt_Norden_1.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_H3_1_Heubatspitze_Abfahrt_Norden_2.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_H3_Heubatspitze.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_H4_Rotspitze.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_H5_Kleiner_Daumen.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_H6_1_Entschenkopf_Abfahrt_Norden.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_H6_Entschenkopf.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_I1_1_Kuehgund_Schattwald.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_I1_2_Iseler_Oberjoch.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_I1_3_Iselerkar.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_I1_4_Iseler_Schattwald.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_I1_5_Iseler_Rohnenspitze.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_I10_Schochenspitze.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_I11_Landsberger_Huette.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_I12_1_Rote_Spitze.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_I12_2_Steinkarspitze.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_I12_3_Lachenspitze.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_I12_4_Schochenspitze.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_I13_Rauhhorn.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_I14_Aggenstein.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_I2_2_Bschiesser_Nordosten.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_I4_Zirleseck.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_I5_1_Rohnenspitze_Nordwestruecken.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_I5_2_Rohnenspitze_Zirleseck.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_I5_3_Rohnenspitze_Nordabfahrt.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_I6_1_Gaishorn_Vilsalpsee.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_I7_1_Sulzspitze_Haldensee.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_I8_Litnisschrofen.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_I9_Krinnenspitze.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_J1_Reuter_Wanne.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_J2_Wertacher_Hoernle.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_J3_Ornach.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_J4_1_Spieser_Sueden.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_J4_2_Spieser_Unterjoch.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_J5_1_Abfahrt_Heidelbeerkopf.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_J5_Sonnenkopf_Heidelbeerkopf.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_J6_Schnippenkopf.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_J7_Entschenkopf.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_J8_Zwoelferkopf.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_J9_Gruenten.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_K2_1_Riedberger_Horn_Bolgental.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_K2_2_Riedberger_Horn_Schwabenhof.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_K2_Riedberger_Horn_Sued.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_K2_Riedberger_Horn_Suedost.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_K3_Siplinger_Kopf.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_K4_Heidenkopf.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_K5_Girenkopf.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_K6_Gr_Balderschwangrunde_Girenkopf_Siplinger.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_K7_Burstkopf_Feuerstaetter_Kopf.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_K8_Hochgrat_Balderschwang.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_L1_Wannenkopf.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_L10_Immenstaedter_Horn.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_L11_Gschwender_Horn.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_L12_1Stuiben_Immenstadt.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_L12_2_Stuiben_Gschwender Horn.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_L13_1_Rindalphorn_Hochgrat.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_L13_2_Rindalphorn_Brunnenauscharte.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_L13_3_Rindalphorn_Nordosten.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_L14_Nagelfluhkette.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_L15_Seelekopf.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_L16_Eineguntkopf.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_L2_1_Rangiswanger_Horn_Sigiswang.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_L2_2_Rangiswanger_Horn_Ostertal.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_L3_1_Gr_Ochsenkpf_Rangiswanger_Horn.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_L3_2_Ochsenkopf_Hoernerbahn.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_L3_Gr_Ochsenkopf_Ostertal.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_L4_1_Riedberger_Horn_Bolgental.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_L4_2_Riedberger_Hoernerbahn.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_L4_3_Riedberger_Horn_Ostertal.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_L5_Hoernertour.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_L6_1_Blaicher_Horn_Gunzesried.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_L6_2_Blaicher_Horn_Ostertal.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_L6_3_Hoellritzer_Eck.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_L7_1_Tennenmooskopf.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_L7_Tennenmooskopf.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_L8_Steinberg.gpx',
'../files/gpx/Leaflet/Schitour/Project/Panic0_L9_Buraltalkopf.gpx']


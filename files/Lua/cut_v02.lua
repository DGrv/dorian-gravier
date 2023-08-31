function cut()

	-- lfs = require "lfs"
	video_path = mp.get_property("path")
	-- video_path = "D:/Pictures/GoPro/IMPORT/converted/test/in.mp4
	
	vpath = video_path:match("(.*[/\\])")
	video_path_noext = string.sub(video_path, 1, -5)
	video_ext = string.sub(video_path, string.len(video_path) - 3, string.len(video_path))
	video_in = video_path_noext..'_old'..video_ext
	video_in2 = video_path_noext..'_oldwKF'..video_ext
	video_out1 = video_path_noext..'_seg1'..video_ext
	video_out2 = video_path_noext..'_seg2'..video_ext

	-- get time cursor
	t1 = mp.get_property_number("time-pos")

	os.rename(video_path, video_in)
	
	strCmd0 = 'ffmpeg -stats -loglevel error -i "'..video_in..'" -vcodec libx264 -x264-params keyint=10:scenecut=0 -video_track_timescale 30000 -acodec copy "'..video_in2..'"'

	strCmd1 = 'ffmpeg -hide_banner -i "'..video_in2..'" -t "'..t1..'" -map "0:0" "-c:0" copy -map "0:1" "-c:1" copy -map_metadata 0 -movflags use_metadata_tags -movflags "+faststart" -default_mode infer_no_subs -ignore_unknown -f mp4 -y "'..video_out1..'"'
	
	strCmd2 = 'ffmpeg -hide_banner -ss "'..t1..'" -i "'..video_in2..'" -avoid_negative_ts make_zero -map "0:0" "-c:0" copy -map "0:1" "-c:1" copy -map_metadata 0 -movflags use_metadata_tags -movflags "+faststart" -default_mode infer_no_subs -ignore_unknown -f mp4 -y "'..video_out2..'"'

	print("[DEBUG] - strCmd0 = "..strCmd0)
	print("[DEBUG] - strCmd1 = "..strCmd1)
	print("[DEBUG] - strCmd2 = "..strCmd2)
	
	os.execute('echo '..strCmd0..' > '..vpath..'debugMPV')
	os.execute('echo '..strCmd1..' >Y '..vpath..'debugMPV')
	os.execute('echo '..strCmd2..' >> '..vpath..'debugMPV')

	os.execute(strCmd0)
	os.execute(strCmd1)
	os.execute(strCmd2)
	
end

mp.add_key_binding("a", "cut", cut)
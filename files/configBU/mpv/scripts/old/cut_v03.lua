function cut()
	
	t1 = mp.get_property_number("time-pos")
	mp.osd_message("Cut in 2 at "..t1)


	-- lfs = require "lfs"
	video_path = mp.get_property("path")
	-- video_path = "D:/Pictures/GoPro/IMPORT/converted/test/in.mp4
	
	vpath = video_path:match("(.*[/\\])")
	video_path_noext = string.sub(video_path, 1, -5)
	video_ext = string.sub(video_path, string.len(video_path) - 3, string.len(video_path))
	video_in = video_path_noext..'_old'..video_ext
	video_in2 = video_path_noext..'_oldwKF'..video_ext
	video_out1a = video_path_noext..'_seg1_temp'..video_ext
	video_out1b = video_path_noext..'_seg1'..video_ext
	video_out2 = video_path_noext..'_seg2'..video_ext


	-- Get video frame rate to calculate where to put the minimum keyframe possible
	local handle = io.popen("exiftool -T -VideoFrameRate "..video_path)
	local result = handle:read("*a")
	handle:close()
	key = result * t1
	-- print("[DEBUG] - t1 = "..t1)
	-- print("[DEBUG] - result = "..result)
	-- print("[DEBUG] - key = "..key)
	
	
	
	


	-- get time cursor

	os.rename(video_path, video_in)
	
	-- Add keyframes
	strCmd0 = 'ffmpeg -stats -loglevel error -i "'..video_in..'" -vcodec libx264 -x264-params keyint='..key..':scenecut=0 -video_track_timescale 30000 -acodec copy "'..video_in2..'"'

	-- Cut seg1
	strCmd1 = 'ffmpeg -hide_banner -i "'..video_in2..'" -t "'..t1..'" -map "0:0" "-c:0" copy -map "0:1" "-c:1" copy -map_metadata 0 -movflags use_metadata_tags -movflags "+faststart" -default_mode infer_no_subs -ignore_unknown -f mp4 -y "'..video_out1a..'"'
	
	-- Get the number of frame to remove the 2 last one from seg1 to have smooth transition when merging
	local handle = io.popen('ffprobe -v error -select_streams v:0 -count_frames -show_entries stream=nb_read_frames -print_format default=nokey=1:noprint_wrappers=1 "'..video_out1a..'"')
	local nf = handle:read("*a")
	handle:close()
	-- print("[DEBUG] - nf = "..nf)
	nf2 = nf - 2
	
	-- Remove 2 last frames from seg1
	strCmd2 = 'ffmpeg -i "'..video_out1a..'" -frames:v '..nf2..' -c:v copy -c:a copy "'..video_out1b..'"'
	
	-- Cut seg2
	strCmd3 = 'ffmpeg -hide_banner -ss "'..t1..'" -i "'..video_in2..'" -avoid_negative_ts make_zero -map "0:0" "-c:0" copy -map "0:1" "-c:1" copy -map_metadata 0 -movflags use_metadata_tags -movflags "+faststart" -default_mode infer_no_subs -ignore_unknown -f mp4 -y "'..video_out2..'"'

	-- print("[DEBUG] - strCmd0 = "..strCmd0)
	-- print("[DEBUG] - strCmd1 = "..strCmd1)
	-- print("[DEBUG] - strCmd2 = "..strCmd2)
	-- print("[DEBUG] - strCmd3 = "..strCmd3)
	
	-- os.execute('echo '..strCmd0..' > '..vpath..'debugMPV')
	-- os.execute('echo '..strCmd1..' >Y '..vpath..'debugMPV')
	-- os.execute('echo '..strCmd2..' >> '..vpath..'debugMPV')
	

	os.execute(strCmd0.." && "..strCmd1.." && "..strCmd2.." && "..strCmd3.." && del "..video_in2.." "..video_out1a)
	-- os.execute(strCmd0)
	-- os.execute(strCmd1)
	-- os.execute(strCmd2)
	-- os.execute(strCmd3)
	-- os.execute("del "..video_in2.." "..video_out1a)
	
end

mp.add_key_binding("a", "cut", cut)
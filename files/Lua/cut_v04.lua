function cut()
	
	ct = mp.get_property_number("time-pos")
	mp.osd_message("Cut in 2 at "..ct)


	-- lfs = require "lfs"
	video_path = mp.get_property("path")
	-- video_path = "D:/Pictures/GoPro/IMPORT/converted/test/in.mp4
	
	vpath = video_path:match("(.*[/\\])")
	video_path_noext = string.sub(video_path, 1, -5)
	video_ext = string.sub(video_path, string.len(video_path) - 3, string.len(video_path))
	video_in = video_path_noext..'_old'..video_ext
	video_out1 = video_path_noext..'_seg1'..video_ext
	video_out2 = video_path_noext..'_seg2'..video_ext

	os.rename(video_path, video_in)

	-- Get video frame rate to calculate where to put the minimum keyframe possible
	local handle = io.popen("exiftool -T -VideoFrameRate "..video_in)
	local fr = handle:read("*a")
	handle:close()
	fr = fr * 1
	cvf1 = math.floor(fr * ct)
	cvf2 = cvf1 + 1
	
	
	-- Get the number of frame to remove the 2 last one from seg1 to have smooth transition when merging
	local handle = io.popen('ffprobe -v error -select_streams v:0 -count_frames -show_entries stream=nb_read_frames -print_format default=nokey=1:noprint_wrappers=1 "'..video_in..'"')
	local vf = handle:read("*a")
	handle:close()
	vf = vf * 1
	-- print("[DEBUG] - vf = "..vf)
	
	local handle = io.popen('ffprobe -v error -select_streams a:0 -count_frames -show_entries stream=nb_read_frames -print_format default=nokey=1:noprint_wrappers=1 "'..video_in..'"')
	local af = handle:read("*a")
	handle:close()
	af = af * 1
	caf2 = math.floor(af / vf * cvf2)
	-- print("[DEBUG] - vf = "..vf)

	
	-- Cut seg1
	strCmd1 = 'ffmpeg -i "'..video_in..'" -frames:v '..cvf1..' -c:v copy -c:a copy -y "'..video_out1..'"'
	-- Cut seg2
	strCmd2 = 'ffmpeg -i "'..video_in..'" -vf select="between(n\\,'..cvf2..'\\,'..vf..'),setpts=PTS-STARTPTS" -af aselect="between(n\\,'..caf2..'\\,'..af..'),asetpts=PTS-STARTPTS" -y "'..video_out2..'"'
	
	debugcmd = "fr="..fr.."\nct="..ct.."\ncvf1="..cvf1.."\nvf="..vf.."\naf="..af.."\ncaf2="..caf2
	print("[DEBUG] - strCmd1 = "..strCmd1)
	print("[DEBUG] - strCmd2 = "..strCmd2)
	print("[DEBUG] - debugcmd = "..debugcmd)
	os.execute('echo "'..debugcmd..'" > '..vpath..'debugMPV')
	os.execute('echo '..strCmd1..' >> '..vpath..'debugMPV')
	os.execute('echo '..strCmd2..' >> '..vpath..'debugMPV')
	

	os.execute(strCmd1.." && "..strCmd2)
	-- os.execute(strCmd1)
	-- os.execute(strCmd2)
	
end

mp.add_key_binding("a", "cut", cut)
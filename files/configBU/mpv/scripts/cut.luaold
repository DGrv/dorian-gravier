function cut()

	-- lfs = require "lfs"
	video_path = mp.get_property("path")
	-- video_path = "D:/Pictures/GoPro/IMPORT/converted/test/in.mp4
	
	vpath = video_path:match("(.*[/\\])")
	video_path_noext = string.sub(video_path, 1, -5)
	video_ext = string.sub(video_path, string.len(video_path) - 3, string.len(video_path))
	video_in = video_path_noext..'_old'..video_ext
	video_out1 = video_path_noext..'_seg1'..video_ext
	video_out2 = video_path_noext..'_seg2'..video_ext

	-- get keyframes
	os.execute('ffprobe -v error -select_streams v -show_frames -print_format csv '..video_path..' | grep "frame,video,0,1" | perl -pe "s|frame,video,0,1,.*?,(.*?),.*|\\1|" > '..vpath..'tempfile')
	kf_file = vpath.."tempfile" -- # path to your file here
	
	-- read keyframe in a table
	-- https://stackoverflow.com/questions/29750989/text-file-to-lua-array-table
	kf = {}
	for line in io.lines(kf_file) do
	  --table.insert(kf, {line})
	  kf[#kf+1] = line
	end
  
	os.execute('ffprobe -v error -select_streams v -show_frames -print_format csv '..video_path..' | perl -pe "s|frame,video,0,.,.*?,(.*?),.*|\\1|" > '..vpath..'tempfile')
	af_file = vpath.."tempfile" -- # path to your file here
	
	-- read keyframe in a table
	-- https://stackoverflow.com/questions/29750989/text-file-to-lua-array-table
	af = {}
	for line in io.lines(af_file) do
	  --table.insert(kf, {line})
	  af[#af+1] = line
	end

	-- get time cursor
	t1 = mp.get_property_number("time-pos")
	os.rename(video_path, video_in)
	-- t1 = 2.402

	-- get closest kf 
	-- https://stackoverflow.com/questions/29987249/find-the-nearest-value
	initialdiff = 1000000000000
	selectedkey = -1
	for key, val in pairs(kf) do
	  print(key, val) -- print table
	  currentdiff = math.abs(val - t1)
	  if (currentdiff < initialdiff) then
		 initialdiff = currentdiff
		 selectedkey = key
	  end
	end
	ckf=kf[selectedkey]
  
	initialdiff = 1000000000000
	selectedkey = -1
	for key, val in pairs(af) do
	  print(key, val) -- print table
	  currentdiff = math.abs(val - t1)
	  if (currentdiff < initialdiff) then
		 initialdiff = currentdiff
		 selectedkey = key
	  end
	end
	caf=af[selectedkey-2]
  


	strCmd1 = 'ffmpeg -hide_banner -i "'..video_in..'" -t "'..caf..'" -map "0:0" "-c:0" copy -map "0:1" "-c:1" copy -map_metadata 0 -movflags use_metadata_tags -movflags "+faststart" -default_mode infer_no_subs -ignore_unknown -f mp4 -y "'..video_out1..'"'
	strCmd2 = 'ffmpeg -hide_banner -ss "'..ckf..'" -i "'..video_in..'" -avoid_negative_ts make_zero -map "0:0" "-c:0" copy -map "0:1" "-c:1" copy -map_metadata 0 -movflags use_metadata_tags -movflags "+faststart" -default_mode infer_no_subs -ignore_unknown -f mp4 -y "'..video_out2..'"'

	
	debug1 = "(echo file '"..vpath.."in_seg1.mp4' & echo file '"..vpath.."in_seg2.mp4' ) > "..vpath..'list.txt'
	debug2 = 'ffmpeg -safe 0 -f concat -i "'..vpath..'list.txt" -c copy -y "'..vpath..'output.mp4"'
  
	-- os.execute(debug1)
	-- os.execute(debug2)
	-- os.execute('echo '..strCmd1..' > '..vpath..'debugMPV')
	-- os.execute('echo '..strCmd2..' >> '..vpath..'debugMPV')
	-- os.execute('echo '..debug2..' >> '..vpath..'debugMPV')

	
	os.remove(kf_file)
	
	os.execute(strCmd1)
	os.execute(strCmd2)
	
end

mp.add_key_binding("c", "cut", cut)
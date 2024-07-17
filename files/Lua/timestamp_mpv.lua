
mp.add_key_binding("ö", function ()
	print("test timestamp")
	text = os.date("%X")
	print(text)
	mp.osd_message(text, 1000)
end)




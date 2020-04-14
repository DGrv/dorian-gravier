#Import a directory of text files as google keep notes.
#Text Filename is used for the title of the note.

import gkeepapi, os

username = 'youremail@gmail.com'
password = 'Yourpassword'

keep = gkeepapi.Keep()
success = keep.login(username,password)
dir_path = os.path.dirname(os.path.realpath(__file__))
for fn in os.listdir(dir_path):
	if os.path.isfile(fn) and fn.endswith('.txt'):
		print(fn)
		with open(fn, 'r') as mf:
			data=mf.read()
			keep.createNote(fn.replace('.txt',''), data)
			keep.sync();
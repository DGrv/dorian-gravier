import spotipy
from spotipy.oauth2 import SpotifyClientCredentials
from spotipy.oauth2 import SpotifyOAuth
from pprint import pprint
import os
from spotipy.oauth2 import SpotifyOAuth



def show_tracks(results):
	listm = []
	for i, item in enumerate(results['items']):
		track = item['track']
		# print("   %d %32.32s %s" %
			# (i, track['artists'][0]['name'], track['name']))
		# print(track['artists'][0]['name'] + " - " + track['name'])
		temp = track['artists'][0]['name'] + " " + track['name']
		# print(temp)
		listm.append(temp)
	listm.reverse()
	return listm






#Authentication - without user
os.environ["SPOTIPY_CLIENT_ID"]="yourid"
os.environ["SPOTIPY_CLIENT_SECRET"]="yoursecret"
os.environ["SPOTIPY_REDIRECT_URI"]="whatever"
# os.getenv("SPOTIPY_CLIENT_ID")



scope = 'playlist-read-private'
sp = spotipy.Spotify(auth_manager=SpotifyOAuth(scope=scope))

# your playlist uri
pl_id = "spotify:playlist:1nRUxTOZU2lpGE5iU73b6n"


value = input("\nHow many songs you wanna download ? ")
offset = input("\nSpotify API can only retrieve 100 songs, so if you have more you have to offset the query.\nOffset wanted ? (0 or more): ")



res=sp.playlist_tracks(playlist_id=pl_id, offset = offset)

musics = show_tracks(res)

os.chdir("C:\\Users\\doria\\Downloads\\Youtube_music\\")

# for music in musics:
for i in range(int(value)):
	print("\n-------------------------------\nDownloading :   " + musics[i] + "\n")
	code = 'yt-dlp ytsearch1:"' + musics[i] + '" -x --audio-format "mp3" --audio-quality 0 -c -o "%(uploader)s__-__%(title)s.%(ext)s"'
	print(code)
	os.system(code)


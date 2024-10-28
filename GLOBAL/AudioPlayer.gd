extends AudioStreamPlayer

var level_music 
var volume = -5

func _play_music(music: AudioStreamMP3, volume_):
	if stream == music:
		return
	level_music = music
	stream = music
	volume_db = volume_
	level_music.loop = true
	play()

func _play_music_level():
	if level_music != null:
		_play_music(level_music, volume)

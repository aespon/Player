extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	_on_musica_toggled(true)


func _on_musica_toggled(toggled_on):
	if toggled_on == true:
		AudioPlayer.volume = -10
		AudioPlayer._play_music_level()
	else:
		AudioPlayer.volume = -80
		AudioPlayer._play_music_level()

func _on_reset_pressed():
	get_tree().change_scene_to_file("res://LEVELS/LEVEL_1/SCENES/level_1.tscn")

func _on_menu_pressed():
	pass
	#get_tree().change_scene_to_file("res://MainMenu.tscn")

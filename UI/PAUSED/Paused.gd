extends Control

var pause = false

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		pause_menu()

func pause_menu():
	if pause:
		self.hide()
		get_tree().paused = false
		#Engine.time_scale = 1
		pause = false
	else:
		self.show()
		get_tree().paused = true
		pause = true

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
	get_tree().change_scene_to_file("res://MainMenu.tscn")


func _on_resume_pressed():
	self.hide()
	get_tree().paused = false
	#Engine.time_scale = 1
	pause = false

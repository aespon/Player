extends Control

func _ready():
	AudioPlayer._play_music_level()

func _on_play_pressed():
	get_tree().change_scene_to_file("res://UI/Cinematicas/Scenes/cinematicas_1.tscn")


func _on_quit_pressed():
	get_tree().quit()

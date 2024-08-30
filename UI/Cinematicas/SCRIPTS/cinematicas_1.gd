extends Control


@onready var video_stream_player = $VideoStreamPlayer
func _ready():
	
	AudioPlayer._play_music(null, -800)

func _on_video_stream_player_finished():
	get_tree().change_scene_to_file("res://UI/Cinematicas/Scenes/tutorial.tscn")


func _on_texture_button_pressed():
	video_stream_player.stop()
	get_tree().change_scene_to_file("res://UI/Cinematicas/Scenes/tutorial.tscn")

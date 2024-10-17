extends Control


func _input(event):
	if Input.is_action_just_pressed("shoot"):
			get_tree().change_scene_to_file("res://GLOBAL/otros/game.tscn")



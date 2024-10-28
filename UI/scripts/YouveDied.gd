extends CanvasLayer



func _on_menu_pressed():
	get_tree().change_scene_to_file("res://MainMenu.tscn")

func _on_try_again_pressed():
	NivelManager.change_level(Global.cave_level)




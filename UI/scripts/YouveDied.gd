extends CanvasLayer


@onready var player_ = get_tree().get_nodes_in_group("Player")[0]
func _on_menu_pressed():
	get_tree().change_scene_to_file("res://MainMenu.tscn")

func _on_try_again_pressed():
	get_tree().paused = false
	Global.health = 1000
	player_.set_dead(false)
	self.hide()
	NivelManager.change_level(Global.cave_level)


#func _process(delta):
	#if visible:
		#get_tree().paused = true
	#else:
		#get_tree().paused = false




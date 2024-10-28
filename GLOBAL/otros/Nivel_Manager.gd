extends Node2D
 

var old_level
var current_level
var old_level_number : int = 0
var level= [
	preload("res://Tutorial.tscn"),
	preload("res://LEVELS/LEVEL_1/SCENES/level_1.tscn"),
	preload("res://LEVELS/LEVEL_2/SCENES/level_2.tscn")
	]
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func change_level(level_number : int):
	old_level_number = level_number
	var jugador =  get_tree().get_nodes_in_group("Player")[0]
	var child_count = get_child_count()
	
	print(child_count)
	
	old_level = current_level
	if old_level != null:  old_level.queue_free()
	current_level = level[level_number].instantiate()
	add_child(current_level)
	jugador.crystals_collected = 0
	current_level.set_player_position(jugador)

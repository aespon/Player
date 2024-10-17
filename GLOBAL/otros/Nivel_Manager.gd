extends Node2D

@onready var jugador = $"../Jugador"

var old_level
var current_level
var level= [preload("res://LEVELS/LEVEL_1/SCENES/level_1.tscn"),
preload("res://LEVELS/LEVEL_2/SCENES/level_2.tscn")]
# Called when the node enters the scene tree for the first time.
func _ready():
	current_level = level[0].instantiate()
	add_child(current_level)
	current_level.set_player_position(jugador)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func change_level(level_number : int):
	old_level = current_level
	current_level = level[level_number].instantiate()
	add_child(current_level)
	current_level.set_player_position(jugador)

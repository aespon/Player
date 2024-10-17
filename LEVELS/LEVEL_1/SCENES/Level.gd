extends Node2D
class_name Level

@onready var player_start_position = $Player_Start_Position
@onready var map = $Map

# Called every frame. 'delta' is the elapsed time since the previous frame.


func set_player_position(player:Player):
	player.position = player_start_position.position

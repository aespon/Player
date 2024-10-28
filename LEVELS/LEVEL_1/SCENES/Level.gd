extends Node2D
class_name Level

@onready var player_start_position = $Player_Start_Position
@export var music : AudioStreamMP3
@export var volumen : int

func _ready():
	AudioPlayer._play_music(music , volumen)
func set_player_position(player:Player):
	player.position = player_start_position.position

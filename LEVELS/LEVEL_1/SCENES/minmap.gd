extends SubViewport

@onready var camera_2d = $Camera2D
@onready var player_ = get_tree().get_nodes_in_group("Player")[0]
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var player_position = player_.position
	camera_2d.position = player_position

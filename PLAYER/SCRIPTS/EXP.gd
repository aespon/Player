extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	max_value = Global.experience_level
	value = Global.experience_player

func _process(_delta):
	value = Global.experience_player
	if (value >= max_value):
		Global.level = Global.level + 1

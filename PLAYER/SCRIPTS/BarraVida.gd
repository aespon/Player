extends ProgressBar

var maxvalue

func _ready():
	maxvalue = Global.health
	max_value = maxvalue

func _physics_process(_delta):
	value = Global.health

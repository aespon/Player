extends Node2D

@export var crystals_needed : int = 0
var starting_item = false
signal item_spawn
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body == Player:
		if starting_item == false:
			item_drop()


func item_drop():
	print("menu")
	starting_item = true


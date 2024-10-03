extends Area2D

@onready var sprite_2d = $Sprite2D




func _on_area_entered(_area):
	sprite_2d.visible = true
	pass # Replace with function body.

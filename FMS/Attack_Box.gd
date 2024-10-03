extends Area2D
class_name Attack_Box

@export var damage : int = 1

func _ready():
	area_entered.connect(hit)

func hit(area):
	if area is Hurt_Box:
		area.take_damage(damage)

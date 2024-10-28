extends Area2D

class_name Hurt

signal DamageTaken
signal Dead
signal HealthChanged

@export var health : int

var current_health : int = 0
var old_health : int = 0

func _ready():
	current_health = health

func get_health(heal):
	var value = abs(heal)
	set_health(value)

func take_damage(damage : int):
	var  value = abs(damage)
	set_health(-value)

func set_health(value):
	old_health = current_health
	current_health += value
	current_health = clamp(current_health, 0, health)
	
	if old_health != current_health:
		HealthChanged.emit(current_health)
	if current_health <= 0:
		dead()
		return
	elif current_health > 0 and current_health < old_health:
		DamageTaken.emit()
		

func dead():
	Dead.emit()

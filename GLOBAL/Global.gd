extends Node

#VARIABLES JUGADOR
var health = 1500
var damage_mele = 15.0
var damage_shoot = 7.5
var bulletname = "StaticBody2D"
var dash_counter = 1
var dash_bool = false

#VARIABLES NIVELES
var experience_player = 0
var experience_level = 500
var level = 1
var cave_level  = 1
var next_level = 0.0

func _process(_delta):
	if health <= 0:
		get_tree().reload_current_scene()
	experience_level = 500 + (150 * level)

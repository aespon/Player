extends Node2D

@onready var collision_shape_2d = $StaticBody2D/CollisionShape2D
@onready var player_detect = $Player_Detect
@onready var crital_naranja = $"StaticBody2D/Crital-naranja"
@onready var vfx = $StaticBody2D/VFX
@onready var animation_player = $AnimationPlayer

signal player_entered
var perma_door = false

func _ready():
	animation_player.play("Door_Closed")

func _on_player_detect_body_entered(body):
	print(body.name)
	if player_detect.has_overlapping_bodies():
		for a in player_detect.get_overlapping_bodies():
			if a is StaticBody2D:
				animation_player.play("Door_Open")
	if body.name == "Jugador":
		emit_signal("player_entered")
		print("bb")

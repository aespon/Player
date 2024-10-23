extends Node2D

@onready var animation_player = $AnimationPlayer
const CRYSTALS = preload("res://GLOBAL/otros/crystals.tscn")
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
			animation_player.play("enter")
			starting_item = true


func item_drop():
	print("menu")
	var crystal = CRYSTALS.instantiate()
	crystal.type = 1


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "enter":
		animation_player.play("new_animation")

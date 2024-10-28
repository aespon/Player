extends Node2D

@onready var animation_player = $AnimationPlayer
const CRYSTALS = preload("res://GLOBAL/otros/crystals.tscn")
@export var crystals_needed : int = 0
signal item_spawn
# Called when the node enters the scene tree for the first time.
@onready var marker_2d = $Marker2D
@onready var player_ = get_tree().get_nodes_in_group("Player")[0]

@export var next : int


func _on_area_2d_body_entered(body):
	var starting_item = player_.starting_item
	print("bb")
	if starting_item == false:
		animation_player.play("enter")
		starting_item = true
		player_.starting_item = true
	if player_.crystals_collected == crystals_needed:
		Global.cave_level = next
		NivelManager.change_level(next)
		

func item_drop():
	print("menu")
	var crystal = CRYSTALS.instantiate()
	crystal.position = marker_2d.position
	crystal.type = 1
	add_child(crystal)
	emit_signal("item_spawn")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "enter":
		animation_player.play("new_animation")
	if anim_name == "new_animation":
		animation_player.play("idle")

extends Node2D

@export var type : int
@onready var crystal_level_next = $CrystalLevelNext
@export var upgrade_type : String
var target
var speed = -1
@onready var player_ = get_tree().get_nodes_in_group("Player")[0]
@onready var crystal_collects = $crystal_collects

func _physics_process(delta):
	if target != null:
		global_position = global_position.move_toward(target.global_position, speed)
		speed += 5 * delta
# Called when the node enters the scene tree for the first time.
func _ready():
	match  type:
		0 : 
			crystal_level_next.modulate = Color("#ffffff")
			upgrade_type = ""
			crystal_collects.name = "crystal_collect"
		1 : 
			crystal_level_next.modulate = Color("#ff0000")
			upgrade_type = "efecto"
		2 : 
			crystal_level_next.modulate = Color("#7effa0")
			upgrade_type = "estadistica"
		3 : 
			crystal_level_next.modulate = Color("#ffd100")
			


func _on_area_2d_body_entered(body):
	if body is Player:
		target = player_
		if upgrade_type != "":
			player_.player_upgrade(upgrade_type)
		if type == 3:
			player_.vampirismo_function()
	queue_free()

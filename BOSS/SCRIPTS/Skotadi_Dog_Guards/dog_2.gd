extends Enemy

@onready var points = $Points
@onready var x = points.position
@onready var player_ = get_tree().get_nodes_in_group("Player")[0]

@onready var animation_player = $Sprite/AnimationPlayer
@onready var sprite_2d = $Sprite/Dog_2_Sprite
@onready var progress_bar = $ProgressBar
@export var FMS_Dog1 : Finate_State_Machine
var angle_to_player
@onready var animation = FMS_Dog1.current_state.name 
@onready var hurt_box = $Hurt_Box
@onready var detector_y = $DetectorY
@export var exp_gem : PackedScene
@export var experience : int = 0

const CRYSTALS = preload("res://GLOBAL/otros/crystals.tscn")
var direction


func _physics_process(delta):
	
	if FMS_Dog1 != null:
		animation_player.play(animation)
	var player_position = player_.position
	direction = (player_.position - global_position).normalized()
	detector_y.target_position = direction * 200
	angle_to_player = global_position.direction_to(player_position).angle()
	sprite_2d.rotation = move_toward(rotation, angle_to_player, delta*200)
	points.position = x
	move_and_slide()



func damage_taken():
	animation_player.play("IDLE")
	progress_bar.value = hurt_box.current_health



func dead():
	animation_player.play("DEATH")
	if FMS_Dog1 != null : FMS_Dog1.queue_free()
	await get_tree().create_timer(1).timeout
	emit_signal("enemy_is_dead")
	var crystal = CRYSTALS.instantiate()
	crystal.position = position
	crystal.type = 0
	get_parent().get_parent().add_child(crystal)
	var new_gem = exp_gem.instantiate()
	new_gem.global_position = position
	new_gem.experience = experience
	get_parent().get_parent().add_child(new_gem)
	queue_free()

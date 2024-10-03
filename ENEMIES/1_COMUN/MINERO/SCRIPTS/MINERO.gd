extends CharacterBody2D

@onready var points = $Points
@onready var x = points.position
@onready var player_ = get_tree().get_nodes_in_group("Player")[0]
@onready var animation_player = $Sprite/AnimationPlayer
@onready var sprite_2d = $Sprite/Dog_2_Sprite
@onready var progress_bar = $ProgressBar
@onready var FSM_MINERO = $FSM
var angle_to_player
@onready var animation = FSM_MINERO.current_state.name 
@onready var detector_y = $DetectorY
@onready var detectorx = $Detectorx
@onready var hurt_box = $Hurt_Box


var direction

func _ready():
	hurt_box.Dead.connect(dead)
	hurt_box.DamageTaken.connect(damage_taken)

func _physics_process(_delta):
	if FSM_MINERO != null:
		_animation_handler()

func _animation_handler():
	var player_position = player_.position
	animation = FSM_MINERO.current_state.name
	if animation == "ATTACK":
		var direction_degree = deg_to_rad(detectorx.rotation)
		var degree = floor(direction_degree)
		if degree == 1:
			animation_player.play("ATTACK_LEFT")
		else:
			animation_player.play("ATTACK_DOWN")
	else:
		animation_player.play(animation)
	angle_to_player = global_position.direction_to(player_position).angle()
	points.position = x
	direction = (player_.position - global_position).normalized()
	detectorx.target_position = direction * 2 
	detector_y.target_position = direction * 250
		
	move_and_slide()

func damage_taken():
	animation_player.play("IDLE")
	progress_bar.value = hurt_box.current_health

func dead():
	animation_player.play("DEATH")
	if FSM_MINERO != null : FSM_MINERO.queue_free()
	await get_tree().create_timer(1).timeout
	Global.experience_player = Global.experience_player + 10
	print(Global.experience_player)
	queue_free()

extends Enemy

@onready var points = $Points
@onready var x = points.position
@onready var player_ = get_tree().get_nodes_in_group("Player")[0]
@onready var animation_player = $Sprite/AnimationPlayer
@onready var sprite_2d = $Sprite/Sprite2D
@onready var progress_bar = $ProgressBar
@onready var FSM = $FSM
var angle_to_player
@onready var animation = FSM.current_state.name 

@onready var detectorx = $Detectorx
@onready var hurt_box = $Hit_Detector
@onready var HURT = $HURT

@export var healing : PackedScene
@export var exp_gem : PackedScene
@export var experience : int = 1

var direction

func _ready():
	hurt_box.Dead.connect(dead)
	hurt_box.DamageTaken.connect(damage_taken)
	print("vida")

func _physics_process(_delta):
	if FSM != null:
		_animation_handler()
	move_and_slide()
	
func _animation_handler():
	var player_position = player_.position
	animation = FSM.current_state.name
	angle_to_player = global_position.direction_to(player_position).angle()
	points.position = x
	direction = (player_.position - global_position).normalized()
	detectorx.target_position = direction * 200
	if animation == "ATTACK":
			detect_direction_and_animate()
	else:
		animation_player.play(animation)


func detect_direction_and_animate():
	var player_pos = player_.global_position
	var enemy_pos = global_position
	
	var diff = player_pos - enemy_pos  # Difference between player and enemy positions
	
	# Compare the absolute differences to determine the primary axis of movement
	if abs(diff.x) > abs(diff.y):
		# Horizontal movement (left or right)
		if diff.x > 0:
			play_animation("right")  # Player is to the right
		else:
			play_animation("left")   # Player is to the left
	else:
		# Vertical movement (up or down)
		if diff.y > 0:
			play_animation("down")   # Player is below
		else:
			play_animation("up")     # Player is above

func play_animation(directions):
	match directions:
		"right":
			animation_player.play("SHOOT_RIGHT")
		"left":
			animation_player.play("SHOOT_LEFT")
		"up":
			animation_player.play("SHOOT_UP")
		"down":
			animation_player.play("SHOOT_DOWN")

func damage_taken():
	animation_player.play("IDLE")
	HURT.play("HURT")
	progress_bar.value = hurt_box.current_health

func dead():
	direction = position
	animation_player.play("DEATH")
	if FSM != null : FSM.queue_free()
	await get_tree().create_timer(1).timeout
	#Global.experience_player = Global.experience_player + 10
	#print(Global.experience_player)
	if player_.vampirismo == true:
		if randf() < 0.2:
			var heal = healing.instantiate()
			heal.type = 3
			get_parent().get_parent().add_child(heal)
	var new_gem = exp_gem.instantiate()
	new_gem.global_position = direction
	new_gem.experience = experience
	get_parent().get_parent().add_child(new_gem)
	emit_signal("enemy_is_dead")
	queue_free()

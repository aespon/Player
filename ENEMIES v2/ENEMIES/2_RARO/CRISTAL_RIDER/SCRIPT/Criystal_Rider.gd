extends Enemy

@onready var points = $Points
@onready var hurt = $HURT
@onready var x = points.position
@onready var player_ = get_tree().get_nodes_in_group("Player")[0]
@onready var animation_player = $Sprite/AnimationPlayer
@onready var sprite_2d = $Sprite/AnimatedSprite2D
@onready var progress_bar = $ProgressBar
@onready var FSM = $FSM
@export var skotadi : PackedScene

var angle_to_player
@onready var animation = FSM.current_state.name 
@onready var detectorx = $RayCast2D
@onready var hurt_box = $Hurt_Box


var direction

func _ready():
	hurt_box.Dead.connect(dead)
	hurt_box.DamageTaken.connect(damage_taken)

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
			animation_player.play("ATTACK_RIGHT")
		"left":
			animation_player.play("ATTACK_LEFT")
		"up":
			animation_player.play("ATTACK_UP")
		"down":
			animation_player.play("ATTACK_DOWN")

func damage_taken(): 
	print("enemy damage taken")
	print(hurt_box.current_health)
	hurt.play("HURT")
	progress_bar.value = hurt_box.current_health

func dead():
	animation_player.play("DEATH")
	if FSM != null : FSM.queue_free()
	await get_tree().create_timer(1).timeout
	#Global.experience_player = Global.experience_player + 10
	#print(Global.experience_player)
	var skotadi_guardia = skotadi.instantiate()
	skotadi_guardia.global_position = Vector2(0,0)
	skotadi_guardia.enemy_is_dead.connect(get_parent().dead_enemy)
	get_parent().add_child(skotadi_guardia)
	
	queue_free()

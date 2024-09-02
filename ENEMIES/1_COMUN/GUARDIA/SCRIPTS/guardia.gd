extends CharacterBody2D

@onready var points = $Points
@onready var x = points.position
@onready var player_ = get_tree().get_nodes_in_group("Player")[0]
var life = 300
@onready var animation_player = $Sprite/AnimationPlayer
@onready var sprite_2d = $Sprite/Sprite2D
@onready var progress_bar = $ProgressBar
@onready var FSM = $FSM
var angle_to_player
@onready var animation = FSM.current_state.name 
@onready var detector_y = $DetectorY
@onready var detectorx = $Detectorx


var direction

func _ready():
	life = 300
	print("vida")
	print(life)

func _physics_process(_delta):
	if FSM != null:
		_animation_handler()

func _animation_handler():
	var player_position = player_.position
	if life > 0:
		animation = FSM.current_state.name
		if animation == "SHOOT":
			var direction_degree = deg_to_rad(detectorx.rotation)
			var degree = floor(direction_degree)
			if degree == 1:
				animation_player.play("SHOOT_LEFT")
			else:
				animation_player.play("SHOOT_DOWN")
		else:
			animation_player.play(animation)
		angle_to_player = global_position.direction_to(player_position).angle()
		points.position = x
		direction = (player_.position - global_position).normalized()
		detectorx.target_position = direction * 2 
		detector_y.target_position = direction * 400
	elif life <= 0:
		animation_player.play("DEATH")
		FSM.queue_free()
		await get_tree().create_timer(1).timeout
		Global.experience_player = Global.experience_player + 10
		print(Global.experience_player)
		
		queue_free()
		
	move_and_slide()
	print(animation)

func _on_hit_detector_area_entered(area):
	if life > 0:
		if area.name == "Collission":
			life = life - Global.damage_shoot
		elif area.name == "Range":
			life = life - Global.damage_mele
	print("vida")
	print( life)
	progress_bar.value = life


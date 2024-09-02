extends CharacterBody2D

@onready var points = $Points
@onready var x = points.position
@onready var player_ = get_tree().get_nodes_in_group("Player")[0]
@onready var life = 225
@onready var animation_player = $Sprite/AnimationPlayer
@onready var sprite_2d = $Sprite/Sprite2D
@onready var progress_bar = $ProgressBar
@onready var FSM_MINERO = $Finate_State_Machine
var angle_to_player
@onready var animation = FSM_MINERO.current_state.name 
@onready var detector_y = $Detector1
@onready var detectorx = $Detector2


var direction


func _physics_process(delta):
	if FSM_MINERO != null:
		_animation_handler()
		
func _animation_handler():
	var player_position = player_.position
	if life > 0:
		animation = FSM_MINERO.current_state.name 
		if animation == "JUMP":
			var direction_degree = deg_to_rad(detectorx.rotation)
			var degree = floor(direction_degree)
			if degree == 1:
				animation_player.play("JUMP_LEFT")
			else:
				animation_player.play("JUMP_DOWN") #LA ANIMACION DE JUMP ES DEFINIDA POR LA DIRCCION DEL SEGUNDO RAYCAST
		else:
			animation_player.play(animation)
		angle_to_player = global_position.direction_to(player_position).angle()
		points.position = x
		direction = (player_.position - global_position).normalized()
		detectorx.target_position = direction * 2 
		detector_y.target_position = direction * 200 #TAMAÑO DE LOS RAYCAST
	elif life <= 0:
		animation_player.play("DEATH")
		FSM_MINERO.queue_free()
		await get_tree().create_timer(1).timeout
		Global.experience_player = Global.experience_player + 10
		print(Global.experience_player)
		queue_free()
	
	print(animation)
	move_and_slide()


func _on_htibox_area_entered(area):
	if life > 0:
		if area.name == "Collission":
			life = life - Global.damage_shoot
		elif area.name == "Range":
			life = life - Global.damage_mele
	print(life)
	progress_bar.value = life

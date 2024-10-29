extends State

@export var timer : Timer
@export var timer_time := 0.0
@export var attack_detector : Area2D
@export var bullets : PackedScene
@export var chase_speed := 75.0
@export var Navigator : NavigationAgent2D

@export var radius : float = 1.5

@export var previous_state  = ""
@export_enum("Mele" , "Shoot") var type_of_attack : String
@export_enum("1 RAYCAST" , "2 RAYCAST") var ray_casts : String
@export_group("Type of Chase")
@export_enum("Freely" , "X and Y axis", "still") var type_of_chase : String
@export var player_detector_1 : RayCast2D 
@export var player_detector_2 : RayCast2D
@export var player_direction : RayCast2D
var target 
var moving_in_x = false
var moving_in_y = false

func enter():
	attack_detector.body_exited.connect(attack_dtector_exited)
	


func on_shoot_timeout():
	var bullet = bullets.instantiate()
	bullet.position = global_position
	bullet.direction = (player_direction.target_position).normalized()
	get_tree().current_scene.add_child(bullet)
	var _direction = (player.position - global_position).normalized()
	


func attack_dtector_exited(body):
	if body.name == "Jugador":
		transitioned.emit(self, previous_state)

func process_state(_delta):
	if type_of_chase == "Freely":
		freely()
	if type_of_chase == "X and Y axis":
		x_or_y_walk()
	if type_of_chase == "sill":
		still()
	pass

## TYPES STUFF

func freely():
	target = player
	var current_agent_position
	var next_path_position 
	var new_velocity  = 0
	if Navigator != null:
		Navigator.target_position = target.global_position
	
		current_agent_position = global_position
		next_path_position = Navigator.get_next_path_position()
		new_velocity = current_agent_position.direction_to(next_path_position) * chase_speed 
	

	owner.velocity = new_velocity

func x_or_y_walk():
	if player_detector_1.is_colliding():
		var collision_obj = player_detector_1.get_collider()
		if collision_obj == player:
			moving_in_x = true
			moving_in_y = false  # Disable Y movement if X movement is active

	elif player_detector_2.is_colliding():
		var collision_obj = player_detector_2.get_collider()
		if collision_obj == player:
			moving_in_y = true
			moving_in_x = false  # Disable X movement if Y movement is active

	# Call the movement function
	move_to_player()

func move_to_player():
	if player == null:
		return

	var target_pos = player.global_position
	
	if moving_in_x:
		# Move only in the X axis direction
		var new_velocity = Vector2(sign(target_pos.x - global_position.x), 0) * chase_speed
		owner.velocity = new_velocity

	elif moving_in_y:
		# Move only in the Y axis direction
		var new_velocity = Vector2(0, sign(target_pos.y - global_position.y)) * chase_speed
		owner.velocity = new_velocity


func still():
	owner.velocity = 0

func exit():
	attack_detector.body_exited.disconnect(attack_dtector_exited)


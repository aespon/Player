extends State


@export var Navigator : NavigationAgent2D

@export var timer_chase : Timer

@export var player_detector_1 : RayCast2D
@export var player_detector_2 : RayCast2D

var target

@export var attack_detector : Area2D

@export var chase_speed := 75.0

@export var timer_time := 0.0

@export var previous_state  = ""
@export var next_state = ""

func enter():
	timer_chase.wait_time = timer_time
	timer_chase.start()
	if !timer_chase.timeout.connect(on_time_out):
		timer_chase.timeout.connect(on_time_out)
	attack_detector.body_entered.connect(attack_dtector_entered)
	pass

func on_time_out():
	if not player_detector_1.is_colliding() or not player_detector_2.is_colliding():
		transitioned.emit(self, previous_state)
	else:
		timer_chase.start()
	pass

func attack_dtector_entered(_body):
	transitioned.emit(self, next_state)
	pass

func process_state(_delta: float):
	
	target = player
	Navigator.target_position = target.position
	
	var current_agent_position = global_position
	var next_path_position = Navigator.get_next_path_position()
	var new_velocity = current_agent_position.direction_to(next_path_position) * chase_speed
	
	
	
	owner.velocity = new_velocity
	pass




func exit():
	timer_chase.stop()


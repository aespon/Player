extends State


@export var timer_time := 0.0

@export var attack_detector : Area2D

@export var damage := 0.0

@export var chase_speed := 75.0

@export var Navigator : NavigationAgent2D


var target

@export var previous_state  = ""




func enter():
	attack_detector.damage = damage
	attack_detector.body_exited.connect(attack_dtector_exited)




func attack_dtector_exited(body):
	if body.name == "Jugador":
		transitioned.emit(self, previous_state)

func process_state(_delta):
	target = player
	Navigator.target_position = target.position

	var current_agent_position = global_position
	var next_path_position = Navigator.get_next_path_position()
	var new_velocity = current_agent_position.direction_to(next_path_position) * chase_speed
	owner.velocity = new_velocity


func exit():
	attack_detector.body_exited.disconnect(attack_dtector_exited)


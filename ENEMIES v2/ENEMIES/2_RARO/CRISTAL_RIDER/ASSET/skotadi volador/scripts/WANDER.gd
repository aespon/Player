extends State


@export var timer_wander : Timer

@export var wander_speed = 0.0

@export var Points : Node

@export var next_point : Timer

@export var Navigator : NavigationAgent2D

@export var player_detector_1 : RayCast2D 
@export var player_detector_2 : RayCast2D
@export var timer_wait_time = 0.0

@export var previous_state  = ""
@export var next_state = ""

var point_pos = 0
var target
@export_enum("1 RAYCAST" ,"2 RAYCAST") var ray_cast : String

func enter():
	timer_wander.timeout.connect(on_timeout)
	next_point.timeout.connect(on_next_point_timeout)
	timer_wander.wait_time = timer_wait_time
	timer_wander.start()
	next_point.start()
	next_point.autostart = true

func on_next_point_timeout():
	
	point_pos = point_pos+1
	target = Points.get_child(point_pos)
	if point_pos == 3:
		point_pos = 0



func on_timeout():
	transitioned.emit(self , previous_state)


func process_state(_delta):
	if is_instance_valid(target):
		Navigator.target_position = target.global_position
	
	var current_agent_position = global_position
	var next_path_position = Navigator.get_next_path_position()
	var new_velocity = current_agent_position.direction_to(next_path_position) * wander_speed 
	
	
	if ray_cast == "1 RAYCAST":
		one_raycast()
	elif ray_cast == "2 RAYCAST":
		two_raycast()
	
	owner.velocity = new_velocity
	
	pass

func one_raycast():
	if player_detector_1.is_colliding():
		transitioned.emit(self, next_state)

func two_raycast():
	if player_detector_1.is_colliding():
		transitioned.emit(self, next_state)
		last_raycast = 1
	elif player_detector_2.is_colliding():
		transitioned.emit(self, next_state)
		last_raycast = 2
	pass


func exit():
	timer_wander.timeout.disconnect(on_timeout)
	next_point.timeout.disconnect(on_next_point_timeout)
	timer_wander.stop()
	next_point.stop()

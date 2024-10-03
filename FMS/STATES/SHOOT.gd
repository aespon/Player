extends State


@export var timer_bullet_cooldown : Timer

@export var timer_time := 0.0

@export var ray_cast : RayCast2D

@export var damage := 0.0

@export var chase_speed := 75.0

@export var Navigator : NavigationAgent2D

@export var bullets : PackedScene

var target
var direction

@export var previous_state  = ""

# Called when the node enters the scene tree for the first time.

func enter():
	timer_bullet_cooldown.timeout.connect(on_timeout)
	timer_bullet_cooldown.wait_time = timer_time
	timer_bullet_cooldown.start()
	

func on_timeout():
	var bullet = bullets.instantiate()
	bullet.position = global_position
	bullet.direction = (ray_cast.target_position).normalized()
	get_tree().current_scene.add_child(bullet)
	direction = (player.position - global_position).normalized()
	timer_bullet_cooldown.start()

func process_state(_delta):
	target = player
	Navigator.target_position = -target.position
	
	var current_agent_position = global_position
	var next_path_position = Navigator.get_next_path_position()
	var new_velocity = current_agent_position.direction_to(next_path_position) * chase_speed
	owner.velocity = new_velocity
	if !ray_cast.is_colliding():
		transitioned.emit(self, previous_state)
		

func _exit():
	timer_bullet_cooldown.stop()
	timer_bullet_cooldown.timeout.disconnect(on_timeout)

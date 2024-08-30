extends CharacterBody2D

class_name Player

@export var max_speed = 200
@export var acceleration = 400
@export var friction = 900
@onready var range_ = $GUN/Range
@onready var timer = $GUN/Range/Timer
@onready var animation_player = $AnimationPlayer

var health = Global.health 
var input = Vector2.ZERO


@onready var paused = $Camera2D/Paused
var pause = false

func _physics_process(delta):
	player_movement(delta)
	
#Esta funcion hace que se mueva el perosaje con los controles

func on_time_out():
	range_.collision_mask = 5
	range_.collision_layer = 3

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		pause_menu()
	if event.is_action_pressed("punch"):
		range_.collision_mask = 2
		range_.collision_layer = 2
		timer.start()
		timer.timeout.connect(on_time_out)
		
	if Input.is_action_pressed("ui_down"):
		animation_player.play("Down")
	elif Input.is_action_pressed("ui_left"):
		animation_player.play("Left")
	elif Input.is_action_pressed("ui_right"):
		animation_player.play("Right")
	elif Input.is_action_pressed("ui_up"):
		animation_player.play("Top")
	else:
		animation_player.stop()
func get_input():

	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return input.normalized()

#esta funcion hace que el personaje cuando se deja de mover pare lentamente

func player_movement(delta):
	
	input = get_input()
	@warning_ignore("shadowed_variable_base_class")
	var velocity = get_velocity()
	
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (input * acceleration * delta)
		velocity = velocity.limit_length(max_speed)
	set_velocity(velocity)
		
	move_and_slide()

func pause_menu():
	if pause:
		paused.hide()
		Engine.time_scale = 1
		pause = false
	else:
		paused.show()
		Engine.time_scale = 0
		pause = true


func dead():
		get_tree().reload_current_scene()





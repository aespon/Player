extends CharacterBody2D

class_name Player

@export var max_speed = 200
@export var acceleration = 400
@export var friction = 900
@onready var range_ = $GUN/Range
@onready var timer = $GUN/Range/Timer
@onready var animation_player = $AnimationPlayer
@onready var hurt_box = $Hurt_Box

var health = Global.health 
var input = Vector2.ZERO

var punch : bool = false

@onready var paused = $Camera2D/Paused
var pause = false

func _ready():
	hurt_box.Dead.connect(dead)
	hurt_box.DamageTaken.connect(damage_taken)

func _physics_process(delta):
	player_movement(delta)
	
#Esta funcion hace que se mueva el perosaje con los controles

func on_time_out():
	range_.monitorable = false
	punch = false

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		pause_menu()
	if event.is_action_pressed("punch") and punch == false:
		range_.monitorable = true
		punch = true
		print("punched")
		timer.start()
	
		
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
	
	if input != Vector2.ZERO:
		velocity += (input * acceleration * delta)
		velocity = velocity.limit_length(max_speed)
	else:
		velocity = Vector2(0 , 0)
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

func damage_taken():
	Global.health = hurt_box.current_health
	print("bbbbb")
	pass

func dead():
		get_tree().reload_current_scene()





extends CharacterBody2D

class_name Player

@export var max_speed = 200
var shoot_damage : int 
var mele_damage : int

#VARIABLES ITEMS 
var Inventario = []

#VARIABLES MEJORAS

var largo_impacto = false
var terremoto = false
var replica = false
var multidisparo = false

#VARIABLES ESTADISTICAS

var vida_aumento_nivel
var vida_aumento
var velocidad_aumento_nivel
var velocidad_aumento
var mele_aumento_nivel
var mele_aumento
var shoot_aumento_nivel
var shoot_aumento

#VARIABLES EFECTOS
var revivir = false
var vampirismo = false

#OBJETOS PLAYER
@onready var range_ = $GUN/Range
@onready var timer = $GUN/Range/Timer
@onready var animation_player = $AnimationPlayer
@onready var hurt_box = $Hurt_Box

#VARIABLES PLAYER
var health = Global.health 
var input = Vector2.ZERO

var punch : bool = false

#VARIABLES UI
@onready var paused = $Paused
@onready var youve_died = $YouveDied
var pause = false

func _ready():
	hurt_box.Dead.connect(dead)
	hurt_box.DamageTaken.connect(damage_taken)
	youve_died.visible = false

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


func player_movement(_delta):
	

	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	input = input.normalized()
	if input:
		velocity = input * max_speed 
	else:
		velocity = input
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
	print(Global.health)
	print("bbbbb")
	pass

func dead():
		youve_died.visible = true


func _on_loot_collect_area_entered(area):
	
	pass # Replace with function body.


func _on_collect_area_entered(area):
	pass # Replace with function body.


func calculate_exp():
	pass
	

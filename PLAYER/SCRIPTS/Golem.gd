extends CharacterBody2D

class_name Player

@export var max_speed = 200
@export var shoot_damage : int 
@export var mele_damage : int

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
var speed_boost = false
var armadura = false                

#OBJETOS PLAYER
@onready var range_ = $GUN/MELE
#@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var hurt_box = $Hurt_Box
@onready var hurt = $HURT
@onready var upgrades = $Upgrades

#VARIABLES PLAYER
var health = Global.health 
var input = Vector2.ZERO
var direction : Vector2 = Vector2.ZERO

var shoot : bool = false
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

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		pause_menu()
	
	
		
	#if Input.is_action_pressed("ui_down"):
		#animation_player.play("Down")
	#elif Input.is_action_pressed("ui_left"):
		#animation_player.play("Left")
	#elif Input.is_action_pressed("ui_right"):
		#animation_player.play("Right")
	#elif Input.is_action_pressed("ui_up"):
		#animation_player.play("Top")
	#else:
		#animation_player.stop()

func player_movement(_delta):
	

	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	input = input.normalized()
	if input:
		velocity = input * max_speed 
	else:
		velocity = input
	move_and_slide()

func _process(_delta):
	direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	
	if direction != Vector2.ZERO and not punch:
		set_walking(true)
		update_blend_position()
	else:
		set_walking(false)
		
	if Input.is_action_just_pressed("punch"):
		set_mele(true)
	if Input.is_action_just_pressed("shoot"):
		set_shoot(true)
	
func set_walking(value):
	animation_tree["parameters/conditions/is_walking"] = value
	animation_tree["parameters/conditions/idle"] = not value

func set_dead(value):
	animation_tree["parameters/conditions/is_dead"] = value
	animation_tree["parameters/conditions/idle"] = not value

func set_shoot(value = false):
	shoot = value
	animation_tree["parameters/conditions/shoot"] = value

func set_mele(value = false):
	range_.damage = mele_damage
	punch = value
	animation_tree["parameters/conditions/mele"] = value

func update_blend_position():
	animation_tree["parameters/MELE/blend_position"] = direction
	animation_tree["parameters/DEAD/blend_position"] = direction
	animation_tree["parameters/WALK/blend_position"] = direction
	animation_tree["parameters/SHOOT/blend_position"] = direction

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
	#@onready var hurt = $HURT
	hurt.play("HURT")
	#print("bbbbb")
	pass

func dead():
	set_dead(true)
	await get_tree().create_timer(1).timeout
	youve_died.visible = true

func _on_collect_area_entered(area):
	print("entra")
	if area == experiencia:
		print("entro")
		area.collect()
		var experiencia_entrante = area.experience
		calculate_exp(experiencia_entrante)

func calculate_exp(experience_entering : int):
	Global.experience_player = Global.experience_player + experience_entering
	
func player_upgrade(tipo : String) -> void:
	upgrades.upgrade(tipo)
	pass

func player_upgrade_match():
	pass

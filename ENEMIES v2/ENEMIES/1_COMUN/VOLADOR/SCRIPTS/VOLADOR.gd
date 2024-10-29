extends Enemy

@export var radius: float = 120
@export var speed: float = 1.5
@export var angle: float = 0.0
@export var bullets : PackedScene
@export var timer : Timer
@export var attack_detection : Area2D
@export var detector : RayCast2D 

@export var healing : PackedScene
@export var exp_gem : PackedScene
@export var experience : int = 1

var target
var direction

@onready var animation_player = $SPRITE/AnimationPlayer
@onready var hurt_box = $Hurt_Box
@onready var nav = $Dog_1_nav
@onready var hurt = $HURT

var is_attack : bool = false
var is_chase : bool = false
var is_idle : bool = true



@onready var player_ = get_tree().get_nodes_in_group("Player")[0]
var starting_position : Vector2


func _ready():
	starting_position = position
	attack_detection.body_entered.connect(player_detected)
	attack_detection.body_exited.connect(player_exited)
	hurt_box.DamageTaken.connect(take_damage)
	hurt_box.Dead.connect(death)

func _process(delta):
	direction = (player_.position - global_position).normalized()
	detector.target_position = direction * 200
	if is_idle:
		animation_player.play("IDLE")
	if is_attack:
		animation_player.play("ATTACK_UP")
		var target_direction = position.direction_to(player_.position)
		var movement = target_direction.rotated(PI/2)
		velocity = movement * 2000  * delta
		move_and_slide()

	if is_chase:
		animation_player.play("CHASE")
		target = player_
		nav.target_position = target.global_position
	
		var current_agent_position = global_position
		var next_path_position = nav.get_next_path_position()
		velocity = current_agent_position.direction_to(next_path_position) * speed
		move_and_slide()


	if detector.is_colliding() and is_attack == false:
		is_idle = false
		is_chase = true
		print(is_idle,is_chase)
	elif !detector.is_colliding() and is_attack == false:
		is_idle = true
		is_chase = false
		print(is_idle,is_chase)

	
func player_detected(body):
	if body.name == "Jugador":
		target = player_
		is_chase = false
		is_attack = true

func player_exited(body):
	if body.name == "Jugador":
		is_attack = false
		is_idle = true

func shoot():
	var bullet = bullets.instantiate()
	bullet.position = global_position
	bullet.direction = (detector.target_position).normalized()
	get_tree().current_scene.add_child(bullet)
	var _direction = (player_.position - global_position).normalized()


func take_damage():
	hurt.play("HURT")
	pass

func death():

	velocity = Vector2.ZERO
	animation_player.play("DEATH")
	await get_tree().create_timer(1).timeout

	if player_.vampirismo == true:
		if randf() < 0.2:
			var heal = healing.instantiate()
			heal.type = 3
			get_parent().get_parent().add_child(heal)
	var new_gem = exp_gem.instantiate()
	new_gem.global_position = direction
	new_gem.experience = experience
	get_parent().get_parent().add_child(new_gem)
	emit_signal("enemy_is_dead")
	queue_free()

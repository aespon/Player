extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D
@onready var hit_flash_animation = $HitFlashAnimation

var exp = 15

@onready var ray_cast = $RayCast2D
@onready var timer = $Timer
@export var ammo : PackedScene
var direction = Vector2.RIGHT

var speed = 10
var flee_distance = 200

var player
var player_in_attack_zone = false

var life = 225
 
func _ready():
	player =get_tree().get_nodes_in_group("Player")[0]

func _physics_process(delta):
	_aim()
	_check_player_collision()
	if player and player_in_attack_zone:
		direction = position - player.position
		if direction.length() < flee_distance:
			direction = direction.normalized()
			position += direction * speed * delta
	if life <= 0:
		animation_player.play("muerto")
		await get_tree().create_timer(1).timeout
		Global.experience_player = Global.experience_player + exp
		queue_free()

func _aim():
	direction = (player.position - global_position).normalized()
	ray_cast.target_position = direction * 250 

func _check_player_collision():
	if ray_cast.get_collider() == player and timer.is_stopped():
		timer.start()
	elif ray_cast.get_collider() != player and not timer.is_stopped():
		timer.stop()


func _on_timer_timeout():
	_shoot()

func _shoot():
	var bullet = ammo.instantiate()
	bullet.position = global_position
	bullet.direction = (ray_cast.target_position).normalized()
	get_tree().current_scene.add_child(bullet)
	var player_position = player.position
	direction = (player.position - global_position).normalized()
	
	var angulo = global_position.direction_to(player_position).angle()
	var actangulo = int(angulo)
	
	if actangulo == 1:
		animation_player.play("shoot_down")
	elif actangulo == 0:
		sprite_2d.flip_h = false
		animation_player.play("shoot_side")
	elif actangulo == -1 or actangulo == -2:
		animation_player.play("shoot_up")
	elif actangulo == 3 or actangulo == -3 or actangulo ==2:
		sprite_2d.flip_h = true
		animation_player.play("shoot_side")
	

func _on_detection_area_body_entered(body):
	if body.has_method("player"):
		player_in_attack_zone = true
		

func _on_detection_area_body_exited(body):
	if body.has_method("player"):
		player = null
		player_in_attack_zone = false
		animation_player.play("idle")



func _on_death_area_entered(area):
	if life > 0:
		if area.name == "Collission":
			life = life - Global.damage_shoot
		elif area.name == "Range":
			life = life - Global.damage_mele
	print(life)

extends Area2D
class_name experiencia

@export var experience = 1
 

var target = null
var speed = -1

@onready var player_ = get_tree().get_nodes_in_group("Player")[0]
@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var sound = $snd_collected
@onready var point_light_2d = $Sprite2D/PointLight2D

func _ready():
	if experience < 5:
		return
	elif experience < 25:
		sprite.modulate = Color("#9878ff")
		point_light_2d.color = Color("#9878ff")
	else:
		sprite.modulate = Color ("#ff0000")
		point_light_2d.color = Color("#ff0000")

func _physics_process(delta):
	if target != null:
		global_position = global_position.move_toward(target.global_position, speed)
		speed += 5*delta

func collect():
	sound.play()
	collision.call_deferred("set","disabled",true)
	sprite.visible = false
	return experience


func _on_snd_collected_finished():
	queue_free()


func _on_area_entered(area):
	
	if area.name == "Loot_Collect":
		#print("xp should follow")
		target = player_


func _on_body_entered(body):
	if body is Player:
		#print("entro")
		body.calculate_exp(experience)
		collect()

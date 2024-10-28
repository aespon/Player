extends CharacterBody2D

@export var speed = 1200
@onready var collission = $Attack_Box
var damage_shoot : int
@onready var attack_box = $Attack_Box

func _ready():
	attack_box.damage = Global.damage_shoot

func _physics_process(delta):
	position += transform.x * speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

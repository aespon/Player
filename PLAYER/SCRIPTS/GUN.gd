extends Node2D

@export var bullet_scene : PackedScene
@onready var animation_tree = $"../AnimationTree"
@onready var jugador = $".."


@onready var BarraEnergia = get_tree().get_nodes_in_group("BarraEnergia")[0]
@export var timer : Timer 
var energyPerShot = 10
var vaciado=false

@onready var upgrades = $"../Upgrades"


func get_input():
	look_at(get_global_mouse_position())

	

func shoot():
	var newbullet = bullet_scene.instantiate()
	get_tree().root.add_child(newbullet)
	newbullet.damage_shoot = jugador.shoot_damage
	newbullet.global_transform= $SpawnBullet.global_transform
	BarraEnergia.decreaseEnergy(20)
	daño_ctrl()
	#print(newbullet.name)
	Global.bulletname = newbullet.name
	



func _ready():
	BarraEnergia = get_tree().get_nodes_in_group("BarraEnergia")[0]
	BarraEnergia.resetEnergy()
	vaciado = false

func _process(_delta):
	daño_ctrl()
	if vaciado == true and Input.is_action_just_pressed("recharge"):
		await get_tree().create_timer(1).timeout
		BarraEnergia.decreaseEnergy(-200)
		vaciado = false
	look_at(get_global_mouse_position())

func daño_ctrl():
	if BarraEnergia.currentEnergy >= energyPerShot and(vaciado != true):
		#print (BarraEnergia.currentEnergy)
		look_at(get_global_mouse_position())
	elif BarraEnergia.currentEnergy <= energyPerShot:
		vaciado=true
		print ("no hay mas plata")


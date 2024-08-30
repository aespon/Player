extends Node2D 
class_name MAP_CREATION

@onready var borders = Rect2(1, 1, 30, 20)

@onready var player_scene = preload("res://PLAYER/SCENES/Player TopDown.tscn")
@onready var room_scene = [preload("res://LEVELS/LEVEL_1/SCENES/ROOMS/1_room_type_4.tscn"),
	preload("res://LEVELS/LEVEL_1/SCENES/ROOMS/1_room_type_3.tscn")]
@onready var boss_scene = preload("res://LEVELS/LEVEL_1/SCENES/ROOMS/1_room_type_1.tscn")
@onready var player_room_scene = preload("res://LEVELS/LEVEL_1/SCENES/ROOMS/1_room_type_2.tscn")

@export var volume_ = 0
@export var level_size = 0
@export var experience_player_ = 0
@export var cave_level = 0

@export var music_level = AudioStreamMP3

@export var max_rooms : int

var mapi := {}
var map

func _ready():
	Global.health = 1000
	Global.next_level = 0
	Global.experience_level = 1000
	Global.experience_player = 0
	Global.level = 1
	Engine.time_scale = 1
	randomize()
	generate_level()
	pass

func generate_level():

	var a = 35
	var walker = Walker.new(Vector2(10, 1), borders)
	var mapa = walker.walk(max_rooms)
	
	walker.queue_free()
	# estas lineas se deshacen de todos los duplicados dentro del array que devuelve el walker.
	
	for n in mapa:
		if not n in mapi:
			mapi[n] = null 
	map = mapi.keys()
	
	# este for pone las habitaciones (tiene 2 que si o si estan y las otras estan randomizadas)
	for location in map:
		if (a== 35):
			var player = player_scene.instantiate()
			player.position = Vector2(location.x * 1280, location.y * 1240)
			player.z_index = 1
			add_child(player)
			var rooms1 = player_room_scene.instantiate()
			rooms1.position = Vector2(location.x * 1280 , location.y * 1088)
			add_child(rooms1)
			a = a - 1
			
		else:
			if (a == 20):
				var boss1 = boss_scene.instantiate()
				boss1.position = Vector2(location.x * 1280 , location.y * 1088)
				add_child(boss1)
				print("boss")
				a = a - 1
			else:
				var r = randi_range(0, 1)
				var rooms = room_scene[r].instantiate()
				rooms.position = Vector2(location.x * 1280 , location.y * 1088)
				add_child(rooms)
				a = a - 1

func reload_level():
	get_tree().reload_current_scene()

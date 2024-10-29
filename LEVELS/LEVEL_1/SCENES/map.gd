extends Node2D

@onready var map = $"../../../../../Map"
var a = 0
var ROOMs = [preload("res://UI/ASSETS/boss_room.tscn"), preload("res://UI/ASSETS/starting_room.tscn")]


func _ready():
	for location in map.map:
		var boss_room = randi_range(5, map.map.size())
		if a == 35:
			var room_1 = ROOMs[0].instantiate()
			room_1.modulate = Color("#00ff00")
			room_1.position = Vector2(location.x * 1280 , location.y * 1280)
			add_child(room_1)
			
		else:
			if a == boss_room:
				var room_2 = ROOMs[0].instantiate()
				room_2.modulate = Color("#e1278f")
				room_2.position = Vector2(location.x * 1280 , location.y * 1280)
				add_child(room_2)
			else:
				var room_3 = ROOMs[0].instantiate()
				room_3.modulate = Color("#11daff")
				room_3.position = Vector2(location.x * 1280 , location.y * 1280)
				add_child(room_3)
		a = a + 1

extends Node2D

@onready var map = $"../../../../../Map"
var a = 0
var ROOMs = [preload("res://UI/ASSETS/boss_room.tscn"), preload("res://UI/ASSETS/normal_rooms.tscn"), preload("res://UI/ASSETS/starting_room.tscn")]


func _ready():
	for location in map.map:
		if a == 35:
			var room_1 = ROOMs[0].instantiate()
			room_1.position = Vector2(location.x * 1280 , location.y * 1088)
			add_child(room_1)
			
		else:
			if a == 20:
				var room_2 = ROOMs[0].instantiate()
				room_2.position = Vector2(location.x * 1280 , location.y * 1088)
				add_child(room_2)
			else:
				var room_3 = ROOMs[0].instantiate()
				room_3.position = Vector2(location.x * 1280 , location.y * 1088)
				add_child(room_3)
		a = a + 1

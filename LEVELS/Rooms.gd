extends room

@export var s = 1
var spawners = 0
@onready var spawns = $SPAWNERS
var oldspeed
@onready var player_ = get_tree().get_nodes_in_group("Player")[0]
var player_has_entered = false
@onready var marker_2d = $Marker2D
const CRYSTALS = preload("res://GLOBAL/otros/crystals.tscn")
@onready var doors = $Doors

# Called when the node enters the scene tree for the first time.
func _ready():
	for a in spawns.get_child_count():
		spawners += 1
	oldspeed = player_.max_speed

func spawn_enemy():
	for a in spawns.get_children():
		a.spawn_()
		a.enemy_die.connect(_on_enemy_spawner_1_enemy_die)
		pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):	
	if spawners == 0:
		#print("aa") 
		door_play("close")
		if s == 0:
			instantiate_gem()
		#funciones.play("Finished")
		spawners = -1
		if player_.speed_boost:
			player_.max_speed = oldspeed
		#if randf() < 0.1:
			#var crystal_level_up = CRYSTALS.instantiate()
			#crystal_level_up.type = 2
			#crystal_level_up.position = marker_2d.global_position
			#add_child(crystal_level_up)

func _on_door_top_player_entered():
	print(spawners)
	
	if player_has_entered == false:
		print(player_has_entered)
		door_player_enter()
	
func _on_door_bottom_player_entered():
	print(player_has_entered)
	if player_has_entered == false:
		door_player_enter()
	 
func _on_door_right_player_entered():
	print(player_has_entered)
	if player_has_entered == false:
		door_player_enter()

func _on_door_left_player_entered():
	print(player_has_entered)
	if player_has_entered == false:
		door_player_enter()

func door_player_enter():
	print(self.name)
	if spawners > 0:
		#funciones.play("Enter")
		door_play("enter")
		spawn_enemy()
		player_has_entered = true
		if randf() < 0.2:
			Global.experience_player += 100
			print("all")
		if player_.speed_boost:
			if randf() < 0.5:
				var new_speed = int(player_.max_speed * 0.2)
				player_.max_speed = new_speed
				print("newspeed")
	print(player_has_entered)


func _on_enemy_spawner_1_enemy_die():
	spawners -= 1


func _on_mother_crystal_item_spawn():
	spawners -= 1

func instantiate_gem():
	var crystal_level_up = CRYSTALS.instantiate()
	crystal_level_up.type = 0
	crystal_level_up.position = $Marker2D.position
	add_child(crystal_level_up)

func door_play(anim : String):

	for a in doors.get_children():
		if anim == "enter":
			a.enter_close_door()
		if anim == "close":
			a.finished()
	pass

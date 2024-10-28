extends room

# agrege 2 for para los spawners

@onready var funciones = $funciones

var spawners = 0
var oldspeed 

@onready var spawns = $SPAWNERS
@onready var spawners_group: Node2D = $SPAWNERS

@onready var player_ = get_tree().get_nodes_in_group("Player")[0]

var player_has_entered = false

# Called when the node enters the scene tree for the first time.
func _ready():
	print(self)
	print(scene_file_path)
	for a in spawns.get_child_count():
		spawners += 1
	
	
	# conecta automaticamente todos las señales del spawner
	for child in spawners_group.get_children():
			if child is Enemy_Spawner:
				child.enemy_die.connect(_on_enemy_spawner_1_enemy_die)
				if player_.speed_boost:
					player_.max_speed = oldspeed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if spawners == 0:
		print("aa")
		funciones.play("Finished")

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
	if spawners > 0:
		funciones.play("Enter")
		
		# llama a spawn en todos los spawners
		for child in spawners_group.get_children():
			if child is Enemy_Spawner:
				child.spawn_()
		if player_.speed_boost:
			if randf() < 0.5:
				
				var new_speed = int(player_.max_speed * 0.2)
				player_.max_speed = new_speed
				print("newspeed")
		
		player_has_entered = true
	print(player_has_entered)

func _on_enemy_spawner_1_enemy_die():
	spawners -= 1

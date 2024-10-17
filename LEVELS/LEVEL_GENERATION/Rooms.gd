extends room
@onready var funciones = $funciones
var spawners = 0
@onready var spawns = $SPAWNERS


var player_has_entered = false

# Called when the node enters the scene tree for the first time.
func _ready():
	for a in spawns.get_child_count():
		spawners += 1
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
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
		player_has_entered = true
	print(player_has_entered)


func _on_enemy_spawner_1_enemy_die():
	spawners -= 1

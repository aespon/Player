extends Marker2D
class_name  Enemy_Spawner

@export_category("Comun")
@export_enum("Minero" , "Asalto" , "Guardia" , "Robot Bomba" , "Hongo Brillante") var comun : String
@export_category("Raro")
@export_enum("Monta Cristales" , "Skotadi Volador", "Cerebro de Cristal" , "Cristal Flotante") var raro : String
@export_category("Extra Raro")
@export_enum("Robot" , "Torreta laser") var extra_raro : String
@export_enum("dog1","dog2") var boss : String

const enemies = {
	"Minero" = preload("res://ENEMIES_1/1_COMUN/MINERO/SCENES/MINERO.tscn"),
	"Asalto" = preload("res://ENEMIES_1/1_COMUN/ASALTO/SCENES/asalto.tscn"),
	"Guardia" = preload("res://ENEMIES_1/1_COMUN/GUARDIA/SCENES/GUARDIA.tscn"),
	"Monta Cristales" = preload("res://ENEMIES_1/2_RARO/CRISTAL_RIDER/SCENES/MontaCristales.tscn"),
	"Volador" = preload("res://ENEMIES v2/ENEMIES/1_COMUN/VOLADOR/ESENE/VOLADOR.tscn"),
	"dog1" = preload("res://BOSS/SCENES/Skotadi_Dog_Guards/dog_1.tscn"),
	"dog2" = preload("res://BOSS/SCENES/Skotadi_Dog_Guards/dog_2.tscn")
	}
var enemy 
signal enemy_die
# Called when the node enters the scene tree for the first time.
func spawn_():
	if boss != "":
		comun = ""
		raro = ""
		enemy = enemies[boss]
		var enemy_to_spawn = enemy.instantiate()
		enemy_to_spawn.position = position
		add_child(enemy_to_spawn)
		print(enemy_to_spawn.position)
		enemy_to_spawn.enemy_is_dead.connect(dead_enemy)
	if raro != "":
		comun = ""
		enemy = enemies[raro]
		var enemy_to_spawn = enemy.instantiate()
		enemy_to_spawn.position = position
		add_child(enemy_to_spawn)
		print(enemy_to_spawn.position)
		enemy_to_spawn.enemy_is_dead.connect(dead_enemy)
	if comun != "":
		enemy = enemies[comun]
		var enemy_to_spawn = enemy.instantiate()
		enemy_to_spawn.position = position
		add_child(enemy_to_spawn)
		print(enemy_to_spawn.position)
		enemy_to_spawn.enemy_is_dead.connect(dead_enemy)


func dead_enemy():
	emit_signal("enemy_die")
	queue_free()


	

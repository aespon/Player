extends Marker2D
class_name  Enemy_Spawner

@export_category("Comun")
@export_enum("Minero" , "Asalto" , "Guardia" , "Robot Bomba" , "Hongo Brillante") var comun : String
@export_category("Raro")
@export_enum("Monta Cristales" , "Skotadi Volador" , "Skotadi Volador" , "Cerebro de Cristal" , "Cristal Flotante") var raro : String
@export_category("Extra Raro")
@export_enum("Robot" , "Torreta laser") var extra_raro : String

const enemies = {
	"Minero" = preload("res://ENEMIES/1_COMUN/MINERO/SCENES/MINERO.tscn"),
	"Asalto" = preload("res://ENEMIES/1_COMUN/ASALTO/SCENES/asalto.tscn"),
	"Guardia" = preload("res://ENEMIES/1_COMUN/GUARDIA/SCENES/guardia.tscn"),
	"Monta Cristales" = preload("res://ENEMIES/2_RARO/CRISTAL_RIDER/SCENES/MontaCristales.tscn")
}
var enemy 
signal enemy_die
# Called when the node enters the scene tree for the first time.
func spawn_():
	if comun != null:
		enemy = enemies[comun]
		var enemy_to_spawn = enemy.instantiate()
		enemy_to_spawn.position = position
		add_child(enemy_to_spawn)
		print(enemy_to_spawn.position)
		enemy_to_spawn.enemy_is_dead.connect(dead_enemy)

func dead_enemy():
	emit_signal("enemy_die")
	queue_free()


	

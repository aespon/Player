extends Area2D

var direction : Vector2= Vector2.RIGHT
var speed : float = 200

func _physics_process(delta):
	position += direction * speed * delta


func _on_screen_exited():
	queue_free()


func _on_area_entered(area):
	var Jugador = get_tree().get_nodes_in_group("Player")[0]
	if area.owner == Jugador:
		Global.life = Global.life - 20

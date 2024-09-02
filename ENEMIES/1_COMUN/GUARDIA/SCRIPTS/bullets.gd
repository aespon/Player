extends Area2D

var direction : Vector2= Vector2.RIGHT
var speed : float = 900

var damage = 0

func _physics_process(delta):
	position += direction * speed * delta


func _on_screen_exited():
	queue_free()


func _on_area_entered(area):
	var Jugador = get_tree().get_nodes_in_group("Player")[0]
	if area.owner == Jugador:
		Global.health = Global.health - 20


func _on_body_entered(body):
	if body.name == "Jugador":
		Global.health = Global.health - damage
		pass # Replace with function body.

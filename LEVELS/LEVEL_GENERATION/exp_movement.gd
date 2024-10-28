extends Area2D                                   

@onready var sprite_2d = $Sprite2D
@onready var sprite_2d_2 = $Sprite2D2

@onready var Jugador = get_tree().get_nodes_in_group("Player")[0]
@onready var direction = Jugador.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sprite_2d.position += direction * 500 * delta
	sprite_2d_2.position += direction * 450 * delta

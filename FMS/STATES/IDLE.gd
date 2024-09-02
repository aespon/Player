extends State

#####################
# que hace en idleboss1?
# al entrar necesita un timer  que lo haga buscar al player cada cierto tiempo,
# para salir necesita haber encontrado al player en su x ó y 
# si no lo encuentra durante ese timer entonces emite la señal wander para ir a una nueva posicion
#####################

@export var timer_idle : Timer
@export var timer_wait_time = 0.0
@export var player_detector_1 : RayCast2D 
@export var player_detector_2 : RayCast2D

@export var next_state_1  = ""
@export var next_state_2 = ""



func enter():
	timer_idle.timeout.connect(on_timeout) 
	enemy.velocity = Vector2.ZERO
	timer_idle.wait_time = timer_wait_time
	timer_idle.start()

	
func on_timeout():
	transitioned.emit(self, next_state_1)
	
func process_state(_delta):
	if player_detector_1.is_colliding() or player_detector_2.is_colliding():
		transitioned.emit(self, next_state_2)

func exit():
	timer_idle.stop()
	timer_idle.timeout.disconnect(on_timeout)


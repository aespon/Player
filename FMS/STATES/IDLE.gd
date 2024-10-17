extends State

#####################
# que hace en idleboss1?
# al entrar necesita un timer  que lo haga buscar al player cada cierto tiempo,
# para salir necesita haber encontrado al player en su x ó y 
# si no lo encuentra durante ese timer entonces emite la señal wander para ir a una nueva posicion
#####################

@export var timer_idle : Timer
@export var timer_wait_time = 0.0
@export_enum("1 RAYCAST" ,"2 RAYCAST") var ray_cast : String
@export_group("States")
@export var next_state_1  = ""
@export var next_state_2 = ""
@export_group("Raycasts of the enemy")
@export var player_detector_1 : RayCast2D 
@export var player_detector_2 : RayCast2D





func enter():
	timer_idle.timeout.connect(on_timeout) 
	enemy.velocity = Vector2.ZERO
	timer_idle.wait_time = timer_wait_time
	timer_idle.start()

	
func on_timeout():
	transitioned.emit(self, next_state_1)
	
func process_state(_delta):
	if ray_cast == "1 RAYCAST":
		one_raycast()
	elif ray_cast == "2 RAYCAST":
		two_raycast()

func one_raycast():
	if player_detector_1.is_colliding():
		transitioned.emit(self, next_state_2)

func two_raycast():
	if player_detector_1.is_colliding():
		transitioned.emit(self, next_state_2)
		last_raycast = 1
	elif player_detector_2.is_colliding():
		transitioned.emit(self, next_state_2)
		last_raycast = 2
	pass

func exit():
	timer_idle.stop()
	timer_idle.timeout.disconnect(on_timeout)
	print(last_raycast)


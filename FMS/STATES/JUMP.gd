extends State

@export var attack_area = Area2D
@export var enemy_collission = CollisionShape2D
@export var speed = 0.0
@export var sprite = Sprite2D
@export var Navigator : NavigationAgent2D

var target 

@export var new_state = ""

func enter():
	attack_area.body_entered.connect(attack_dtector_entered)
	print("enter")
	enemy_collission.visibility_layer = 4 #esto deberia hacer que el enemigoo este en una layer distinta al mundo player etc- no colisionaria-

func attack_dtector_entered(_body):
	transitioned.emit(self, new_state)

func process_state(_delta):
	target = player
	Navigator.target_position = target.position
	
	#lo necesario para que se mueva
	var current_agent_position = global_position
	var next_path_position = Navigator.get_next_path_position()
	var new_velocity = current_agent_position.direction_to(next_path_position) * speed
	owner.velocity = new_velocity
	
 #esti es opcionalse puede hacer mejor en el landing en el animationplayer

func exit():
	enemy_collission.visibility_layer = 2
	
	


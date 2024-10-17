extends Enemy

@onready var points = $Points
@onready var x = points.position
@onready var player_ = get_tree().get_nodes_in_group("Player")[0]
@export var life := 0.0
@onready var animation_player = $Sprite/AnimationPlayer
@onready var sprite_2d = $Sprite/Dog_2_Sprite
@onready var progress_bar = $ProgressBar
@export var FMS_Dog1 : Finate_State_Machine
var angle_to_player
@onready var animation = FMS_Dog1.current_state.name 
@export var hurt_box : Hurt_Box
@onready var detector_y = $DetectorY

var direction

func _ready():

	hurt_box.Dead.connect(dead)
	hurt_box.DamageTaken.connect(damage_taken)

func _physics_process(delta):
	
	if FMS_Dog1 != null:
		animation_player.play(animation)
	var player_position = player_.position
	direction = (player_.position - global_position).normalized()
	detector_y.target_position = direction * 200
	angle_to_player = global_position.direction_to(player_position).angle()
	sprite_2d.rotation = move_toward(rotation, angle_to_player, delta*200)
	points.position = x
	move_and_slide()



func damage_taken():
	animation_player.play("IDLE")
	progress_bar.value = hurt_box.current_health



func dead():
	animation_player.play("DEATH")
	if FMS_Dog1 != null : FMS_Dog1.queue_free()
	await get_tree().create_timer(1).timeout
	Global.experience_player = Global.experience_player + 100
	print(Global.experience_player)
	emit_signal("enemy_is_dead")
	queue_free()

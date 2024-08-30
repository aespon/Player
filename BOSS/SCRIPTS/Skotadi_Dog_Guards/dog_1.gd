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
@onready var detector_y = $DetectorY
@onready var detectorx = $Detectorx

var direction

func _physics_process(delta):
	var player_position = player_.position
	
	if life > 0:
		animation = FMS_Dog1.current_state.name 
		animation_player.play(animation)
		angle_to_player = global_position.direction_to(player_position).angle()
		sprite_2d.rotation = move_toward(rotation, angle_to_player, delta*200)
		points.position = x
		direction = (player_.position - global_position).normalized()
		detectorx.target_position = direction * 250 
		detector_y.target_position = direction * 250
	elif life <= 0:
		animation_player.play("DEATH")
		await get_tree().create_timer(1).timeout
		Global.experience_player = Global.experience_player + 100
		queue_free()
		velocity = Vector2(0,0)
	move_and_slide()


func _on_hit_detector_area_entered(area):
	if area.name == "Collission":
		life = life - Global.damage_shoot
	elif area.name == "Range":
		life = life - Global.damage_mele
	print(life)
	progress_bar.value = life


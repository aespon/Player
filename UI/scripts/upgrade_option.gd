extends ColorRect

@onready var rect_external = $NinePatchRect
@onready var lbl_name = $lblName
@onready var rect_icon = $NinePatchRect2
@onready var lbl_description = $lblDescription
@onready var lbl_nivel = $lblNivel
@onready var upgrade_1 = $"."

var mouse_on = false
var item = null
#@onready var player = get_tree().get_nodes_in_group("Player")[0]

signal selected_item(upgrade)
# Called when the node enters the scene tree for the first time.
func set_item():
	lbl_name.text = UpgradesDb.UPGRADE_DB[item]["displayname"]
	lbl_description.text = UpgradesDb.UPGRADE_DB[item]["details"]
	lbl_nivel.text = UpgradesDb.UPGRADE_DB[item]["level"]


func _on_mouse_entered():
	mouse_on = true
	upgrade_1.color = Color("#3d3d3d")
	rect_external.modulate =  Color("#d9bdc8")
	rect_icon.modulate = Color("#d9bdc8")


func _on_mouse_exited():
	mouse_on = false
	upgrade_1.color = Color("#272727")
	rect_external.modulate = Color("#6f4b73")
	rect_icon.modulate = Color("#6f4b73")

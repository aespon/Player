extends CanvasLayer
class_name Upgrades_UI

var upgrades_on_ui = []
var collected_upgrades = []

@onready var upgrade_1 = $UPGRADE/upgrade1
@onready var upgrade_2 = $UPGRADE/upgrade2
@onready var upgrade_3 = $UPGRADE/upgrade3

signal upgrade_for_player(upgrade)

var incoming_type :String
var on_screen : bool = false

func upgrade(upgrade_type : String):
	var options = 1
	while options < 4 :
		match options:
			1 :
				upgrade_1.item = randomize_upgrades(upgrade_type)
				upgrade_1.set_item()
				#print(upgrade_1.item)
			2 :
				upgrade_2.item = randomize_upgrades(upgrade_type)
				upgrade_2.set_item()
			3 :
				upgrade_3.item = randomize_upgrades(upgrade_type)
				upgrade_3.set_item()
		options += 1 
# Called when the node enters the scene tree for the first time.
func randomize_upgrades(type : String):
	var dblist = []
	for i in UpgradesDb.UPGRADE_DB:
		if UpgradesDb.UPGRADE_DB[i]["type"] == type:
			print(UpgradesDb.UPGRADE_DB[i]["prerequisite"].size())
			if i in collected_upgrades :
				print(i)
				pass
			elif i in upgrades_on_ui:
				pass
				
			elif UpgradesDb.UPGRADE_DB[i]["prerequisite"].size() != 0: #Check for PreRequisites
				var to_add = true
				for n in UpgradesDb.UPGRADE_DB[i]["prerequisite"]:
					if not n in collected_upgrades:
						to_add = false
				if to_add:
					dblist.append(i)
			else:
				dblist.append(i)
				#print(dblist)
			
	if dblist.size() > 0:
		var randomitem = dblist.pick_random()
		#print(UpgradesDb.UPGRADE_DB[randomitem]["type"])
		upgrades_on_ui.append(randomitem)
		print("random item " + randomitem)
		return randomitem
	pass


func _on_skip_pressed():
	get_tree().reload_current_scene()


func _on_upgrade_1_selected_item(upgrade):
	emit_signal("upgrade_for_player", upgrade)
	get_tree().paused = false
	pass # Replace with function body.


func _on_visibility_changed():
	if on_screen == true:
		get_tree().paused = true
	if on_screen == false:
		get_tree().paused = false

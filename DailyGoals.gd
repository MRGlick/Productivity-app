extends Control




var button_start_position = Vector2(138, 281)
var button_spacing = 230

func _ready():
	if Global.daily_goals != {}:
		update_button_positions()
		$NoTasksYet.hide()
	

func _on_back_button_pressed():
	Global.change_scene("res://main.tscn")


func update_button_positions():
	
	for c in $ButtonHolder.get_children():
		$ButtonHolder.remove_child(c)
	
	var idx = 0
	print(Global.daily_goals)
	for key in Global.daily_goals:
		var button = preload("res://task_button.tscn").instantiate()
		button.position = button_start_position + Vector2(0, button_spacing * idx)
		button.text = key
		button.button_pressed = Global.daily_goals[key]
		button.wait_to_enter_tree = Global.daily_goals[key] # if the button is deactivated, it's not supposed to be waiting for anything
		button.connect("toggled", Callable(self, "update_daily_goals").bind(key))
		$ButtonHolder.call_deferred("add_child", button)
		idx += 1

func update_daily_goals(val, key):
	Global.daily_goals[key] = val
	Global._save()

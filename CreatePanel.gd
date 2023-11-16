extends Control

signal finished_adding_buttons

@onready var button_start_position = $AddButton.position;
var button_spacing = 208
var current_text = "Hey ;)"
var in_name_task_panel = false
var button_amount_max = 6


# Called when the node enters the scene tree for the first time.
func _ready():
	update_button_positions()





func _on_back_button_pressed():
	if in_name_task_panel: return
	Global.change_scene("res://main.tscn")



func update_button_positions():
	
	for i in $ButtonHolder.get_children(): $ButtonHolder.remove_child(i)
	var idx = 0;
	for key in Global.daily_goals:
		var button = preload("res://create_panel_button.tscn").instantiate()
		button.position = button_start_position + Vector2(0, button_spacing * idx)
		button.text = key
		button.connect("deleted", Callable(self, "delete_goal"))
		$ButtonHolder.call_deferred("add_child", button)
		idx += 1
	$AddButton.position = button_start_position + Vector2(0, button_spacing * idx)
	if Global.daily_goals.size() >= button_amount_max: $AddButton.hide()
	else: $AddButton.show()


func delete_goal():
	Global._save()
	update_button_positions()


func _on_add_button_pressed():
	if in_name_task_panel or Global.daily_goals.size() >= button_amount_max: return
	in_name_task_panel = true
	$NameTaskPanel.show()

func add_task(t_name):
	if (Global.daily_goals.has(t_name)): return
	Global.daily_goals[t_name] = false
	print(Global.daily_goals)
	update_button_positions()
	Global._save()


func _on_create_pressed():
	in_name_task_panel = false
	$NameTaskPanel.hide()
	add_task($NameTaskPanel/TextEdit.text)

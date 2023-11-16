extends Control

#
# Main screen -> Daily goals button -> daily goals panel -> back button -> Main screen
# Main screen -> Set daily goals button -> create panel -> back button -> Main screen
#                                       

var progress_bar_real_val = 0.0

func _ready():
	Global.update_goals_completion()

func _process(delta):
	$ProgressBar.add_theme_stylebox_override("Fill", StyleBoxFlat.new())
	progress_bar_real_val = lerp(progress_bar_real_val, Global.goals_completion, delta * 3)
	$ProgressBar.value = round(progress_bar_real_val * 100)
	var desired_color = Color.RED
	if progress_bar_real_val < 0.5:
		desired_color = lerp(Color.RED, Color(0.9, 0.9, 0.3), progress_bar_real_val * 2)
	else:
		desired_color = lerp(Color(0.6, 0.7, 0.3), Color("44e66a"), (progress_bar_real_val - 0.5) * 2)
	$ProgressBar.modulate = lerp($ProgressBar.modulate, desired_color, 0.1)

func change_progress_bar_color(new_color):
	var style_dupe = $ProgressBar.get_theme_stylebox("Fill").duplicate()
	style_dupe.bg_color = new_color
	$ProgressBar.add_theme_stylebox_override("Fill", style_dupe)

func _on_set_daily_goals_pressed():
	Global.change_scene("res://CreatePanel.tscn")


func _on_daily_goals_pressed():
	Global.change_scene("res://DailyGoals.tscn")

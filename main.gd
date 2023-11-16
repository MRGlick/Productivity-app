extends Control

#
# Main screen -> Daily goals button -> daily goals panel -> back button -> Main screen
# Main screen -> Set daily goals button -> create panel -> back button -> Main screen
#                                       

var progress_bar_real_val = 0.0

func _ready():
	Global.update_goals_completion()

func _process(_delta):
	progress_bar_real_val = lerp(progress_bar_real_val, Global.goals_completion, 0.1)
	$ProgressBar.value = round(progress_bar_real_val * 100)




func _on_set_daily_goals_pressed():
	Global.change_scene("res://CreatePanel.tscn")


func _on_daily_goals_pressed():
	Global.change_scene("res://DailyGoals.tscn")

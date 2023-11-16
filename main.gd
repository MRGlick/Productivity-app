extends Control

#
# Main screen -> Daily goals button -> daily goals panel -> back button -> Main screen
# Main screen -> Set daily goals button -> create panel -> back button -> Main screen
#                                       







func _on_set_daily_goals_pressed():
	Global.change_scene("res://CreatePanel.tscn")


func _on_daily_goals_pressed():
	Global.change_scene("res://DailyGoals.tscn")

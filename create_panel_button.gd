extends Button

signal deleted



func _on_pressed():
	Global.daily_goals.erase(text)
	emit_signal("deleted")

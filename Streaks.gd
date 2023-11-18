extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	update_days()


func update_days():
	
	
	var current_month = Global.get_datetime().month
	
	$Month.text = get_month_name(current_month)
	
	for day in Global.days:
		if day.date.month == current_month:
			$GridContainer.call_deferred("add_child", create_date_button(day))
			


func create_date_button(day : Day):
	var button = Button.new()
	button.text = str(day.date.day)
	button.add_theme_font_size_override("font_size", 32)
	button.custom_minimum_size = Vector2(100, 100)
	var style = StyleBoxFlat.new()
	
	
	if day.completion < 0.5:
		style.bg_color = lerp(Color.RED, Color(0.9, 0.9, 0.3), day.completion * 2)
	else:
		style.bg_color = lerp(Color(0.6, 0.7, 0.3), Color("44e66a"), (day.completion - 0.5) * 2)
	style.corner_radius_bottom_left = 15
	style.corner_radius_bottom_right = 15
	style.corner_radius_top_left = 15
	style.corner_radius_top_right = 15
	button.add_theme_stylebox_override("normal", style)
	return button;
	


func get_month_name(month_number):
	match month_number:
		1:
			return "January"
		2:
			return "February"
		3:
			return "March"
		4:
			return "April"
		5:
			return "May"
		6:
			return "June"
		7:
			return "July"
		8:
			return "August"
		9:
			return "September"
		10:
			return "October"
		11:
			return "November"
		12:
			return "December"

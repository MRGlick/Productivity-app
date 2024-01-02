extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	update_days()


func update_days():
	
	
	var current_month = Global.get_datetime().month
	
	$Month.text = get_month_name(current_month)
	
	for i in get_month_length(current_month):
		var found = false
		for day in Global.days:
			if day.day == i + 1 and day.month == current_month:
				found = true
				$GridContainer.call_deferred("add_child", create_date_button(day))
				break;
		if found: continue;
		var new_date = Global.get_datetime()
		new_date.day = i + 1
		var day = new_date;
		day["completion"] = -1
		$GridContainer.call_deferred("add_child", create_date_button(day))


func create_date_button(day : Dictionary):
	var button = Button.new()
	button.text = str(day.day)
	button.add_theme_font_size_override("font_size", 32)
	button.custom_minimum_size = Vector2(100, 100)
	var style = StyleBoxFlat.new()
	
	if day.completion == -1: style.bg_color = Color("323232")
	else:
		if day.completion < 0.5:
			style.bg_color = lerp(Color.RED, Color(0.9, 0.9, 0.3), day.completion * 2)
		else:
			style.bg_color = lerp(Color(0.6, 0.7, 0.3), Color("44e66a"), (day.completion - 0.5) * 2)
	
	
	style.corner_radius_bottom_left = 15
	style.corner_radius_bottom_right = 15
	style.corner_radius_top_left = 15
	style.corner_radius_top_right = 15
	button.add_theme_stylebox_override("normal", style)
	button.add_theme_stylebox_override("pressed", style)
	button.add_theme_stylebox_override("hovered", style)
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

func get_month_length(month_number):
	match month_number:
		1:
			return 31
		2:
			return 28
		3:
			return 31
		4:
			return 30
		5:
			return 31
		6:
			return 30
		7:
			return 31
		8:
			return 31
		9:
			return 30
		10:
			return 31
		11:
			return 30
		12:
			return 31

func _on_back_button_pressed():
	Global.change_scene("res://main.tscn")

extends Node


var daily_goals: Dictionary = {} # ex: 'make an app' : false, 'do something' : true | value is whether the task has been done or not

var save_path: String = "user://data.dat"

var date_last_opened: Dictionary = {}

var save_data: Dictionary = {}

var goals_completion: float = 0

var days := []

var scene_changing = false

func _ready():
	_save()
	_load()
	if date_last_opened and date_last_opened.day != get_datetime().day:
		update_goals_completion()
		days.append(Day.new(date_last_opened, goals_completion))
		reset_goals()
	date_last_opened = get_datetime()
	update_goals_completion()

func update_goals_completion():
	var goals_completed_count = 0
	for key in daily_goals:
		if daily_goals[key] == true:
			goals_completed_count += 1
	goals_completion = goals_completed_count / float(daily_goals.size())

func reset_goals():
	for key in daily_goals:
		daily_goals[key] = false

func change_scene(path):
	if scene_changing: return
	scene_changing = true
	Transition.close()
	await Transition.finished_closing
	get_tree().change_scene_to_file(path)
	Transition.open()
	scene_changing = false

func get_datetime():
	return Time.get_datetime_dict_from_system()

func _save():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	save_data.daily_goals = daily_goals
	save_data.date_last_opened = date_last_opened
	save_data.days = days
	file.store_var(save_data)
	file.close()

func _load():
	var file = FileAccess.open(save_path, FileAccess.READ)
	if FileAccess.file_exists(save_path):
		save_data = file.get_var()
		date_last_opened = save_data.date_last_opened
		daily_goals = save_data.daily_goals
		#[Day.new(get_datetime(), 0.5), Day.new(get_datetime(), 0.2), Day.new(get_datetime(), 0.5), Day.new(get_datetime(), 0.2), Day.new(get_datetime(), 0.5), Day.new(get_datetime(), 0.2), Day.new(get_datetime(), 0.5), Day.new(get_datetime(), 0.2)]
		days = save_data.days
		file.close()

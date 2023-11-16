extends Button



var wait_to_enter_tree = true




func _on_toggled(_button_pressed):
	if (_button_pressed):
		play_click_animation();

func play_click_animation():
	if wait_to_enter_tree:
		wait_to_enter_tree = false
		await tree_entered
	$ClickParticles.emitting = true
	var start_v = 20
	var size_constant = .001
	for i in start_v * 2:
		scale += Vector2.ONE * size_constant * start_v
		start_v -= 1
		
		if get_tree(): await get_tree().create_timer(.01).timeout
		
	scale = Vector2.ONE

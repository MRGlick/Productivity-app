extends Control

signal finished_closing
signal finished_opening

var closing = false
var opening = false

func close():
	$ColorRect.position.x = -1150
	closing = true
	opening = false
	for i in 30:
		if !closing: return
		$ColorRect.position.x = lerp($ColorRect.position.x, 0.0, 0.1)
		await get_tree().create_timer(.01).timeout
	closing = false
	$ColorRect.position.x = 0.0
	emit_signal("finished_closing")


func open():
	opening = true
	closing = false
	for i in 30:
		if !opening: return
		$ColorRect.position.x = lerp($ColorRect.position.x, 1150.0, 0.1)
		await get_tree().create_timer(.01).timeout
	opening = false
	$ColorRect.position.x = -1150.0
	emit_signal("finished_opening")

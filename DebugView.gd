extends Control

var activated = false

func _ready():
	deactivate()

func activate():
	activated = true;
	show()

func _process(delta):
	if activated:
		$Days.text = "Stored days: " + str(Global.days)
	

func deactivate():
	activated = false;
	hide()


func toggle():
	if activated:
		deactivate()
	else:
		activate()

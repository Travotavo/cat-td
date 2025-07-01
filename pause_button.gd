extends Button

var toggle = true
var time_scale = 1


func _on_button_down():
	if toggle:
		Engine.time_scale = time_scale
	else:
		Engine.time_scale = time_scale
	toggle = not toggle

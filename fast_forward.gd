extends TextureButton

var toggle = false
var time_scale = 1

func _on_button_down():
	if toggle:
		time_scale = 1
		Engine.time_scale = time_scale
	else:
		time_scale = 3
		Engine.time_scale = time_scale
	toggle = not toggle

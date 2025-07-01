extends TextureButton

var toggle = false

func _on_button_down():
	if toggle:
		$"../Pause Button".time_scale = 1
		Engine.time_scale = Engine.time_scale / 2
	else:
		$"../Pause Button".time_scale = 2
		Engine.time_scale = Engine.time_scale * 2
	toggle = not toggle

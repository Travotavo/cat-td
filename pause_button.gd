extends TextureButton

var toggle = false
var time_scale = 1


func _on_button_down():
	if toggle:
		Engine.time_scale = time_scale
		get_parent().mouse_filter = Control.MOUSE_FILTER_IGNORE
	else:
		Engine.time_scale = 0
		get_parent().mouse_filter = Control.MOUSE_FILTER_STOP
	toggle = not toggle

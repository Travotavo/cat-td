extends TextureButton

var toggle = false

func _on_button_down():
	if toggle:
		get_tree().paused = false
	else:
		get_tree().paused = true
	toggle = !toggle

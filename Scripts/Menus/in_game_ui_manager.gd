extends MarginContainer

@export var menu_screen: VBoxContainer

func toggle_visibility(object):
	if(object.visible):
		object.visible = false
	else:
		object.visible = true

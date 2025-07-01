extends Node2D
var iter = 0
func _process(delta):
	if Input.is_action_just_pressed("press"):
		match iter:
			0:
				$Slide1.visible = false
				$Slide2.visible = true
			1:
				$Slide2.visible = false
				$Slide3.visible = true
			2:
				SceneTransition.change_scene_to_file("res://main_menu.tscn")
		iter += 1

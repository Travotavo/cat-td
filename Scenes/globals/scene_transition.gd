extends CanvasLayer

func change_scene_to_file(file:String):
	$AnimationPlayer.play("wipe")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(file)
	$AnimationPlayer.play_backwards("wipe")

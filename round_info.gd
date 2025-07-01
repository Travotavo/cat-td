extends TextureRect

func _process(delta):
	$Label.text = str(LevelResources.Lives)
	$Label2.text = "Round: " + str(LevelResources.round)

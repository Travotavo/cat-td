extends Control

func _process(delta):
	$TextureProgressBar.value = LevelResources.Mana
	$TextureProgressBar/Label.text = str(LevelResources.Mana) + "/100"

extends Control

func _process(delta):
	$TextureProgressBar.value = LevelResources.Mana
	$TextureProgressBar.max_value = 25 + LevelResources.Wave * 50
	$TextureProgressBar/Label.text = str(LevelResources.Mana) + "/" + str(25 + LevelResources.Wave * 50)

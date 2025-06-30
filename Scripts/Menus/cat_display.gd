extends Control

@export var cat:CatStats

func _load():
	$TextureProgressBar.material.set("shader_parameter/colors",cat.color)
	$TextureProgressBar/Label.text = cat.nickname
	cat.connect('starve', scavenge)

func _process(delta):
	$TextureProgressBar.value = cat.Hunger
	if LevelResources.Timeout_cats.has(cat):
		modulate = Color.DIM_GRAY
	else:
		modulate = Color.WHITE

func scavenge():
	LevelResources.Used_Cats.erase(cat)
	LevelResources.Timeout_cats.append(cat)
	$Scavenge.start()

func refresh():
	cat.feed()
	LevelResources.Timeout_cats.erase(cat)
	LevelResources.Unused_Cats.append(cat)

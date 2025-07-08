extends Control

@export var cat:CatStats

func _load():
	$TextureProgressBar.material.set("shader_parameter/colors",cat.color)
	$TextureProgressBar/Label.text = cat.nickname
	cat.connect('starve', scavenge)

func _process(delta):
	$TextureProgressBar.value = cat.Hunger
	$TextureProgressBar/Feed_Button/Label.text = str(cat.feed_cost)
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


func _on_feed_button_button_down():
	if LevelResources.Mana >= cat.feed_cost:
		LevelResources.Mana -= cat.feed_cost
		cat.feed()
		if LevelResources.Timeout_cats.has(cat):
			LevelResources.Timeout_cats.erase(cat)
			LevelResources.Unused_Cats.append(cat)
			$Scavenge.stop()

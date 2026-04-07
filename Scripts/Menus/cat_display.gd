extends Control

@export var cat:CatStats

func _load():
	$TextureProgressBar.material.set("shader_parameter/colors",cat.color)
	$TextureProgressBar/Label.text = cat.nickname
	cat.connect('starve', scavenge)

func _process(delta):
	$TextureProgressBar.value = cat.Hunger
	$TextureProgressBar/Feed_Button/Label.text = str(cat.feed_cost)
	if LevelResources.Used_Cats.has(cat):
		modulate = Color.DIM_GRAY
	else:
		modulate = Color.WHITE

func scavenge():
	LevelResources.Used_Cats.erase(cat)

func refresh():
	if !LevelResources.Used_Cats.has(cat):
		cat.feed(1)


func _on_feed_button_button_down():
	if LevelResources.Mana >= cat.feed_cost:
		LevelResources.Mana -= cat.feed_cost
		cat.feed(25)

extends Control

@export var cat:CatStats

func _load():
	$TextureProgressBar.material.set("shader_parameter/colors",cat.color)
	$TextureProgressBar/Label.text = cat.nickname
	$ActualProgress.material.set("shader_parameter/colors",cat.color)
	cat.connect('starve', scavenge)

func _process(delta):
	$ActualProgress.value = cat.Hunger
	$TextureProgressBar/Feed_Button/Label.text = str(cat.feed_cost)

func scavenge():
	LevelResources.Used_Cats.erase(cat)

func refresh():
	if !LevelResources.Used_Cats.has(cat):
		cat.feed(1)


func _on_feed_button_button_down():
	if LevelResources.Mana >= cat.feed_cost:
		LevelResources.Mana -= cat.feed_cost
		cat.feed(50)

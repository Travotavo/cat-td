extends VBoxContainer

func _ready():
	LevelResources.load_rando_cats(get_child_count(),3)
	var iter = 0
	for i in get_children():
		i.cat = LevelResources.Cats[iter]
		iter += 1
		i._load()

var added_template = preload("res://Scenes/Menus/cat_display.tscn")

func _addCat():
	var new_cat = added_template.instantiate()
	new_cat.cat = LevelResources.Unlockable_Cats.pop_front()
	LevelResources.Unused_Cats.append(new_cat.cat)
	new_cat._load()
	add_child(new_cat)

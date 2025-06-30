extends VBoxContainer

func _ready():
	LevelResources.load_rando_cats(get_child_count())
	var iter = 0
	for i in get_children():
		i.cat = LevelResources.Cats[iter]
		iter += 1
		i._load()

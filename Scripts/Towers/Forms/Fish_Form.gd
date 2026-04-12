extends Cat_Form
class_name Fisher_Cat

func _ready():
	visual = preload("res://Assets/Towers/Fish Cat/fish_cat.png")
	visual_lib = preload("res://Assets/Towers/Animation Resources/fish_cat.res")

func on_enter():
	#Set Animations, Particles, and whatever else necessary
	node.set_cooldown(4)
	node.set_range(500)
	node.set_visuals(visual,4,3,visual_lib)
	node.stats.feed_cost = 5

func _attack(damage):
	var targets = Enemy.living_enemies.duplicate()
	targets.sort_custom(pick_sort(4))
	if (targets[0] as Enemy).is_queued_for_deletion():return
	face_target(targets[0])
	if (targets[0] as Enemy).take_damage(damage/2):
		for cat in LevelResources.Used_Cats:
			(cat as CatStats).feed(25)
		for cat in LevelResources.Unused_Cats:
			(cat as CatStats).feed(25)

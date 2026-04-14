extends Cat_Form
class_name Litter_Cat



func _ready():
	attacks_anyways = true
	visual = preload("res://Assets/Towers/Litter Cat/litter_cat.png")
	visual_lib = preload("res://Assets/Towers/Animation Resources/litter_cat.res")

func on_enter():
	#Set Animations, Particles, and whatever else necessary
	node.set_cooldown(5)
	node.set_range(80)
	node.set_visuals(visual,5,5,visual_lib,-16)
	node.stats.feed_cost = 5

var projectile = preload("res://Scenes/Towers/Projectiles/litter_pile.tscn")

func _attack(damage):
	var rand_vector = (Vector2.RIGHT * (10)).rotated(randf_range(0,PI*2))
	var litter_location = GameScene.instance.Path.curve.get_closest_point(GameScene.instance.Path.to_local(node.global_position + rand_vector))
	var litter_projectile = projectile.instantiate()
	litter_projectile.position = GameScene.instance.Path.to_global(litter_location)
	litter_projectile.damage = damage/3
	node.get_tree().get_first_node_in_group("Projectile_Parent").add_child(litter_projectile)

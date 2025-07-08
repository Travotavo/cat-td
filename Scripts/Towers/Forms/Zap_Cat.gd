extends Cat_Form
class_name Zap_Cat

var projectile = preload("res://Scenes/Towers/Projectiles/lightning_bolt.tscn")

func _ready():
	visual = preload("res://Assets/Towers/Zap Cat/Lightning_Cat_Sheet.png")
	visual_lib = preload("res://Assets/Towers/Animation Resources/zap_cat.res")

func on_enter():
	#Set Animations, Particles, and whatever else necessary
	node.set_cooldown(4)
	node.set_range(160)
	node.set_visuals(visual,5,2,visual_lib)
	node.stats.feed_cost = 5
	pass

func _attack(damage):
	var lightning_targets = node.Near_Brooms.duplicate()
	node.Near_Brooms.sort_custom(pick_sort(0))
	face_target(node.Near_Brooms[0])
	var strike = projectile.instantiate()
	strike.global_position = node.Near_Brooms[0].global_position
	node.get_tree().get_first_node_in_group("Projectile_Parent").add_child(strike)

func _close_broom_sort(a:Enemy,b:Enemy):
	return a.global_position.distance_to(node.Near_Brooms[0].global_position) < b.global_position.distance_to(node.Near_Brooms[0].global_position)

extends Cat_Form
class_name Sword_Cat

var projectile = preload("res://Scenes/Towers/Projectiles/sword_swipe.tscn")

func on_enter():
	#Set Animations, Particles, and whatever else necessary
	node.modulate = Color.RED
	node.set_range(75)
	pass

func _attack(damage):
	var lightning_targets = node.Near_Brooms.duplicate()
	node.Near_Brooms.sort_custom(pick_sort(1))
	var strike = projectile.instantiate()
	strike.global_rotation = (node.Near_Brooms[0].global_position - node.global_position).angle()
	strike.global_position = (node.Near_Brooms[0].global_position + node.global_position)/2
	strike.damage = damage * 2
	node.get_tree().get_first_node_in_group("Projectile_Parent").add_child(strike)

func _close_broom_sort(a:Enemy,b:Enemy):
	return a.global_position.distance_to(node.Near_Brooms[0].global_position) < b.global_position.distance_to(node.Near_Brooms[0].global_position)

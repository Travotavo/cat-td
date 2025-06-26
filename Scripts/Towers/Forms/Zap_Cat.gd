extends Cat_Form
class_name Zap_Cat

var projectile = preload("res://Scenes/Towers/Projectiles/lightning_bolt.tscn")

func on_enter():
	#Set Animations, Particles, and whatever else necessary
	node.modulate = Color.BLUE
	pass

func _attack(damage):
	var lightning_targets = node.Near_Brooms.duplicate()
	node.Near_Brooms.sort_custom(pick_sort(0))
	var strike = projectile.instantiate()
	strike.global_position = node.Near_Brooms[0].global_position
	node.get_tree().get_first_node_in_group("Projectile_Parent").add_child(strike)

func _close_broom_sort(a:Enemy,b:Enemy):
	return a.global_position.distance_to(node.Near_Brooms[0].global_position) < b.global_position.distance_to(node.Near_Brooms[0].global_position)

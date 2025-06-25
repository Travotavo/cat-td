extends Cat_Form
class_name Zap_Cat

func on_enter():
	#Set Animations, Particles, and whatever else necessary
	node.modulate = Color.BLUE
	pass

func _attack(damage):
	var lightning_targets = node.Near_Brooms.duplicate()
	node.Near_Brooms.sort_custom(pick_sort(0))
	node.Near_Brooms[0].take_damage(damage)
	lightning_targets.erase(node.Near_Brooms[0])
	lightning_targets.sort_custom(_close_broom_sort)
	if lightning_targets.size() > 0:
		lightning_targets[0].take_damage(damage)

func _close_broom_sort(a:Enemy,b:Enemy):
	return a.global_position.distance_to(node.Near_Brooms[0].global_position) < b.global_position.distance_to(node.Near_Brooms[0].global_position)

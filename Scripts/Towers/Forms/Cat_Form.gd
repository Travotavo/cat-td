extends Node2D
class_name Cat_Form

var node:Cat

func on_enter():
	#Set Animations, Particles, and whatever else necessary
	node.modulate = Color.WHITE
	pass

func on_exit():
	pass

func _attack(damage:int):
	node.Near_Brooms.sort_custom(pick_sort(0))
	node.Near_Brooms[0].take_damage(damage)

func pick_sort(id:int):
	match id:
		0:
			return sort_distance_close
		1:
			return sort_distance_far
		2:
			return sort_progress_far
		3:
			return sort_progress_least

func sort_distance_close(a:Node2D, b:Node2D):
	return a.global_position.distance_to(node.global_position) < b.global_position.distance_to(node.global_position)

func sort_distance_far(a:Node2D, b:Node2D):
	return a.global_position.distance_to(node.global_position) > b.global_position.distance_to(node.global_position)

func sort_progress_far(a:Enemy,b:Enemy):
	return a.follow_point.progress > b.follow_point.progress

func sort_progress_least(a:Enemy,b:Enemy):
	return a.follow_point.progress < b.follow_point.progress

extends Node2D
class_name Cat_Form

var node:Cat
@onready var visual = preload("res://Assets/Towers/Normal_Cat-Sheet.png")
@onready var visual_lib = preload("res://Assets/Towers/Animation Resources/basic_cat.res")

func on_enter():
	#Set Animations, Particles, and whatever else necessary
	node.set_range(50)
	node.set_cooldown(1)
	node.set_visuals(visual,5,5,visual_lib)
	node.stats.feed_cost = 1
	pass

func on_exit():
	pass

func _attack(damage:int):
	node.Near_Brooms.sort_custom(pick_sort(0))
	face_target(node.Near_Brooms[0])
	node.Near_Brooms[0].take_damage(damage/2)

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

func face_target(target):
	
	if abs(target.global_position.x - node.global_position.x) > abs(target.global_position.y - node.global_position.y):
		if target.global_position.x - node.global_position.x > 0:
			node.sprite.scale.x = -1
		if target.global_position.x - node.global_position.x < 0:
			node.sprite.scale.x = 1
	if abs(target.global_position.x - node.global_position.x) < abs(target.global_position.y - node.global_position.y):
		if target.global_position.y - node.global_position.y > 0:
			node.sprite.scale.x = -1
		if target.global_position.y - node.global_position.y < 0:
			node.sprite.scale.x = 1

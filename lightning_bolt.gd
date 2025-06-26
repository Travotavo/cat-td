extends Node2D

var Near_Brooms:Array = []
var damage := 5

func _damage():
	for broom in Near_Brooms:
		broom.take_damage(damage)
	$Range.queue_free()

func _on_range_entered(area:Area2D):
	if area.get_parent().is_in_group("Enemy"):
		Near_Brooms.append(area.get_parent())

func _on_range_exited(area):
	if area.get_parent().is_in_group("Enemy") and Near_Brooms.has(area.get_parent()):
		Near_Brooms.erase(area.get_parent())

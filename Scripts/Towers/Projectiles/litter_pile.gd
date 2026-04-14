extends Node2D

var damage := 1
var hp := 4

func _on_range_entered(area:Area2D):
	if area.get_parent().is_in_group("Enemy"):
		area.get_parent().take_damage(damage)
		hp -= 1
	if hp <= 0:
		queue_free()

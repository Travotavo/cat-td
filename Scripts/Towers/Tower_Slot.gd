extends Node2D

func _ready():
	for child in $Enchant_Wheel.get_children():
		child.connect('summon', _add_tower)

func _on_mouse_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed:
		$Enchant_Wheel._show()

func _add_tower(Tower:PackedScene):
	var summon = Tower.instantiate()
	if not summon is Cat:
		$Bed.visible = false
	$MouseShape/CollisionShape2D.disabled = true
	$Active_Slot.add_child(summon)
	summon.connect("cat_leaves", _remove_tower)

func _remove_tower():
	$MouseShape/CollisionShape2D.disabled = false
	$Bed.visible = true
	$Active_Slot.get_children()[0].queue_free()

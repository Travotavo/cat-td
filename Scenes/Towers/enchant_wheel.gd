extends Node2D

@onready var Owner = $".."
@export var radius = 48
@onready var count = get_children().size()

func _show():
	for child in get_children():
		child.position = Vector2.ZERO
	visible = true

func _process(delta):
	var iter = 1
	for child in get_children():
		if count == 1:
			child.global_position.x = lerpf(child.global_position.x, Owner.global_position.x, delta*10) 
			child.global_position.y = lerpf(child.global_position.y, Owner.global_position.y, delta*10) 
			return
		child.global_position.x = lerpf(child.global_position.x, Owner.global_position.x + (radius+count) * sin(deg_to_rad((360/count)*iter+(count*90-45))), delta*10) 
		child.global_position.y = lerpf(child.global_position.y, Owner.global_position.y - 32 + (radius+count) * cos(deg_to_rad((360/count)*iter+(count*90-45))), delta*10)
		iter += 1

func _input(event):
	if (event is InputEventMouseButton) and event.pressed:
		var evLocal = make_input_local(event)
		if !Rect2(Vector2(-60,-60), Vector2(120,120)).has_point(evLocal.position):
			visible = false

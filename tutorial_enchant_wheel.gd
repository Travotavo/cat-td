extends Node2D

@onready var Owner = $".."
@export var radius = 16
@export var offset = -45
@onready var count = get_children().size()

func _show():
	$"../AudioStreamPlayer".play()
	for child in get_children():
		child.position = Vector2.ZERO
	get_parent().visible = true

func _process(delta):
	var iter = 1
	for child in get_children():
		if count == 1:
			child.global_position.x = lerpf(child.global_position.x, Owner.global_position.x, delta*10) 
			child.global_position.y = lerpf(child.global_position.y, Owner.global_position.y, delta*10) 
			return
		child.global_position.x = lerpf(child.global_position.x, int(Owner.global_position.x + (radius+count) * sin(deg_to_rad((360/count)*iter+(count*90 + offset)))), delta*10) 
		child.global_position.y = lerpf(child.global_position.y, int(Owner.global_position.y + (radius+count) * cos(deg_to_rad((360/count)*iter+(count*90 + offset)))), delta*10)
		iter += 1

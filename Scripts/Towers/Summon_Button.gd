extends Node2D

signal summon(tower:PackedScene)

@export var summon_option:PackedScene
@export var cost:int = 0

func _on_button_down():
	if cost > 0:
		#Put price checking here, then return if impossible
		pass
	emit_signal('summon', summon_option)
	get_parent().visible = false

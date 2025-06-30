extends Node2D

signal summon(tower:PackedScene, stats:CatStats)

@export var summon_option:PackedScene
@export var cost:int = 0

func _on_button_down():
	if LevelResources.Unused_Cats.size() == 0:
		return
	emit_signal('summon', summon_option,LevelResources.Unused_Cats[0])
	get_parent().visible = false

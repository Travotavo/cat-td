extends Node2D

signal summon(tower:PackedScene, stats:CatStats)

@export var summon_option:PackedScene
@export var cost:int = 0

var cat:CatStats

func _load():
	$Icon2.material.set("shader_parameter/colors",cat.color)

func _on_button_down():
	$click.play()
	emit_signal('summon', summon_option,cat)
	get_parent().get_parent().visible = false

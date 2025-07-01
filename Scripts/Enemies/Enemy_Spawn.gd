extends Node

var enemy_template = preload("res://Scenes/Enemies/Blank_Enemy.tscn")

func _ready():
	Engine.time_scale = 1

func _on_timer_timeout():
	var enemy:Enemy = enemy_template.instantiate()
	enemy.path = $Path2D
	add_child(enemy)

func _process(delta):
	if LevelResources.Lives == 0:
		Engine.time_scale = 0

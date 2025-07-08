extends Node

var enemy_template = preload("res://Scenes/Enemies/Blank_Enemy.tscn")

@export var Starting_Wave_Count:int = 5
var spawned = 0
@export var scaling_number = 3
@export var Starting_Wave_Density:float = 4

@export var Wave_Interval:float = 20.0

func _ready():
	LevelResources.game_end = false
	if not Bgm.playing:
		Bgm.play()
	LevelResources.Mana = 15
	LevelResources.Lives = 9
	LevelResources.round = 1
	for cat in LevelResources.Cats:
		cat.Hunger = cat.Max_Hunger
	Engine.time_scale = 1
	$WaveTimers/Density_Timer.wait_time = Starting_Wave_Density
	$WaveTimers/Density_Timer.start()


func _on_timer_timeout():
	var enemy:Enemy = enemy_template.instantiate()
	enemy.path = $Path2D
	add_child(enemy)
	spawned += 1
	if spawned != Starting_Wave_Count:
		$WaveTimers/Density_Timer.start()
	else:
		$WaveTimers/Wave_Timer.wait_time = Wave_Interval
		$WaveTimers/Wave_Timer.start()

func _on_scale_up():
	LevelResources.round += 1
	Starting_Wave_Density = lerpf(Starting_Wave_Density, 0.5, 0.25)
	spawned = 0
	$WaveTimers/Density_Timer.wait_time = Starting_Wave_Density
	Starting_Wave_Count += scaling_number
	scaling_number += 1
	$WaveTimers/Density_Timer.start()
	

func _process(delta):
	if Input.is_action_just_pressed("leave"):
		Engine.time_scale = 1
		SceneTransition.change_scene_to_file("res://main_menu.tscn")
	if LevelResources.game_end:
		if Input.is_action_just_pressed("press"):
			if LevelResources.Lives == 0:
				SceneTransition.change_scene_to_file("res://Game Scene.tscn")
			else:
				SceneTransition.change_scene_to_file("res://main_menu.tscn")
				Bgm.play()
		return
	if LevelResources.Lives == 0:
		Bgm.stop()
		Engine.time_scale = 1
		LevelResources.game_end = true
		$CanvasLayer/Game_Over.visible = true
		$CanvasLayer/Game_Over/AnimationPlayer.play("Game_Over")
	if LevelResources.Mana >= 100:
		Bgm.stop()
		Engine.time_scale = 1
		LevelResources.game_end = true
		$CanvasLayer/Win_State.visible = true
		$CanvasLayer/Win_State/AnimationPlayer.play("Victory")

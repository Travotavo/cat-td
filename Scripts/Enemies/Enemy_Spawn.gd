extends Node
class_name GameScene
var spawnables = [preload("res://Scenes/Enemies/Blank_Enemy.tscn")]
var additional_enemy_templates = [preload("res://Scenes/Enemies/Tanky_Enemy.tscn"),preload("res://Scenes/Enemies/Speedy_Enemy.tscn")]

@export var Starting_Wave_Allowance:int = 4
var spawned = 0
@export var scaling_number = 3
@export var Starting_Wave_Density:float = 2

@export var Wave_Interval:float = 20.0

@onready var Path:Path2D = $Path2D

static var instance:GameScene

func _ready():
	instance = self
	LevelResources.game_end = false
	if not Bgm.playing:
		Bgm.play()
	LevelResources.Mana = 10
	LevelResources.Lives = 9
	LevelResources.round = 1
	LevelResources.Wave = 0
	for cat in LevelResources.Cats:
		cat.Hunger = cat.Max_Hunger
	Engine.time_scale = 1
	$WaveTimers/Density_Timer.wait_time = Starting_Wave_Density
	$WaveTimers/Density_Timer.start()

func _on_timer_timeout():
	var reward = spawn_enemy()
	spawned += reward
	if spawned <= Starting_Wave_Allowance:
		$WaveTimers/Density_Timer.wait_time = Starting_Wave_Density * reward
		$WaveTimers/Density_Timer.start()
	else:
		print("Next Wave")
		$WaveTimers/Wave_Timer.wait_time = Wave_Interval
		$WaveTimers/Wave_Timer.start()

func _on_scale_up():
	LevelResources.round += 1
	Starting_Wave_Density = lerpf(Starting_Wave_Density, 0.25, 0.25)
	spawned = 0
	$WaveTimers/Density_Timer.wait_time = Starting_Wave_Density
	Starting_Wave_Allowance += scaling_number
	scaling_number += 1
	$WaveTimers/Density_Timer.start()

func _process(delta):
	if Input.is_action_just_pressed("leave"):
		get_tree().paused = true
		$CanvasLayer/PauseOverlay.visible = !$CanvasLayer/PauseOverlay.visible
		$"CanvasLayer/Control/Pause Button".button_pressed = true
		$"CanvasLayer/Control/Pause Button".toggle = true
	if LevelResources.game_end:
		if Input.is_action_just_pressed("press"):
			if LevelResources.Lives == 0:
				SceneTransition.change_scene_to_file("res://Game Scene.tscn")
			else:
				SceneTransition.change_scene_to_file("res://main_menu.tscn")
				Bgm.play()
		return
	if LevelResources.Lives == 0:
		game_lose()
	
	if LevelResources.Mana >= 25 + LevelResources.Wave * 50:
		if LevelResources.Wave == 5: 
			return
		LevelResources.Wave += 1
		$Cat/AnimationPlayer.play("Clear")
		await $Cat/AnimationPlayer.animation_finished
		await clear_board()
		match(LevelResources.Wave):
			1:
				$"CanvasLayer/Wave 1".visible = true
			2:
				$CanvasLayer/Control/CatContainer._addCat()
				LevelResources.Mana = 0
				spawnables.append(additional_enemy_templates[1])
				$"CanvasLayer/Wave 2".visible = true
			3:
				$CanvasLayer/Control/CatContainer._addCat()
				LevelResources.Mana = 0
				spawnables.append(additional_enemy_templates[0])
				$"CanvasLayer/Wave 3".visible = true
			4:
				$CanvasLayer/Control/CatContainer._addCat()
				LevelResources.Mana = 0
				spawnables.remove_at(0)
				$"CanvasLayer/Wave 4".visible = true
			5:
				var Wizard:Enemy = preload("res://Scenes/Enemies/Wizard_Enemy.tscn").instantiate()
				Wizard.path = $Path2D
				add_child(Wizard)
				spawned += Wizard.reward
				Wizard.connect("is_kill",game_win)
				Wizard.connect("is_kill",clear_board)
				Wizard.connect("damage_cat",game_lose)
				$"CanvasLayer/Wave 5".visible = true
		get_tree().paused = true
		$"CanvasLayer/Control/Pause Button".button_pressed = true
		$"CanvasLayer/Control/Pause Button".toggle = true

func clear_board():
	Starting_Wave_Allowance /= 2
	scaling_number = 3
	var the_enemies = Enemy.living_enemies.duplicate()
	for broom in the_enemies:
		if broom != null:
			broom.death()
		await get_tree().create_timer(0.2).timeout

func game_win():
	Bgm.stop()
	Engine.time_scale = 1
	LevelResources.game_end = true
	$CanvasLayer/Win_State.visible = true
	$CanvasLayer/Win_State/AnimationPlayer.play("Victory")

func game_lose():
	LevelResources.Lives = 0
	Bgm.stop()
	$Cat/AnimationPlayer.play("Lose")
	Engine.time_scale = 1
	LevelResources.game_end = true
	$CanvasLayer/Game_Over.visible = true
	$CanvasLayer/Game_Over/AnimationPlayer.play("Game_Over")

func spawn_enemy():
	var enemy:Enemy = spawnables.pick_random().instantiate()
	enemy.path = $Path2D
	add_child(enemy)
	enemy.connect("is_kill",enemy.queue_free)
	enemy.connect("damage_cat",enemy.queue_free)
	return enemy.reward


func _force_pause() -> void:
	get_tree().paused = true
	$"CanvasLayer/Control/Pause Button".button_pressed = true
	$"CanvasLayer/Control/Pause Button".toggle = true

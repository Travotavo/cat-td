extends Enemy

func _on_bwahhahahahaha_timeout() -> void:
	marching = false
	for i in range(10):
		$AnimationPlayer.play("summon")
		$SummonSfx.play()
		await get_tree().create_timer(0.2).timeout
		GameScene.instance.spawn_enemy()
	await get_tree().create_timer(0.5).timeout
	marching = true
	$BWAHHAHAHAHAHA.start()

func _ready():
	super()
	is_kill.connect($BWAHHAHAHAHAHA.stop)
	is_kill.connect(dead_pose)

func dead_pose():
	$Icon.hframes = 1
	$Icon.texture = preload("res://Assets/Enemies/wizard_death.png")
	$AnimationPlayer.play("RESET")
	

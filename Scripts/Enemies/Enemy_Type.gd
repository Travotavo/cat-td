extends Node2D
class_name Enemy

signal damage_cat
signal is_kill
#Unit stats
@export var SPEED:int = 1
@export var Health:int = 12
@export var reward:int = 1
#Onready components
@onready var animator:= $AnimationPlayer

#Variables for moving along path
@export var path:Path2D
var follow_point:PathFollow2D
var marching = true

static var living_enemies = []

func _physics_process(delta):
	if LevelResources.game_end:
		set_process(false)
		$AnimationPlayer.stop()
		return
	if not marching:
		return
	var following_rotation = abs(follow_point.rotation_degrees)
	if following_rotation > 90:
		animator.play("Walk_Left")
	if following_rotation < 90:
		animator.play("Walk_Right")
	global_position = Vector2i(follow_point.global_position)
	follow_point.progress += SPEED * delta
	if follow_point.progress_ratio == 1:
		_deal_damage()

func _process(delta):
	$ProgressBar.value = Health

func _ready():
	follow_point = PathFollow2D.new()
	follow_point.loop = false
	path.add_child(follow_point)
	$ProgressBar.max_value = Health
	living_enemies.append(self)

func take_damage(damage:int):
	Health -= damage
	if Health <= 0:
		LevelResources.Mana += reward
		death()
		return true
	return false

func _deal_damage():
	living_enemies.erase(self)
	marching = false
	animator.play("Spill")
	await animator.animation_finished
	LevelResources.Lives -= 1
	animator.play("Death")
	await animator.animation_finished
	follow_point.queue_free()
	damage_cat.emit()

func death():
	marching = false
	animator.play("Death")
	await animator.animation_finished
	follow_point.queue_free()
	living_enemies.erase(self)
	is_kill.emit()

extends Node2D
class_name Enemy

signal damage_cat

#Unit stats
@export var SPEED:int = 1
@export var Health:int = 10
@export var reward:int = 1
#Onready components
@onready var animator:= $AnimationPlayer

#Variables for moving along path
@export var path:Path2D
var follow_point:PathFollow2D
var marching = true

func _physics_process(delta):
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

func take_damage(damage:int):
	Health -= damage
	if Health <= 0:
		death()

func _deal_damage():
	marching = false
	animator.play("Spill")
	await animator.animation_finished
	damage_cat.emit()
	death()

func death():
	LevelResources.Mana += reward
	marching = false
	animator.play("Death")
	await animator.animation_finished
	follow_point.queue_free()
	queue_free()

extends Node2D
class_name Cat

var stats:CatStats
var Near_Brooms:Array = []

@onready var range := $Range/CollisionShape2D
@onready var cooldown := $Cooldown
var cooled = false
@onready var sprite = $Sprite

func _load():
	$Sprite.material.set("shader_parameter/colors",stats.color)

func _ready():
	AddState("Base", Cat_Form.new())
	AddState("Zap", Zap_Cat.new())
	AddState("Sword", Sword_Cat.new())
	SetState("Base")

func set_range(new_range:int):
	range.shape.radius = new_range

func set_cooldown(new_time:int):
	cooldown.wait_time = new_time

func set_visuals(sheet, hframes, vframes ,lib: AnimationLibrary):
	$Sprite.texture = sheet
	$Sprite.hframes = hframes
	$Sprite.vframes = vframes
	$AnimationPlayer.remove_animation_library("")
	$AnimationPlayer.add_animation_library("",lib)

func _physics_process(delta):
	if LevelResources.game_end:
		set_process(false)
		$AnimationPlayer.stop()
		return
	if not $AnimationPlayer.is_playing():
		$AnimationPlayer.play("Idle")
	if cooled and Near_Brooms.size() > 0:
		cooled = false
		_cat_fire()

func _on_cooldown():
	cooled = true

func _cat_fire():
	if stats.Hunger <= 0:
		stats.emit_signal('starve')
		SetState('Base')
		$AnimationPlayer.play("Flee")
		await $AnimationPlayer.animation_finished
		emit_signal("cat_leaves")
		return
	$AnimationPlayer.play("Attack")
	stats.Hunger -= 10
	if stats.Hunger <= 20:
		$Meow.play()
	form._attack(6)
	$Cooldown.start()

signal cat_leaves
func _remove_cat():
	stats.emit_signal('starve')
	emit_signal("cat_leaves")

func _on_range_entered(area:Area2D):
	if area.get_parent().is_in_group("Enemy"):
		Near_Brooms.append(area.get_parent())

func _on_range_exited(area):
	if area.get_parent().is_in_group("Enemy") and Near_Brooms.has(area.get_parent()):
		Near_Brooms.erase(area.get_parent())


var _forms:Dictionary = {}

var form:Cat_Form
var baseForm:Cat_Form

func AddState(nm:String, state:Cat_Form):
	state.node = self
	add_child(state)
	_forms[nm] = state

func SetState(newState):
	if (form != null):
		form.on_exit()
	if newState is Cat_Form:
		form = newState
	else:
		if newState is String && _forms.has(newState):
			form = _forms[newState]
		else:
			print("ERROR: State " + newState + " does not exist")
	if (form != null):
		form.on_enter()


func _on_mouse_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed:
		$Node2D/Enchant_Wheel._show()

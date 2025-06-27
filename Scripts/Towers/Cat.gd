extends Node2D
class_name Cat

var Hunger:float = 1.0
var HungerDrain:float = 0.05
var Near_Brooms:Array = []

@onready var range := $Range/CollisionShape2D
var cooled = false

func _ready():
	AddState("Base", Cat_Form.new())
	AddState("Zap", Zap_Cat.new())
	AddState("Sword", Zap_Cat.new())
	SetState("Base")

func _physics_process(delta):
	if not $AnimationPlayer.is_playing():
		$AnimationPlayer.play("Idle")
	if cooled and Near_Brooms.size() > 0:
		cooled = false
		_cat_fire()

func _process(delta):
	$ProgressBar.value = 1.0 - Hunger


func _on_cooldown():
	cooled = true

func _cat_fire():
	$AnimationPlayer.play("Attack")
	Hunger -= HungerDrain
	form._attack(5)
	$Cooldown.start()

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
		$Enchant_Wheel._show()

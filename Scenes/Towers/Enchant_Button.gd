extends Node2D

@export var form:String
@export var cost:int
@export var cat_parent:Cat

func _ready():
	$Enchant_Button/Label.text = str(cost)

func _on_button_down():
	if cost > LevelResources.Mana:
		return
	LevelResources.Mana -= cost
	cat_parent.SetState(form)
	get_parent().get_parent().visible = false

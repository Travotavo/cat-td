extends Resource

signal restock

@export var palette:ColorPalette
@export var nickname:String
var Max_Hunger = 100
var Hunger = 100

func feed():
	Hunger = 100

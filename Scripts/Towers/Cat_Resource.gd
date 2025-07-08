extends Resource
class_name CatStats

signal starve
signal restock

@export var nickname:String
@export var color:Texture2D

var feed_cost = 1
var Max_Hunger = 100
var Hunger = 100

func feed():
	Hunger = 100

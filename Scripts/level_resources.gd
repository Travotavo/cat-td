extends Node
var Mana = 25
var Cats:Array[CatStats] = []
var Unused_Cats = []
var Used_Cats = []
var Timeout_cats = []

var cat_directory := "res://Scripts/Towers/Cats/"
var cat_files:Array
func _enter_tree():
	var dir := DirAccess.open(cat_directory)
	cat_files = dir.get_files()

func load_rando_cats(num:int):
	var picking_cats = cat_files.duplicate()
	Cats = []
	for i in range(num):
		var picked = picking_cats.pick_random()
		print(picked)
		picking_cats.erase(picked)
		Cats.append(load(cat_directory + picked))
	Unused_Cats = Cats

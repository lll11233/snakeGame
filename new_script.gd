extends Node


var fruit_scenes = [
	preload("res://assets/apple.png"),
	preload("res://assets/cherry.png"),
	preload("res://assets/watermelon.png")
]

#fruit variables
var food_pos: Vector2
var regen_food: bool = true


#grid variables
var cells: int = 20
var cell_size : int = 50

func spawn_fruit():
	var FruitScene = fruit_scenes[randi() % fruit_scenes.size()]
	var fruit = FruitScene.instantinate()
	#fruit.position = Vector2(
		#randi() % grid_width * cell_size,
		#randi() % grid_height * cell_size
	#)
	fruit.position = (food_pos* cell_size) + Vector2(0, cell_size)
	add_child(fruit)
	
	

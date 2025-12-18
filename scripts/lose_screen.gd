extends Node

#@export var fruit_icon_scene: PackedScene
@onready var fruit_container = $FruitContainer
@onready var score_label = $ScoreLabel

var fruit_scenes = [
	preload("res://scenes/apple_scene.tscn"),
	preload("res://scenes/cherry_scene.tscn"),
	preload("res://scenes/orange_scene.tscn"),
	preload("res://scenes/watermelon_scene.tscn"),
	preload("res://scenes/banana_scene.tscn"),
	preload("res://scenes/kiwi_scene.tscn"),
	preload("res://scenes/grape_scene.tscn"),
	preload("res://scenes/strawberry_scene.tscn"),
	preload("res://scenes/mango_scene.tscn"),
]
#var FruitScene = fruit_scenes[randi() % fruit_scenes.size()]
#var fruit_instance = FruitScene.instantiate()
#var tex = fruit_instance.texture
#var img = tex.get_image()
#img.resize(50, 50) 
#.texture = ImageTexture.create_from_image(img)


## 1. need to randomise the types of fruits that go into the bowl 
## 2. animate the bowl to look entertaining



var score = Main.score




func show_results(score: int):
	print(score)
	score_label.text = "Fruits collected: %d" % score

	for i in range(score):
		var fruit_icon_scene = fruit_scenes[randi() % fruit_scenes.size()]
		var fruit = fruit_icon_scene.instantiate()
		fruit_container.add_child(fruit)

		# Random position inside bowl
		var x = randf_range(20, fruit_container.size.x - 20)
		var y = randf_range(20, fruit_container.size.y - 20)
		fruit.position = Vector2(x, y)
		fruit.resize(50,50)

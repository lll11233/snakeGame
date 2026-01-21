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
#fruit.texture = ImageTexture.create_from_image(img)


## 1. need to randomise the types of fruits that go into the bowl 
## 2. animate the bowl to look entertaining
#const fallingObjectsScene: PackedScene = preload("res://scenes/fallling_objects.tscn")




var score = Main.score

#func _ready():
	#print(score)
	#spawn_fruit(score)

#func _process(float) -> void:
	#spawn_fruit(score)




#func spawn_fruit(score: int) -> void:
	#for i in range(score):
		## 1. Instantiate a new instance of the scene
		#var new_object = fallingObjectsScene.instantiate()
		#
		## Optional: Set the position or other properties of the new instance
		## You can use 'i' to add an offset so they don't all spawn in the same place
		#new_object.position = Vector2(50 * i, 0) 
		#
		## 2. Add the new instance to the scene tree as a child of the current node
		#add_child(new_object)


func show_results(score: int):
	#print(score)
	score_label.text = "Fruits collected: %d" % score

	for i in range(score):
		var fruit_icon_scene = fruit_scenes[randi() % fruit_scenes.size()]
		var fruit = fruit_icon_scene.instantiate()
		fruit_container.add_child(fruit)
		var tex = fruit.texture
		var img = tex.get_image()
		img.resize(100,100)

		# Random position inside bowl
		var x = randf_range(20, fruit_container.size.x - 20)
		var y = randf_range(20, fruit_container.size.y - 20)
		fruit.position = Vector2(x, y)
		

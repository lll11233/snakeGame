extends Node

var falling_object_scene = preload("res://scenes/fallingObject.tscn")

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



#for i in range(score):
	#var fruit_object_scene = fruit_scenes[randi() % fruit_scenes.size()]
	#var fruit = fruit_icon_scene.instantiate()
	##fruit_container.add_child(fruit)
	#var tex = fruit.texture
	#var img = tex.get_image()
	#img.resize(200,200)


var score = Main.score
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$Timer.timeout.connect(_on_timer_timeout) # Connect the timer signal
	$Timer.start() # Start the timer
	randomize() # Initialize random number generator


func _on_timer_timeout():
	var new_object = falling_object_scene.instantiate()
	add_child(new_object)
	new_object.position.x = randf_range(0,1000)
	new_object.position.y = $Marker2D.position.y
	#new_object.connect("collected", _on_object_collected())
	
func _on_object_collected():
	score = score + 1
	print("The Score is now ", score)





#func _on_timer_timeout():
	#var new_object = falling_object_scene.instantiate()
	## Randomize starting position (x-coordinate)
	#new_object.position.x = randf_range(0, screen_size.x)
	#new_object.position.y = 0 # Start at the top
	#add_child(new_object)

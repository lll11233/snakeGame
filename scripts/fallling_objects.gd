extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += 300 *delta




# Export an array of Textures for easy management in the Inspector





	#var FruitScene = fruit_scenes[randi() % fruit_scenes.size()]
	#var fruit_instance = FruitScene.instantiate()
	#var tex = fruit_instance.texture
	#var img = tex.get_image()
	#img.resize(50, 50) 
	#var food = get_tree().get_root().get_node("_Node_2/food")
	#food.texture = ImageTexture.create_from_image(img)

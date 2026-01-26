extends Area2D


var score = Main.score

var speed = 300
# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#area_entered.connect(_on_falling_object_area_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += speed *delta 
	if position.y > 1000:
		queue_free()
		

#func _on_area_entered(other_area):
	#if other_area.is_in_group("basket"):
		#emit_signal("collected")
		#queue_free() ## this means to remove an object, like remove from scene tree?
		
#func  _on_falling_object_area_entered(area):
	#if area.name == "player":
		#queue_free()
		#emit_signal("collected")
		#score = score + 1
		


#func _on_area_entered(area) -> void:
	#if area.name == "player":
		#print("Player touched object")
		#queue_free()
		#emit_signal("collected")
		##score = score + 1
		#get_tree().get_root().get_node("main").increase_score()



func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		print("Player touched object!")
		Main.increasing_additional_score()

		queue_free()
		
		

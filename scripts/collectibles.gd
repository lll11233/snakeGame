extends Area2D




var speed = 300
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(_on_area_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += speed *delta 
	if position.y > 600:
		queue_free()
		
func _on_area_entered(other_area):
	if other_area.is_in_group("player_hitbox"):
		emit_signal("collected")
		queue_free() ## this means to remove an object, like remove from scene tree?
		

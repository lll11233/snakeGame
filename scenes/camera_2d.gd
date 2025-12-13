extends Camera2D
@export var shake_strength := 8.0
@export var shake_duration := 0.15
var shake_time := 0.0
var original_position := 0.15

#
#func shake():
	#shake_time = shake_duration
	#
#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#original_position = position
#
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#if shake_time > 0:
		#shake_time -= delta
		#position = original_position + Vector2(
			#randf_range(-shake_strength, shake_strength),
			#randf_range(-shake_strength, shake_strength)
		#)
	#else:
		#position = original_position
	### there is a problem with the camera shake - find an actual tutorial that teaches this

extends CanvasLayer
@onready var _animated_sprite = $AnimatedSprite2D


signal restart


func _ready() -> void:
	_animated_sprite.play()



func _on_restart_button_pressed():
	print("pressed restart")
	restart.emit()
	#get_tree().paused = true
	print ("we got up to here - in the main file code")
	queue_free()
	get_tree().paused = true
	Main.new_game()

	

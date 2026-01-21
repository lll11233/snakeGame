extends CharacterBody2D


const SPEED = 300.0


func _physics_process(delta: float) -> void:
	var direction = Input.get_axis("move_left","move_right")
	if direction != 0:
		##what does != mean?
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	position.x = clamp(position.x, 0, get_viewport_rect().size.x)

extends Node

@export var snakeScene : PackedScene


#game variables
var score: int
var game_started: bool = false

#grid variables
var cells: int = 20
var cell_size : int = 50

#snake variables
var old_data : Array
var snake_data : Array
var snake : Array

#movement variables
var start_pos = Vector2(9,9)
var up = Vector2(0,-1)
var down = Vector2(0,1)
var left = Vector2(-1,0)
var right = Vector2(1,0)
var move_direction : Vector2
var can_move: bool



## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()

func new_game():
	score = 0
	$HUD.get_node("scoreLabel").text = "SCORE: " + str(score)
	move_direction = up
	can_move = true
	generate_snake()
	
func generate_snake():
	old_data.clear()
	snake_data.clear()
	snake.clear()
		
	for i in range(3):
		add_segment(start_pos + Vector2(0,i))
func add_segment(pos):
	snake_data.append(pos)
	var SnakeSegment = snakeScene.instantiate()
	SnakeSegment.position = (pos*cell_size) + Vector2(0, cell_size)
	add_child(SnakeSegment)
	snake.append(SnakeSegment)
	
func _process(delta):
	move_snake()

func move_snake():
	if can_move:
		
		if Input.is_action_just_pressed("move_down") and move_direction != up:
			move_direction = down
			can_move = false
			if not game_started:
				start_game()
		if Input.is_action_just_pressed("move_up") and move_direction != down:
			move_direction = up
			can_move = false
			if not game_started:
				start_game()
		if Input.is_action_just_pressed("move_left") and move_direction != right:
			move_direction = left
			can_move = false
			if not game_started:
				start_game()
		if Input.is_action_just_pressed("move_right") and move_direction != left:
			move_direction = right
			can_move = false
			if not game_started:
				start_game()
func start_game():
	game_started = true
	$MoveTimer.start()
			 


func _on_move_timer_timeout() -> void:
	pass # Replace with function body.

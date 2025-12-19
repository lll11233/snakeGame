extends Node

@export var snakeScene : PackedScene
#@export var CameraView: PackedScene
@export var StartMenu: PackedScene
@export var GameOverMenu: PackedScene
#@export var lose_screen: PackedScene
@export var HUD: PackedScene



#game 
var score: int
var game_started: bool = false

#food variables
var food_pos: Vector2
var regen_food: bool = true
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

#var banana = "res://scenes/banana_scene.tscn"

#var banana_score: int
#var banana_item = fruit_scenes[4]

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
	#StartMenu.show()
	var start = get_tree().get_root().get_node("_Node_2/StartMenu")
	start.show()
	new_game() 
	## startmenu still doesnt show, why?



func new_game():
	get_tree().paused = false
	get_tree().call_group("segments", "queue_free")
	var GameOver = get_tree().get_root().get_node("_Node_2/GameOverMenu")
	GameOver.hide()
	var lose_screen = get_tree().get_root().get_node("/root/_Node_2/lose_screen")
	#lose_screen.hide()
	lose_screen.queue_free()
	#lose_screen = null
	#if lose_screen:
		#lose_screen.queue_free()
		#lose_screen = null

	score = 0
	#banana_score = 0 ## this is interesting, scores don't align
	var scorelabel = get_tree().get_root().get_node("_Node_2/HUD/scoreLabel")
	scorelabel.text = "SCORE:  " + str(score)
	
	move_direction = up
	can_move = true
	generate_snake()
	move_food()
	
func generate_snake():
	old_data.clear()
	snake_data.clear()
	snake.clear()
		
	for i in range(3):
		add_segment(start_pos + Vector2(0,i))
func add_segment(pos):
	snake_data.append(pos)
	var snakePart = preload("res://scenes/snakeScene.tscn")
	var SnakeSegment = snakePart.instantiate()
	SnakeSegment.position = (pos*cell_size) + Vector2(0, cell_size)
	add_child(SnakeSegment)
	snake.append(SnakeSegment)
	
func _process(_delta):
	move_snake()
	var backgroundTheme = get_tree().get_root().get_node("_Node_2/backgroundTheme")
	if backgroundTheme.playing == false :
		backgroundTheme.play()


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
	var moveTimer = get_tree().get_root().get_node("_Node_2/MoveTimer")
	moveTimer.start()
	
			 


func _on_move_timer_timeout() -> void:
	#allow snake movement
	can_move = true
	#use the snake's previous position to move the segments
	old_data = [] + snake_data
	snake_data[0] += move_direction
	for i in range(len(snake_data)):
		#move all segments along by one
		if i > 0:
			snake_data[i] = old_data[i-1]
		snake[i].position = (snake_data[i]*cell_size) + Vector2(0,cell_size)
	check_out_of_bounds()
	check_self_eaten()
	check_food_eaten()
func check_out_of_bounds():
	if snake_data[0].x < 0 or snake_data[0].x > cells - 1 or snake_data[0].y < 0 or snake_data[0].y > cells - 1:
		end_game()

func check_self_eaten():
	for i in range(1, len(snake_data)):
		if snake_data[0] == snake_data[1]:
			end_game()
func end_game():
	$endSound.play()
	var CameraView = get_tree().get_root().get_node("_Node_2/CameraView")
	CameraView.apply_shake()
	$MoveTimer.stop()
	await get_tree().create_timer(1).timeout
	#lose_screen_ui.show_results(score)
	var lose_screen_scene = preload("res://scenes/lose_screen.tscn")
	var lose_screen_ui = lose_screen_scene.instantiate()
	get_tree().root.add_child(lose_screen_ui)
	print("Script on lose_screen_ui:", lose_screen_ui.get_script())

	lose_screen_ui.show_results(score)
	## this still aint working!!!!! 


	
	
	await get_tree().create_timer(5).timeout
	$GameOverMenu.get_node("endResult").text = "SCORE: " + str(score)
	#$GameOverMenu.get_node("bananaResult").text = "BANANA SCORE: " + str(banana_score)
	$GameOverMenu.show()
	game_started = false
	get_tree().paused = true




func move_food():
	while regen_food:
		regen_food = false
		food_pos = Vector2(randi_range(0, cells-1), randi_range(0, cells-1))
		for i in snake_data:
			if food_pos == i:
				regen_food = true
		for i in snake_data:
			if food_pos == i:
				regen_food = true
	var FruitScene = fruit_scenes[randi() % fruit_scenes.size()]
	var fruit_instance = FruitScene.instantiate()
	var tex = fruit_instance.texture
	var img = tex.get_image()
	img.resize(50, 50) 
	var food = get_tree().get_root().get_node("_Node_2/food")
	food.texture = ImageTexture.create_from_image(img)
	food.position = (food_pos * cell_size) + Vector2(0, cell_size)

	regen_food = true




func check_food_eaten():
	#if $food.texture == ImageTexture("res://assets/banana.png"):
		#banana_score += 1 ## banana score still doenst work
	if snake_data[0] == food_pos:
		$soundEffect.play()
		score += 1
		var scorelabel = get_tree().get_root().get_node("_Node_2/HUD/scoreLabel")
		scorelabel.text = "SCORE:  " + str(score)
		add_segment(old_data[-1])
		move_food()
	#if snake_data[0] == food_pos and FruitScene[4]:
		#banana_score += 1
	if score == 2:
		var scorelabel = get_tree().get_root().get_node("_Node_2/HUD/scoreLabel")
		scorelabel.text = "You've eaten your two serves of fruit!"
	#if banana_score == 50:
		#$HUD.get_node("scoreLabel").text = "You've eaten 50 bananas resulting which is dental x-ray dose of radiation!"
#
#

func _on_game_over_menu_restart():
	new_game()

func _on_start_menu_new():
	$StartMenu.hide()

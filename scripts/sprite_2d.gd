extends Sprite2D
@export var sprite_textures: Array[Texture2D] = []


# Called when the node enters the scene tree for the first time.
func _ready():
	if sprite_textures.size() > 0:
		randomize() 
		var random_texture = sprite_textures.pick_random()
		self.texture = random_texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

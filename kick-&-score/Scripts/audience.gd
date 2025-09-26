extends Node2D

# Array to hold references to Sprite2D nodes
var sprites: Array = []

func _ready():
	# Get all Sprite2D nodes as children of this node
	sprites = get_children().filter(is_sprite2d)
	
	if sprites.size() != 8:
		print("Warning: Expected 8 Sprite2D nodes, but found %d" % sprites.size())
	
	# Start animations for all sprites
	for sprite in sprites:
		start_animation(sprite)

# Function to check if a node is a Sprite2D
func is_sprite2d(node: Node) -> bool:
	return node is Sprite2D

# Function to start animation for a Sprite2D
func start_animation(sprite: Sprite2D):
	var animation_player = sprite.get_node("AnimationPlayer")
	if animation_player:
		animation_player.play("default")  # Replace "default" with your animation name
	else:
		print("Error: AnimationPlayer not found for %s" % sprite.name)

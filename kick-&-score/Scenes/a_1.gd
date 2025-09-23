extends Node2D

# Declare a variable to reference the AnimatedSprite2D node
@onready var sprite_animation: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	# Start the animation when the scene is ready
	start_animation("default")

func start_animation(animation_name: String) -> void:
		sprite_animation.play(animation_name)

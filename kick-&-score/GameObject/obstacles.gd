extends CharacterBody2D

# Movement speed of the player
@export var speed: float = 200.0

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	# Reset velocity
	var input_velocity = Vector2.ZERO

	# Check for input (ASWD keys)
	if Input.is_action_pressed("ui_left"):  # A key
		input_velocity.x -= 1
	if Input.is_action_pressed("ui_right"):  # D key
		input_velocity.x += 1
	if Input.is_action_pressed("ui_up"):  # W key
		input_velocity.y -= 1
	if Input.is_action_pressed("ui_down"):  # S key
		input_velocity.y += 1

	# Normalize input velocity to prevent faster diagonal movement
	if input_velocity.length() > 0:
		input_velocity = input_velocity.normalized() * speed

	# Update the velocity property
	velocity = input_velocity

	# Move the player using move_and_slide()
	move_and_slide()

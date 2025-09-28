extends CharacterBody2D

const SPEED = 50.0
var current_dir = "none"
var pushing_ball = false

func _ready() -> void:
	$AnimatedSprite2D.play("idle")

func _physics_process(delta: float) -> void:
	player_movement(delta)
	check_collision(delta)

func player_movement(delta: float) -> void:
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = SPEED
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -SPEED
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		play_anim(1)
		velocity.x = 0
		velocity.y = SPEED
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		play_anim(1)
		velocity.x = 0
		velocity.y = -SPEED
	else:
		play_anim(0)
		velocity = Vector2.ZERO

	move_and_slide()
	if pushing_ball:
		push_ball()

func play_anim(movement: int) -> void:
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("walk_side")
		elif movement == 0:
			anim.play("idle")
	
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("walk_side")
		elif movement == 0:
			anim.play("idle")
	
	if dir == "up":
		anim.flip_h = false
		if movement == 1:
			anim.play("walk_back")
		elif movement == 0:
			anim.play("idle")
		
	if dir == "down":
		anim.flip_h = false
		if movement == 1:
			anim.play("walk_front")
		elif movement == 0:
			anim.play("idle")

func push_ball() -> void:
	var ball = get_node_or_null("Ball") # Use get_node_or_null to avoid errors if the node doesn't exist
	if ball:
		print("Ball node found!")
	else:
		print("Ball node not found!")
	if ball and ball is RigidBody2D:
		ball.apply_impulse(Vector2.ZERO, velocity.normalized() * 1000)

func check_collision(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		var collider = collision.get_collider()
		if collider.name == "Ball":
			pushing_ball = true
			print("Player is now in collision with the ball!")
		else:
			pushing_ball = false

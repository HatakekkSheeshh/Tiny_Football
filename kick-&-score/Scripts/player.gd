extends CharacterBody2D

# Const variables
const SPEED = 100.0
const GAIN := 1.0            # rate: ball ≈ GAIN * player_velocity
const MAX_BALL_SPEED := 1000 # max velocity for the ball (px/s)

var current_dir = "none"
var pushing_ball = false
var ball: RigidBody2D = null  


func _ready() -> void:
	$AnimatedSprite2D.play("idle")

func _physics_process(delta: float) -> void:
	player_movement(delta)
	check_collision()  

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
	if ball and velocity.length() > 0.01:
		var v_unit = velocity.normalized()
		var v_magnitude = velocity.length()
		var v_target = min(v_magnitude * GAIN, MAX_BALL_SPEED)
		var v_along = ball.linear_velocity.dot(v_unit)
		var dv = v_target - v_along
		if dv > 0.0: 
			var j = ball.mass * dv
			ball.apply_central_impulse(v_unit * j)

func check_collision() -> void:
	pushing_ball = false
	ball = null

	if velocity.length() <= 0.01:
		return

	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision == null:
			continue
		var collider = collision.get_collider()
		if collider is RigidBody2D:
			ball = collider
			pushing_ball = true
			push_ball() 

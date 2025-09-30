#extends RigidBody2D
#var ball:RigidBody2D =null
#var pushing_ball:bool =false
#
#func _ready()->void:
	#ball=get_node("Ball")
#
#func push_ball() -> void:
	#if ball and velocity.length() > 0.01:
		#var v_unit = velocity.normalized()
		#var v_magnitude = velocity.length()
		#var v_target = min(v_magnitude * GAIN, MAX_BALL_SPEED)
		#var v_along = ball.linear_velocity.dot(v_unit)
		#var dv = v_target - v_along
		#if dv > 0.0: 
			#var j = ball.mass * dv
			#ball.apply_central_impulse(v_unit * j)
#
#func check_collision() -> void:
	#pushing_ball = false
	#ball = null
#
	#if velocity.length() <= 0.01:
		#return
#
	#for i in range(get_slide_collision_count()):
		#var collision = get_slide_collision(i)
		#if collision == null:
			#continue
		#var collider = collision.get_collider()
		#if collider is RigidBody2D:
			#ball = collider
			#pushing_ball = true
			#push_ball() 

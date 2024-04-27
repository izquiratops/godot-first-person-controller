extends PlayerState

func init(_data: Dictionary={}) -> void:
	print('Crouch')
	player.current_speed = 3.0

	# Ducking head
	player.crouch_depth = -0.5
	standing_collision_shape.disabled = true
	crouching_collision_shape.disabled = false

func update(_delta) -> void:
	player.apply_input_direction()

	# Player can jump while crouching
	if Input.is_action_just_pressed("jump") and can_jump():
		emit_signal("change_state_request", "Jump")

	# Change state whenever the crouch button is not pressed anymore
	elif not Input.is_action_pressed("crouch"):
		if player.input_direction.is_zero_approx():
			emit_signal("change_state_request", "Idle")
		elif Input.is_action_pressed("sprint"):
			emit_signal("change_state_request", "Sprint")
		else:
			emit_signal("change_state_request", "Walk")

func leave() -> void:
	# Setting the character head back to default values
	player.crouch_depth = 0.0
	crouching_collision_shape.disabled = true
	standing_collision_shape.disabled = false

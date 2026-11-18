extends "res://Scripts/player_base.gd"

func handle_movement(delta: float) -> void:
	# --------------------
	# TODO STEP 56
	# Write code for handling player input
	# --------------------
	var input_dir = Vector3.ZERO
	if Input.is_action_pressed("ui_left"):
		input_dir.x -= 1
	if Input.is_action_pressed("ui_right"):
		input_dir.x += 1
	if Input.is_action_pressed("ui_up"):
		input_dir.z -= 1
	if Input.is_action_pressed("ui_down"):
		input_dir.z += 1
	
	
	# --------------------
	# TODO STEP 71
	# Normalize input direction so that it's a unit vector
	# --------------------
	input_dir = input_dir.normalized()
	input_dir = global_basis * input_dir
	
	
	# --------------------
	# TODO STEP 73
	# Set the position of our player depending on the input
	# --------------------
	var target_position = global_position + input_dir * move_speed * delta
	global_position = target_position

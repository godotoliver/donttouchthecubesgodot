extends RigidBody3D

@export var move_speed: float = 10.0
@export var difficultyMultiplier: float = 0.01

const rotation_speed: float = 7.0

var died: bool = false

func _physics_process(delta: float) -> void:
	if died:
		return

	# Increase difficulty
	Engine.time_scale += delta * difficultyMultiplier

	# Rotate character
	rotate_y(deg_to_rad(rotation_speed) * delta)

	# Let child handle movement
	handle_movement(delta)

func handle_movement(_delta: float) -> void:
	pass # To be overridden by child

func _on_slowmo_timeout(delta: float):
	Engine.time_scale = 0.5
	rotate_x(deg_to_rad(rotation_speed) * delta)

func reload_scene():
	if get_tree():
		get_tree().reload_current_scene()

func _on_body_entered(_body: Node) -> void:
	if died:
		return

	var sfx = AudioStreamPlayer.new()
	sfx.stream = load("res://Assets/Sfx/explosion.mp3")
	add_child(sfx)
	sfx.play()
	died = true
	
	get_node("../CanvasLayer/ColorRect").visible = true

	Engine.time_scale = 0.2
	var timer = Timer.new()
	timer.wait_time = 999999999999999
	timer.one_shot = true
	timer.autostart = true
	timer.timeout.connect(_on_slowmo_timeout)

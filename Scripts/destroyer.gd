extends Node3D

@export var time_to_destroy: float = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var timer = Timer.new()
	timer.wait_time = time_to_destroy
	timer.autostart = true
	timer.one_shot = true
	timer.timeout.connect(destroy_self)
	add_child(timer)

func destroy_self():
	get_parent().queue_free()

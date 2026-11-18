extends RigidBody3D

@export var rotSpeed: float = 1

func _process(delta: float) -> void:
	rotate(Vector3.UP, rotSpeed * delta)

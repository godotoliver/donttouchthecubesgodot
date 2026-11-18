extends Node3D

@export var cube_scene: PackedScene
@export var spawn_amount: float = 40

const spawn_range: int = 50

var spawn: float = 0

var cubeScene = load("res://Scenes/Objects/cube.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	spawn += spawn_amount * delta
	while(spawn > 0):
		spawn -= 1
		var cube = cube_scene.instantiate()
		
		var randomX = randf_range(-spawn_range, spawn_range)
		var randomZ = randf_range(-spawn_range, spawn_range)
		cube.position = global_position + Vector3(randomX, 0, randomZ)

		#Doing this ensures cubes are destroyed when reloading scene
		var main_scene = get_tree().get_current_scene()
		var container = main_scene.get_node("CubeContainer")
		container.add_child(cube)
		#Does not work if they are a child of the main scene

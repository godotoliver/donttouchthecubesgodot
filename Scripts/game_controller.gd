extends Node

@export var score_label: Label
@export var highscore_label: Label

var time_passed: float = 0.0
var high_score: int = 0

func _ready() -> void:
	load_high_score()
	update_highscore_label()

func _process(delta: float) -> void:
	time_passed += delta
	var current_score = int(time_passed)

	# Update score display
	score_label.text = "Score: " + str(current_score)

	# Check for new high score
	if current_score > high_score:
		high_score = current_score
		save_high_score()
		update_highscore_label()

func update_highscore_label():
	highscore_label.text = "Best: " + str(high_score)

func save_high_score():
	var file = FileAccess.open("user://highscore.save", FileAccess.WRITE)
	file.store_var(high_score)
	file.close()

func load_high_score():
	if FileAccess.file_exists("user://highscore.save"):
		var file = FileAccess.open("user://highscore.save", FileAccess.READ)
		high_score = file.get_var()
		file.close()
	else:
		high_score = 0
#The file highscore.save is saved to a special sandboxed folder that Godot uses to store game data across sessions — it's platform-dependent, but here's how to find it: C:\Users\<YourName>\AppData\Roaming\Godot\app_userdata\<YourProjectName>\highscore.save

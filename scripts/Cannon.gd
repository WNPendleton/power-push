extends Area

export var rotationLimit = deg2rad(65)
export var rotationSpeed = 1
export var lives = 3

onready var UI = get_tree().get_current_scene().get_node("UI")

func _process(delta):
	rotate_z(rotationSpeed*delta)
	if abs(rotation.z) > rotationLimit:
		rotation.z = rotation.z / abs(rotation.z) * rotationLimit
		rotationSpeed *= -1

func damage():
	lives -= 1
	if lives < 0:
		do_game_over()
	else:
		UI.update_lives(lives)

func do_game_over():
	get_tree().quit()

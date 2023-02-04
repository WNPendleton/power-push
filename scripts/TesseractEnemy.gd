extends "res://scripts/Enemy.gd"

export var rotation_vector = Vector3(2,3,5)
export var inner_rotation_vector = Vector3(5,3,2)
export var base_rotation_speed = 0.75

var rotation_speed = base_rotation_speed

onready var entity = $Area
onready var inner_cube = $Area/InnerCube

func _ready():
	randomize()
	rotation_speed = (randf() + 0.5) * base_rotation_speed
	if randf() > 0.5:
		rotation_speed *= -1

func _process(delta):
	entity.transform = entity.transform.rotated(Vector3.UP, rotation_vector.x * delta * rotation_speed)
	entity.transform = entity.transform.rotated(Vector3.LEFT, rotation_vector.y * delta * rotation_speed)
	entity.transform = entity.transform.rotated(Vector3.FORWARD, rotation_vector.z * delta * rotation_speed)
	inner_cube.transform = inner_cube.transform.rotated(Vector3.UP, inner_rotation_vector.x * delta * rotation_speed)
	inner_cube.transform = inner_cube.transform.rotated(Vector3.LEFT, inner_rotation_vector.y * delta * rotation_speed)
	inner_cube.transform = inner_cube.transform.rotated(Vector3.FORWARD, inner_rotation_vector.z * delta * rotation_speed)

func set_answer(new_answer):
	answer = new_answer
	$NumberPlate/Viewport/Label.text = str(pow(new_answer, 4))

func _on_Area_area_entered(area):
	if area.has_method("damage"):
		area.damage()
		do_big_shake()
		play_big_explosion()
		do_death_animation_then_delete()

func destroy():
	do_little_shake()
	play_little_explosion()
	UI.score_points(4 * answer)
	do_death_animation_then_delete()

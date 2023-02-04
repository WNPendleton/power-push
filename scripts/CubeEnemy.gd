extends "res://scripts/Enemy.gd"

export var rotation_vector = Vector3(2,3,5)
export var base_rotation_speed = 1

var rotation_speed = base_rotation_speed

onready var entity = $Area

func _ready():
	randomize()
	rotation_speed = (randf() + 0.5) * base_rotation_speed
	if randf() > 0.5:
		rotation_speed *= -1

func _process(delta):
	entity.transform = entity.transform.rotated(Vector3.UP, rotation_vector.x * delta * rotation_speed)
	entity.transform = entity.transform.rotated(Vector3.LEFT, rotation_vector.y * delta * rotation_speed)
	entity.transform = entity.transform.rotated(Vector3.FORWARD, rotation_vector.z * delta * rotation_speed)

func set_answer(new_answer):
	answer = new_answer
	$NumberPlate/Viewport/Label.text = str(pow(new_answer, 3))

func _on_Area_area_entered(area):
	if area.has_method("damage"):
		area.damage()
		queue_free()

func destroy():
	UI.score_points(3 * answer)
	queue_free()

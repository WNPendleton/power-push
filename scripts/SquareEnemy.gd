extends "res://scripts/Enemy.gd"

export var rotation_vector = Vector3(0,0,1)
export var base_rotation_speed = 1.5

var rotation_speed = base_rotation_speed

onready var entity = $Area

func _ready():
	randomize()
	rotation_speed = (randf() + 0.5) * base_rotation_speed
	if randf() > 0.5:
		rotation_speed *= -1

func _process(delta):
	entity.transform = entity.transform.rotated(rotation_vector, rotation_speed * delta)

func set_answer(new_answer):
	answer = new_answer
	$NumberPlate/Viewport/Label.text = str(pow(new_answer, 2))

func _on_Area_area_entered(area):
	if area.has_method("damage"):
		area.damage()
		do_big_shake()
		play_big_explosion()
		do_death_animation_then_delete()

func destroy():
	do_little_shake()
	play_little_explosion()
	UI.score_points(2 * answer)
	do_death_animation_then_delete()

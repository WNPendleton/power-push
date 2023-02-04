extends "res://scripts/Enemy.gd"

export var rotation_vector = Vector3(0,0,1)
export var base_rotation_speed = 3

var rotation_speed = base_rotation_speed

onready var entity = $Area

func _ready():
	randomize()
	rotation_speed *= ((randf() - 0.5) * 2)

func _process(delta):
	entity.transform = entity.transform.rotated(rotation_vector, rotation_speed * delta)


func _on_Area_area_entered(area):
	if area.has_method("damage"):
		area.damage()

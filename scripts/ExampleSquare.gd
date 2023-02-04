extends Spatial

export var rotation_vector = Vector3(0,0,1)
export var rotation_speed = -1.5

onready var entity = $MeshInstance

func _process(delta):
	entity.transform = entity.transform.rotated(rotation_vector, rotation_speed * delta)

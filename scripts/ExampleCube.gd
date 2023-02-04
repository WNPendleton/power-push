extends Spatial

export var rotation_vector = Vector3(2,3,5)
export var rotation_speed = 1

onready var entity = $MeshInstance

func _process(delta):
	entity.transform = entity.transform.rotated(Vector3.UP, rotation_vector.x * delta * rotation_speed)
	entity.transform = entity.transform.rotated(Vector3.LEFT, rotation_vector.y * delta * rotation_speed)
	entity.transform = entity.transform.rotated(Vector3.FORWARD, rotation_vector.z * delta * rotation_speed)

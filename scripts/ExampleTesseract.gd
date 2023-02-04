extends Spatial

export var rotation_vector = Vector3(2,3,5)
export var inner_rotation_vector = Vector3(5,3,2)
export var rotation_speed = 0.75

onready var entity = $MeshInstance
onready var inner_cube = $MeshInstance2

func _process(delta):
	entity.transform = entity.transform.rotated(Vector3.UP, rotation_vector.x * delta * rotation_speed)
	entity.transform = entity.transform.rotated(Vector3.LEFT, rotation_vector.y * delta * rotation_speed)
	entity.transform = entity.transform.rotated(Vector3.FORWARD, rotation_vector.z * delta * rotation_speed)
	inner_cube.transform = inner_cube.transform.rotated(Vector3.UP, inner_rotation_vector.x * delta * rotation_speed)
	inner_cube.transform = inner_cube.transform.rotated(Vector3.LEFT, inner_rotation_vector.y * delta * rotation_speed)
	inner_cube.transform = inner_cube.transform.rotated(Vector3.FORWARD, inner_rotation_vector.z * delta * rotation_speed)

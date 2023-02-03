extends MeshInstance

export var rotationLimit = deg2rad(65)
export var rotationSpeed = 1

func _process(delta):
	rotate_z(rotationSpeed*delta)
	if abs(rotation.z) > rotationLimit:
		rotation.z = rotation.z / abs(rotation.z) * rotationLimit
		rotationSpeed *= -1

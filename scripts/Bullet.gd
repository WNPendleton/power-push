extends Spatial

var target
var id
var age = 0
var direction

export var rotationVector = Vector3(2, 3, 5)
export var rotationSpeed = 5
export var speed = 3
export var turning_speed = 0.04
export var max_age = 3

onready var model = $Model
onready var tween = $Tween
onready var cannon = get_tree().get_current_scene().get_node("World/Cannon")
onready var cannon_direction = cannon.get_node("BulletDestination")

func _ready():
	rotationVector = rotationVector.normalized()
	if direction == null:
		direction = cannon.global_transform.origin.direction_to(cannon_direction.global_transform.origin)

func _process(delta):
	age += delta
	if age > max_age:
		queue_free()
	
	model.transform = model.transform.rotated(Vector3.UP, rotationVector.x * delta * rotationSpeed)
	model.transform = model.transform.rotated(Vector3.LEFT, rotationVector.y * delta * rotationSpeed)
	model.transform = model.transform.rotated(Vector3.FORWARD, rotationVector.z * delta * rotationSpeed)
	
	if is_instance_valid(target):
		var target_direction = global_transform.origin.direction_to(target.global_transform.origin)
		direction = lerp(direction, target_direction, (turning_speed*pow(max(age, 1), 2)) * delta * 100).normalized()
		global_transform.origin = global_transform.origin + (direction * speed * delta)
	else:
		queue_free()
	
func setTarget(newTarget):
	target = newTarget
	id = newTarget.get_id()

func set_direction(new_direction):
	direction = new_direction

func _on_Bullet_area_entered(area):
	if area.get_parent().has_method("get_id"):
		if area.get_parent().get_id() == id:
			area.get_parent().destroy()
			queue_free()

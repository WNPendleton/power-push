extends Spatial

var target
var id
var age = 0

export var rotationVector = Vector3(2, 3, 5)
export var rotationSpeed = 5
export var travel_time = 2

onready var model = $Model
onready var tween = $Tween

onready var cannon = get_tree().get_current_scene().get_node("World/Cannon")

func _ready():
	rotationVector = rotationVector.normalized()

func _process(delta):
	model.transform = model.transform.rotated(Vector3.UP, rotationVector.x * delta * rotationSpeed)
	model.transform = model.transform.rotated(Vector3.LEFT, rotationVector.y * delta * rotationSpeed)
	model.transform = model.transform.rotated(Vector3.FORWARD, rotationVector.z * delta * rotationSpeed)
	
	if is_instance_valid(target):
		tween.interpolate_property(self, "translation", self.global_transform.origin, target.global_transform.origin, travel_time, Tween.TRANS_SINE, Tween.EASE_OUT_IN)
		tween.start()
	else:
		queue_free()
	
func setTarget(newTarget):
	target = newTarget
	id = newTarget.get_id()

func _on_Bullet_area_entered(area):
	if area.get_parent().has_method("get_id"):
		if area.get_parent().get_id() == id:
			area.get_parent().destroy()
			queue_free()

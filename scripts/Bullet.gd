extends Spatial

var target
var id
var age = 0

export var rotationVector = Vector3(2, 3, 5)
export var rotationSpeed = 5
export var travel_time = 2

onready var model = $Model
onready var tween = $Tween

onready var target1 = get_tree().get_current_scene().get_node("World/DefaultTarget1")
onready var target2 = get_tree().get_current_scene().get_node("World/DefaultTarget2")
onready var cannon = get_tree().get_current_scene().get_node("World/Cannon")

func _ready():
	rotationVector = rotationVector.normalized()

func _process(delta):
	model.transform = model.transform.rotated(Vector3.UP, rotationVector.x * delta * rotationSpeed)
	model.transform = model.transform.rotated(Vector3.LEFT, rotationVector.y * delta * rotationSpeed)
	model.transform = model.transform.rotated(Vector3.FORWARD, rotationVector.z * delta * rotationSpeed)
	
	tween.interpolate_property(self, "translation", self.global_transform.origin, target.global_transform.origin, travel_time, Tween.TRANS_SINE, Tween.EASE_OUT_IN)
	tween.start()
	
func setTarget(newTarget):
	target = newTarget
	id = newTarget.get_id()

func _on_Bullet_area_entered(area):
	if area.has_method("get_id"):
		if area.get_id() == id:
			area.destroy()
			queue_free()

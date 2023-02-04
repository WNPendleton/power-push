extends Spatial

onready var cannon = get_tree().get_current_scene().get_node("World/Cannon")
onready var tween = $Tween

var travel_time = 10
var answer
var id
var targeted = false

func start_tween():
	tween.interpolate_property(self, "global_transform:origin", self.global_transform.origin, cannon.global_transform.origin, travel_time, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()

func get_answer():
	return answer

func set_id(new_id):
	id = new_id

func get_id():
	return id

func target():
	targeted = true

func destroy():
	queue_free()

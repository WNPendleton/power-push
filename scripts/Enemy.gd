extends Spatial

onready var cannon = get_tree().get_current_scene().get_node("World/Cannon")
onready var tween = $Tween

var travel_time = 10

func _ready():
	tween.interpolate_property(self, "translation", self.global_transform.origin, cannon.global_transform.origin, travel_time, Tween.TRANS_SINE, 0)
	tween.start()

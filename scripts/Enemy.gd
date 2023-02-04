extends Spatial

onready var cannon = get_tree().get_current_scene().get_node("World/Cannon")
onready var camera = get_tree().get_current_scene().get_node("World/Camera")
onready var UI = get_tree().get_current_scene().get_node("UI")
onready var tween = $Tween
onready var target_indicator = $Target
onready var death_sprite = $Explosion

export var target_rotation_vector = Vector3(0,0,1)
export var target_rotation_speed = 1

var travel_time = 10
var answer
var id
var targeted = false

func _ready():
	target_indicator.hide()
	death_sprite.hide()

func _process(delta):
		target_indicator.transform = target_indicator.transform.rotated(target_rotation_vector, target_rotation_speed * delta)
		target_indicator.scale = lerp(target_indicator.scale, Vector3(0.2,0.2,0.2), 0.1)
		target_indicator.opacity = lerp(target_indicator.opacity, 1, 0.1)
		target_indicator.material_override.albedo_color.a = lerp(target_indicator.opacity, 1, 0.1)

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
	target_indicator.show()
	target_indicator.scale = Vector3(.7, .7, .7)
	target_indicator.opacity = 0
	target_indicator.material_override.albedo_color.a = 0

func do_big_shake():
	camera.do_camera_shake(0.16, 0.4)

func do_little_shake():
	camera.do_camera_shake(0.08, 0.2)

func do_death_animation_then_delete():
	death_sprite.show()
	$Area.hide()
	$Area/CollisionShape.disabled = true
	$NumberPlate.hide()
	target_indicator.hide()
	tween.stop_all()
	tween.interpolate_property(death_sprite, "scale", death_sprite.scale, Vector3(0,0,0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.interpolate_property(death_sprite, "opacity", death_sprite.opacity, 0, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	var timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", self, "queue_free")
	timer.set_wait_time(1)
	timer.start()

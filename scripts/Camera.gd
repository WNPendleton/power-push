extends Camera

var timer = 0
var shake_duration = 0
var shake_power = 0

var shake_multiplier = 1

export var base_position = Vector3(0,0,2)

func _ready():
	transform.origin = base_position

func _process(delta):
	timer += delta
	if timer < shake_duration:
		transform.origin = base_position + (Vector3(randf(), randf(), 0).normalized() * shake_power * (1 - (timer/shake_duration)))
	else:
		transform.origin = base_position

func do_camera_shake(power, duration):
	timer = 0
	shake_power = power
	shake_duration = duration

func cancel_shake():
	shake_duration = 0
	timer = 1
	shake_power = 0

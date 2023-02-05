extends Label

export var shift_speed = 0.2

var starting_color = Color.from_hsv(0,1,1,1)

func _ready():
	modulate = starting_color

func _process(delta):
	modulate = Color.from_hsv(modulate.h + (shift_speed * delta), 1, 1, 1)

extends Spatial

export var spawn_range = 5
export var initial_spawn_delay = 3
export var spawn_delay_decrease = 0.1
export var min_spawn_delay = 0.1
export var initial_difficulty = 1
export var difficulty_increase = 0.1
export var max_difficulty = 10

var spawn_timer = 0
var spawn_delay = initial_spawn_delay
var difficulty = initial_difficulty

onready var world = get_tree().get_current_scene().get_node("World")

func _process(delta):
	spawn_timer += delta
	if spawn_timer >= spawn_delay:
		do_spawn()
		spawn_timer -= spawn_delay
		decrease_spawn_delay()

func do_spawn():
	pass

func decrease_spawn_delay():
	spawn_delay -= spawn_delay_decrease
	if spawn_delay < min_spawn_delay:
		spawn_delay = min_spawn_delay

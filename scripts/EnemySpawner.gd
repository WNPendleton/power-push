extends Spatial

export var spawn_range = 5
export var initial_spawn_delay = 3
export var spawn_delay_decrease = 0.025
export var min_spawn_delay = 0.75
export var initial_difficulty = 1
export var difficulty_increase_every = 11
export var max_difficulty = 10

var spawn_timer = initial_spawn_delay
var spawn_delay = initial_spawn_delay
var difficulty = initial_difficulty
var enemies_spawned = 0

onready var world = get_tree().get_current_scene().get_node("World")
onready var square_prefab = preload("res://prefabs/SquareEnemy.tscn")
onready var cube_prefab = preload("res://prefabs/CubeEnemy.tscn")
onready var tesseract_prefab = preload("res://prefabs/TesseractEnemy.tscn")

func _ready():
	randomize()

func _process(delta):
	spawn_timer += delta
	if spawn_timer >= spawn_delay:
		do_spawn()
		spawn_timer -= spawn_delay
		decrease_spawn_delay()

func do_spawn():
	var newEnemy = create_enemy()
	
	var spawn_variance = randf() * spawn_range
	if randf() > 0.5:
		spawn_variance *= -1
	
	add_child(newEnemy)
	newEnemy.global_transform.origin = global_transform.origin + Vector3(spawn_variance, 0, 0)
	newEnemy.start_tween()
	
	enemies_spawned += 1
	if enemies_spawned % difficulty_increase_every == 0:
		difficulty += 1

func create_enemy():
	#If I designed this right, cubes start coming at level 2, tesseracts start coming at level 3, squares are the most common shape until level 8, and squares become the least common shape at level 10
	var newEnemy
	var enemy_roll = randf()
	var tesseract_limit = (1.0/max_difficulty) * floor(difficulty / 3)
	var cube_limit = tesseract_limit + ((1.0/max_difficulty) * floor(difficulty / 2))
	if enemy_roll < tesseract_limit:
		newEnemy = tesseract_prefab.instance()
		newEnemy.set_answer(randi()%(4*difficulty/max_difficulty)+1)
	elif enemy_roll < cube_limit:
		newEnemy = cube_prefab.instance()
		newEnemy.set_answer(randi()%(9*difficulty/max_difficulty)+1)
	else:
		newEnemy = square_prefab.instance()
		newEnemy.set_answer(randi()%(31*difficulty/max_difficulty)+1)
	return newEnemy

func decrease_spawn_delay():
	spawn_delay -= spawn_delay_decrease
	if spawn_delay < min_spawn_delay:
		spawn_delay = min_spawn_delay

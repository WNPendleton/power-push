extends Control

var points = 0

onready var lives = $HUD/HBoxContainer/Lives
onready var score = $HUD/HBoxContainer/Score
onready var camera = get_tree().get_current_scene().get_node("World/Camera")
onready var empty_life_texture = preload("res://sprites/empty_life.png")
onready var audio_bus_layout = preload("res://default_bus_layout.tres")

func _ready():
	$HUD.show()
	$GameOverScreen.hide()

func update_lives(newLives):
	var lives_count = 3
	for l in lives.get_children():
		if lives_count > newLives:
			l.texture = empty_life_texture
		lives_count -= 1

func score_points(amount):
	points += amount
	update_score(points)

func update_score(newScore):
	score.text = "%05d" % newScore

func do_game_over():
	$GameOverScreen/VBoxContainer/FinalScore.text = "Final Score: " + str(points)
	$HUD.hide()
	$GameOverScreen.show()
	camera.cancel_shake()
	var timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", camera, "cancel_shake")
	timer.connect("timeout", Engine, "set_time_scale", [0])
	timer.set_wait_time(0.2)
	timer.start()

func _on_Restart_pressed():
	Engine.time_scale = 1
	if get_tree().change_scene("res://scenes/Menu.tscn") != OK:
		print("Unexpected error changing to scene Menu")

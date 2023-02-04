extends Control

var points = 0

onready var lives = $HUD/HBoxContainer/Lives
onready var score = $HUD/HBoxContainer/Score
onready var camera = get_tree().get_current_scene().get_node("World/Camera")

func _ready():
	$HUD.show()
	$GameOverScreen.hide()

func update_lives(newLives):
	lives.text = "Lives: " + str(newLives)

func score_points(amount):
	points += amount
	update_score(points)

func update_score(newScore):
	score.text = "Score: " + str(newScore)

func do_game_over():
	$GameOverScreen/VBoxContainer/FinalScore.text = "Final Score: " + str(points)
	$HUD.hide()
	$GameOverScreen.show()
	camera.cancel_shake()
	Engine.time_scale = 0

func _on_Restart_pressed():
	Engine.time_scale = 1
	if get_tree().change_scene("res://scenes/Menu.tscn") != OK:
		print("Unexpected error changing to scene Menu")

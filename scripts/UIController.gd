extends Control

onready var lives = $HBoxContainer/Lives
onready var score = $HBoxContainer/Score

func update_lives(newLives):
	lives.text = "Lives: " + str(newLives)

func update_score(newScore):
	score.text = "Score: " + str(newScore)

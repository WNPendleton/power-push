extends Control

func _ready():
	$Instructions.hide()
	$Options.hide()
	$Credits.hide()
	$Main.show()

func _on_Start_pressed():
	if get_tree().change_scene("res://scenes/Game.tscn") != OK:
		print("Unexpected error changing to scene Game")

func _on_Instructions_pressed():
	$Main.hide()
	$Options.hide()
	$Credits.hide()
	$Instructions.show()

func _on_Options_pressed():
	$Main.hide()
	$Instructions.hide()
	$Credits.hide()
	$Options.show()

func _on_Credits_pressed():
	$Main.hide()
	$Instructions.hide()
	$Options.hide()
	$Credits.show()

func _on_Return_pressed():
	$Instructions.hide()
	$Options.hide()
	$Credits.hide()
	$Main.show()

extends AudioStreamPlayer

func _ready():
	pitch_scale = 0.75
	play()

func _on_Button_mouse_entered():
	pitch_scale = 1
	play()

func _on_Button_pressed():
	pitch_scale = 0.75
	play()

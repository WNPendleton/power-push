extends Area

export var rotationLimit = deg2rad(65)
export var rotationSpeed = 1
export var lives = 3

onready var UI = get_tree().get_current_scene().get_node("UI")
onready var muzzle_flash = $MuzzleFlash
onready var tween = $Tween

func _ready():
	muzzle_flash.hide()

func _process(delta):
	rotate_z(rotationSpeed*delta)
	if abs(rotation.z) > rotationLimit:
		rotation.z = rotation.z / abs(rotation.z) * rotationLimit
		rotationSpeed *= -1

func animate_muzzle_flash():
	muzzle_flash.show()
	tween.interpolate_property(muzzle_flash, "scale", Vector3(1,1,1), Vector3(0,0,0), 0.25, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.interpolate_property(muzzle_flash.get_node("Sprite3D"), "opacity", 1, 0, 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()

func damage():
	lives -= 1
	if lives < 0:
		do_game_over()
	else:
		UI.update_lives(lives)

func do_game_over():
	UI.do_game_over()

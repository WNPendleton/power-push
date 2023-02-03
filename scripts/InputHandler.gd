extends Label

var value = ""
var bulletCount = 0

onready var targetPrefab = preload("res://prefabs/Target.tscn")
onready var bulletPrefab = preload("res://prefabs/Bullet.tscn")
onready var bulletOrigin = get_tree().get_current_scene().get_node("World/Cannon/BulletOrigin")
onready var world = get_tree().get_current_scene().get_node("World")
onready var cannon = world.get_node("Cannon")
onready var bulletDestination = cannon.get_node("BulletDestination")

func _process(delta):
	if Input.is_action_just_pressed("input_0"):
		value += "0"
	if Input.is_action_just_pressed("input_1"):
		value += "1"
	if Input.is_action_just_pressed("input_2"):
		value += "2"
	if Input.is_action_just_pressed("input_3"):
		value += "3"
	if Input.is_action_just_pressed("input_4"):
		value += "4"
	if Input.is_action_just_pressed("input_5"):
		value += "5"
	if Input.is_action_just_pressed("input_6"):
		value += "6"
	if Input.is_action_just_pressed("input_7"):
		value += "7"
	if Input.is_action_just_pressed("input_8"):
		value += "8"
	if Input.is_action_just_pressed("input_9"):
		value += "9"
	if Input.is_action_just_pressed("input_delete"):
		value = value.left(value.length() - 1)
	if Input.is_action_just_pressed("input_send"):
		bulletCount += 1
		value = ""
		var newBullet = bulletPrefab.instance()
		newBullet.global_transform.origin = bulletOrigin.global_transform.origin
		var newTarget = targetPrefab.instance()
		newTarget.global_transform.origin = bulletDestination.global_transform.origin
		newTarget.set_id(bulletCount)
		world.add_child(newTarget)
		newBullet.setTarget(newTarget)
		world.add_child(newBullet)
	text = value

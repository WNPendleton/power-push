extends Area

var id

func set_id(newID):
	id = newID

func get_id():
	return id

func destroy():
	queue_free()

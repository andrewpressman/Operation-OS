extends Window

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func kill():
	queue_free()

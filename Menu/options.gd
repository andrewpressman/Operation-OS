extends Window

func _ready():
	pass

#close the window
func Kill():
	queue_free()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		GlobalVar.optionsVisible = false
		Kill()

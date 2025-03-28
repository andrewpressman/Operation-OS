extends Window

func _ready():
	pass

#close the window
func Kill():
	get_parent().ToggleOptions()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_parent().ToggleOptions()
		match SaveLoad.CurrentScreen:
			"WORK":
				pass
			"HOME":
				pass


func Menu():
	if SaveLoad.CurrentScreen == "WORK":
		GlobalVar.CurrentLevel -= 1
	SaveLoad.Save()
	get_tree().change_scene_to_file("res://Menu/MainMenu.tscn")

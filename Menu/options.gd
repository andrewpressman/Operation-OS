extends Window

func _ready():
	if SaveLoad.AutoClose:
		$Options/AutoClose.button_pressed = true
		$Options/AutoClose.text = "ON"

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

func ToggleAutoClose(toggle):
	if toggle:
		$Options/AutoClose.text = "ON"
		SaveLoad.AutoClose = true
	else:
		SaveLoad.AutoClose = false
		$Options/AutoClose.text = "OFF"
	SaveLoad.SaveOptions()

func Menu():
	if SaveLoad.CurrentScreen == "WORK":
		GlobalVar.CurrentLevel -= 1
	SaveLoad.Save()
	#Tiny delay to prevent error: _push_unhandled_input_internal: Condition "!is_inside_tree()" is true.
	await get_tree().create_timer(.001).timeout 
	get_tree().change_scene_to_file("res://Menu/MainMenu.tscn")

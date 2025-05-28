extends Window

func _ready():
	GameOP()
	if SaveLoad.AutoClose:
		$Options/GameOptions/AutoClose.button_pressed = true
		$Options/GameOptions/AutoClose.text = "ON"
	if SaveLoad.ExclusiveWindow:
		$Options/GameOptions/ExclusiveWindow.button_pressed = true
		$Options/GameOptions/ExclusiveWindow.text = "ON"
	
		
	$Options/VideoOptions/DisplayMode.select(SaveLoad.WindowMode)

#1152x
#5680y
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
		$Options/GameOptions/AutoClose.text = "ON"
		SaveLoad.AutoClose = true
	else:
		SaveLoad.AutoClose = false
		$Options/GameOptions/AutoClose.text = "OFF"

func ToggleWindowClose(toggle):
	if toggle:
		$Options/GameOptions/ExclusiveWindow.text = "ON"
		SaveLoad.ExclusiveWindow = true
	else:
		SaveLoad.ExclusiveWindow = false
		$Options/GameOptions/ExclusiveWindow.text = "OFF"

func Menu():
	if SaveLoad.CurrentScreen == "WORK":
		GlobalVar.CurrentLevel -= 1
	SaveLoad.Save()
	SaveLoad.SaveOptions()
	#Tiny delay to prevent error: _push_unhandled_input_internal: Condition "!is_inside_tree()" is true.
	await get_tree().create_timer(.001).timeout 
	get_tree().change_scene_to_file("res://Menu/MainMenu.tscn")

func OnDisplayModeSelected(index):
	print(str(index))
	SaveLoad.WindowMode = index
	match index:
		0: #FullScreen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		1: #Windowed
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func GameOP():
	$Options/GameOptions.visible = true
	$Options/SoundOptions.visible = false
	$Options/VideoOptions.visible = false

func SoundOP():
	$Options/GameOptions.visible = false
	$Options/SoundOptions.visible = true
	$Options/VideoOptions.visible = false

func VidOP():
	$Options/GameOptions.visible = false
	$Options/SoundOptions.visible = false
	$Options/VideoOptions.visible = true

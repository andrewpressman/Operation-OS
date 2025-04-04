extends Node2D

var Options = preload("res://Menu/Options.tscn")
var OptionsIst: Node = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SaveLoad.CurrentScreen = "HOME"
	$Finances/Pay.disabled = true
	if SaveLoad.PaidBills[0] == 0:
		$Taskbar/GoWork.disabled = true
		$Taskbar/GoWork.text = "Unpaid Bills"
	GlobalVar.optionsVisible = false
	$Finances.visible = false
	$Files.visible = false
	UpdateStats()
	SaveLoad.Save()
	
func EnableWork():
	$Taskbar/GoWork.text = "Go to work"
	$Taskbar/GoWork.disabled = false
	
func GoWork():
	SaveLoad.Save()
	GlobalVar.CurrentLevel += 1
	get_tree().change_scene_to_file("res://Work/WorkDesktop.tscn")

func FinancesButton():
	$Finances.visible = !$Finances.visible
	
func FilesButton():
	$Files.visible = !$Files.visible

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if !GlobalVar.optionsVisible:
			$PauseMenu.visible = true
			GlobalVar.optionsVisible = true
		else:
			$PauseMenu.visible = false
			GlobalVar.optionsVisible = false

func ToggleOptions():
	$PauseMenu.visible = false
	GlobalVar.optionsVisible = false	

func UpdateStats():
	var HungerStr = "Hunger: "
	var SecurityStr = "Security: "
	var Space = "     |     "
	if GlobalVar.Hunger < 15:
		HungerStr  += "Starving"
	elif GlobalVar.Hunger < 40:
		HungerStr += "Irritated"
	elif GlobalVar.Hunger < 80:
		HungerStr += "Fed"
	else:
		HungerStr += "Full"
	
	if GlobalVar.Security < 20:
		SecurityStr  += "High Risk"
	elif GlobalVar.Security < 30:
		SecurityStr += "Med Risk"
	elif GlobalVar.Security < 80:
		SecurityStr += "Low Risk"
	else:
		SecurityStr += "Safe"
	
	$Stats/Text.text = "Money: " + str(GlobalVar.Money) + Space + "Health: " + str(GlobalVar.Health) + Space + HungerStr + Space + SecurityStr + Space + "Debt: " + str(GlobalVar.Debt)

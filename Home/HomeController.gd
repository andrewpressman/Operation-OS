extends Node2D

var Options = preload("res://Menu/Options.tscn")
var OptionsIst: Node = null

var Emails = preload("res://Home/Emails.tscn")
var EmailsIst: Node = null

var Shop = (preload("res://Work/Shop.tscn"))
var ShopIst : Node = null

var CanWork : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SaveLoad.CurrentScreen = "HOME"
	$Finances/Pay.disabled = true
	if SaveLoad.PaidBills[0] == 0:
		$Taskbar/GoWork.disabled = true
		$Taskbar/GoWork.text = "Unpaid Bills"
		CanWork = false
	else:
		CanWork = true
	GlobalVar.optionsVisible = false
	
	$Finances.visible = false
	
	UpdateStats()
	SaveLoad.Save()
	
func EnableWork():
	$Taskbar/GoWork.text = "Go to work"
	CanWork = true
	$Taskbar/GoWork.disabled = false
	
func GoWork():
	SaveLoad.Save()
	GlobalVar.CurrentLevel += 1
	get_tree().change_scene_to_file("res://Work/WorkDesktop.tscn")

func FinancesButton():
	$Finances.visible = !$Finances.visible

func DisplayEmails():
	if EmailsIst && is_instance_valid(EmailsIst):
		EmailsIst.kill()
		EmailsIst = null
	else:
		var t1 = Emails.instantiate()
		EmailsIst = t1
		add_child(t1)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if !GlobalVar.optionsVisible:
			$PauseMenu.visible = true
			GlobalVar.optionsVisible = true
			$Taskbar/Finances.disabled = true
			$Taskbar/UnlockedFiles.disabled = true
			$Taskbar/GoWork.disabled = true
		else:
			ToggleOptions()

func ToggleOptions():
	$PauseMenu.visible = false
	GlobalVar.optionsVisible = false
	$Taskbar/Finances.disabled = false
	$Taskbar/UnlockedFiles.disabled = false
	if CanWork:
		$Taskbar/GoWork.disabled = false
	SaveLoad.SaveOptions()	

func DisplayShop():
	if ShopIst && is_instance_valid(ShopIst):
		ShopIst.kill()
		ShopIst = null
	else:
		var t7 = Shop.instantiate()
		ShopIst = t7
		add_child(t7)

func UpdateStats():
	var HungerStr = "Hunger: "
	var SecurityStr = "Security: "
	var HealthStr = "Health: "
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
	
	if GlobalVar.Health < 25:
		HealthStr  += "Poor"
	elif GlobalVar.Health < 50:
		HealthStr += "Okay"
	elif GlobalVar.Health < 80:
		HealthStr += "Good"
	else:
		HealthStr += "Perfect"
	
	$Stats/Text.text = "Money: " + str(GlobalVar.Money) + Space + HealthStr + Space + HungerStr + Space + SecurityStr + Space + "Debt: " + str(GlobalVar.Debt)

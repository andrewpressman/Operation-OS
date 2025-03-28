extends Node2D

@export var HealthChange : int
@export var HungerChange : int
@export var SecurityChange : int

var Options = preload("res://Menu/Options.tscn")
var OptionsIst: Node = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SaveLoad.CurrentScreen = "HOME"
	GlobalVar.optionsVisible = false
	$Finances.visible = false
	$Files.visible = false
	if !SaveLoad.PaidBills:
		$Taskbar/GoWork.disabled = true
		$Taskbar/GoWork.text = "Unpaid Bills"
	UpdateStatus()
	SaveLoad.Save()


func UpdateStatus():
	if GlobalVar.CurrentLevel > 0 && SaveLoad.OpenFromSave:
		GlobalVar.Health = GlobalVar.Health - (HealthChange * GlobalVar.CurrentLevel)
		GlobalVar.Hunger = GlobalVar.Hunger - (HungerChange * GlobalVar.CurrentLevel)
		GlobalVar.Security = GlobalVar.Security - (SecurityChange * GlobalVar.CurrentLevel)
	
	$Finances.UpdateStats()
	
func EnableWork():
	SaveLoad.PaidBills = true
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

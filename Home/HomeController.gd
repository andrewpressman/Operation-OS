extends Node2D

@export var HealthChange : int
@export var HungerChange : int
@export var SecurityChange : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Finances.visible = false
	$Files.visible = false
	$Taskbar/GoWork.disabled = true
	$Taskbar/GoWork.text = "Unpaid Bills"
	UpdateStatus()

func UpdateStatus():
	if GlobalVar.CurrentLevel > 0:
		GlobalVar.Health = GlobalVar.Health - (HealthChange * GlobalVar.CurrentLevel)
		GlobalVar.Hunger = GlobalVar.Hunger - (HungerChange * GlobalVar.CurrentLevel)
		GlobalVar.Security = GlobalVar.Security - (SecurityChange * GlobalVar.CurrentLevel)
	
func EnableWork():
	$Taskbar/GoWork.text = "Go to work"
	$Taskbar/GoWork.disabled = false
	
func GoWork():
	GlobalVar.CurrentLevel += 1
	get_tree().change_scene_to_file("res://Work/WorkDesktop.tscn")

func FinancesButton():
	$Finances.visible = !$Finances.visible
	
func FilesButton():
	$Files.visible = !$Files.visible

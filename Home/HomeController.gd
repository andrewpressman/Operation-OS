extends Node2D

@export var HealthChange : int
@export var HungerChange : int
@export var SecurityChange : int

var Options = preload("res://Menu/Options.tscn")
var OptionsIst: Node = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Finances.visible = false
	$Files.visible = false
	$Taskbar/GoWork.disabled = true
	$Taskbar/GoWork.text = "Unpaid Bills"
	UpdateStatus()
	SaveLoad.Save()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if GlobalVar.optionsVisible == false:
			DisplayOptions()
			GlobalVar.optionsVisible = true

func UpdateStatus():
	if GlobalVar.CurrentLevel > 0 && SaveLoad.OpenFromSave:
		GlobalVar.Health = GlobalVar.Health - (HealthChange * GlobalVar.CurrentLevel)
		GlobalVar.Hunger = GlobalVar.Hunger - (HungerChange * GlobalVar.CurrentLevel)
		GlobalVar.Security = GlobalVar.Security - (SecurityChange * GlobalVar.CurrentLevel)
	
	$Finances.UpdateStats()
	
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

func DisplayOptions():
	if OptionsIst && is_instance_valid(OptionsIst):
		OptionsIst.queue_free()
		OptionsIst = null
	else:
		var t5 = Options.instantiate()
		OptionsIst = t5
		add_child(t5)

extends Node2D

#Windows to be shown/removed
#var Options = #prelead options
var Numpad = preload("res://Tasks/Numpad.tscn")
var NumpadIst: Node = null

var FileManager = preload("res://Tasks/FileManager.tscn")
var FileManagerIst: Node = null

var Request = preload("res://Tasks/Request.tscn")
var RequestIst : Node = null

var Buttons = preload("res://Tasks/Buttons.tscn")
var ButtonsIst: Node = null

var CurrentScore : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalVar.Score = 0
	GlobalVar.Lives = 3
	_on_timer_timeout()

func _process(delta):
	if CurrentScore != GlobalVar.Score:
		UpdateScore()

func CheckLives():
	if !GlobalObj.ObjectiveComplete:
		GlobalVar.Lives -= 1
		
func _on_timer_timeout():
	CheckLives()
	#TODO: prevent repeat objectives???
	var Obj = randi() % 3 + 1
	match Obj:
		1:
			GlobalObj.GetRandomNumber()
		2:
			GlobalObj.GetRandomButton()
		3:
			print("ObjectiveTBD")
	
	SetObjective()
	UpdateScore()
	$Timer.start()
	
func SetObjective():
	var Objective : String = "Current Objective: "
	match GlobalVar.CurrentObj:
		1:
			Objective = Objective + "Input number " + str(GlobalObj.NumberpadNum)
		2:
			Objective = Objective + "Press button " + GlobalObj.ButtonText
		3:
			Objective = Objective + "Do nothing: "
	
	$Header/ObjectiveText.text = Objective

func UpdateScore():
	$Header/Score.text = "Current Score: " + str(GlobalVar.Score)
	
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		#Show Options Window
		print("escape")

func DisplayNumpad():
	if NumpadIst && is_instance_valid(NumpadIst):
		NumpadIst.queue_free()
		NumpadIst = null
	else:
		var t1 = Numpad.instantiate()
		NumpadIst = t1
		add_child(t1)

func DisplayButtons():
	if ButtonsIst && is_instance_valid(ButtonsIst):
		ButtonsIst.queue_free()
		ButtonsIst = null
	else:
		var t2 = Buttons.instantiate()
		ButtonsIst = t2
		add_child(t2)
		
func DisplayRequest():
	if RequestIst && is_instance_valid(RequestIst):
		RequestIst.queue_free()
		RequestIst = null
	else:
		var t3 = Request.instantiate()
		RequestIst = t3
		add_child(t3)
		
func DisplayFileManager():
	if FileManagerIst && is_instance_valid(FileManagerIst):
		FileManagerIst.queue_free()
		FileManagerIst = null
	else:
		var t4 = FileManager.instantiate()
		FileManagerIst = t4
		add_child(t4)

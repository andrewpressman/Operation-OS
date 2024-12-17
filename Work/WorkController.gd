extends Node2D

#Windows to be shown/removed
#var Options = #prelead options
var Numpad = preload("res://Tasks/Numpad.tscn")
var NumpadIst: Node = null

var FileManager = preload("res://Tasks/FileManager.tscn")
var FileManagerIst: Node = null

var Request = preload("res://Tasks/Memo.tscn")
var RequestIst : Node = null

var Buttons = preload("res://Tasks/Buttons.tscn")
var ButtonsIst: Node = null

var CurrentScore : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalVar.Score = 0
	GlobalVar.Lives = 3
	GlobalVar.Tasks = 10
	GetNewTask()

func _process(delta):
	if CurrentScore != GlobalVar.Score:
		UpdateScore()
		
	if GlobalObj.ObjectiveComplete == true:
		GlobalObj.ObjectiveComplete == false
		GlobalVar.Tasks = GlobalVar.Tasks - 1
		if GlobalVar.Score == 10: #TODO: Convert to Global Variable
			#TODO: convert Score to Money
			$TempWinner.visible = true
		elif GlobalVar.Lives == 0:
			#TODO: something?
			$TempLoser.visible = true
		else:
			GetNewTask()

#Go to home Desktop			
func GoHome():
	get_tree().change_scene_to_file("res://Home/HomeDesktop.tscn")

#Check lives
func CheckLives():
	if GlobalObj.TaskFailed:
		GlobalVar.Lives -= 1
		
#Gets a new objective
func GetNewTask():
	CheckLives()
	#TODO: prevent repeat objectives???
	var Obj = randi_range(1,4)
	match Obj:
		1:
			GlobalObj.GetRandomNumber()
		2:
			GlobalObj.GetRandomButton()
		3:
			GlobalObj.GetFileTransfer()
		4:
			GlobalObj.GetMemoReview()
	
	SetObjective()
	UpdateScore()

#Sets objective text
func SetObjective():
	var Objective : String = "Current Objective: "
	match GlobalVar.CurrentObj:
		1:
			Objective = Objective + "Input number " + str(GlobalObj.NumberpadNum)
		2:
			Objective = Objective + "Do button Panel"
		3:
			Objective = Objective + "Transfer Files from: " + GlobalObj.FileSourceText + " to " + GlobalObj.FileTargetText
		4:
			Objective = Objective + "Review Memo"
	
	Objective = Objective + "\n Tasks Left: " +  str(GlobalVar.Tasks)
	$Header/ObjectiveText.text = Objective

#Updates score
func UpdateScore():
	$Header/Score.text = "Current Score: " + str(GlobalVar.Score) + "\nLives: " + str(GlobalVar.Lives)
	
#Button to open settings windo
#TODO: add settings
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

#TODO: convert to control panel
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

func DisplayMessages():
	$MissingText.visible = !$MissingText.visible

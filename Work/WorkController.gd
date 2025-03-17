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

var Options = preload("res://Menu/Options.tscn")
var OptionsIst: Node = null

var CurrentScore : int = 0

var ShiftComplete : bool

# Called when the node enters the scene tree for the first time.
# Lives = amount of times the player can fail a task
# Tasks = Number of tasks the player is given per shift
func _ready():
	$GoHome.visible = false
	ShiftComplete = false
	#Set inital values
	match GlobalVar.CurrentLevel:
		1: 
			GlobalVar.Score = 0
			GlobalVar.Lives = 5
			GlobalVar.Tasks = 10
			#add value to make rewards dynamic
		2:
			GlobalVar.Lives = 10
			GlobalVar.Tasks = 15
		3:
			GlobalVar.Lives = 10
			GlobalVar.Tasks = 20
		#Continue down for more levels
	GetNewTask(false)
	
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if GlobalVar.optionsVisible == false:
			DisplayOptions()
			GlobalVar.optionsVisible = true

func _process(_delta):
	if CurrentScore != GlobalVar.Score:
		UpdateScore()

	if GlobalVar.TimerFail: #if timer runs out, deduct life and task thn reset objective
			print("TimerFail")
			GlobalVar.TimerFail = false
			GlobalVar.Tasks = GlobalVar.Tasks - 1
			GlobalVar.Lives = GlobalVar.Lives - 1
			GetNewTask(true)
		
	if GlobalObj.ObjectiveComplete: #if objectivs is completed, reset objective tracker and assign new task
		GlobalObj.ObjectiveComplete = false
		if !GlobalVar.BribeTaken: #if bribe was not taken deduct task
			GlobalVar.Tasks = GlobalVar.Tasks - 1
		
		#TEMP: show fail and victory
		if GlobalVar.Lives <= 0: #if player is out of lives... ???
			#TODO: something?
			pass
		elif GlobalVar.Tasks == 0: #if player has finished all tasks
			$GoHome.visible = true
			if ShiftComplete == false:
				ShiftComplete = true
				GlobalVar.CurrentObj = 5
				SetObjective()
		else: #if bribe was taken, randomize new bribe, reset task without deducting failures (its done elsewhere)
			GetBribe()
			GetNewTask(false)

func GetBribe():
	var rand = randi_range(1,5)
	if  rand == 1:
		$Bribe.visible = true
		$Bribe.reset()
	else:
		$Bribe.visible = false

func hideBribe():
	$Bribe.visible = false

#Go to home Desktop			
func GoHome():
	get_tree().change_scene_to_file("res://Home/HomeDesktop.tscn")

#Check lives
func CheckLives():
	if GlobalObj.TaskFailed:
		GlobalVar.Lives = GlobalVar.Lives - 1
	else:
		if GlobalVar.BribeTaken:
			GlobalVar.Money += GlobalVar.BribeValue
			GlobalVar.Lives = GlobalVar.Lives - 1
			GlobalVar.BribeTaken = false
		GlobalVar.Money += GlobalVar.Salary
		
#Gets a new objective
func GetNewTask(bribe : bool):
	if !bribe: 
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
	var Objective : String
	Objective = "Current Objective: "
	match GlobalVar.CurrentObj:
		1:
			Objective = Objective + "Input number " + str(GlobalObj.NumberpadNum)
		2:
			Objective = Objective + "Do button Panel"
		3:
			Objective = Objective + "Transfer Files from: " + GlobalObj.FileSourceText + " to " + GlobalObj.FileTargetText
		4:
			Objective = Objective + "Review Memo"
		5:
			Objective = Objective + "Shift Complete"
	
	if GlobalVar.BribeTaken && GlobalVar.CurrentObj != 5:
		Objective = Objective + " : BRIBE TASK"
	
	Objective = Objective + "\n Tasks Left: " +  str(GlobalVar.Tasks)
	
	$Header/ObjectiveText.text = Objective

#Updates score
func UpdateScore():
	$Header/Score.text = "Money: " + str(GlobalVar.Money) + "\nFailures: " + str(GlobalVar.Lives)

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
		
func DisplayOptions():
	if OptionsIst && is_instance_valid(OptionsIst):
		OptionsIst.queue_free()
		OptionsIst = null
	else:
		var t5 = Options.instantiate()
		OptionsIst = t5
		add_child(t5)

func DisplayMessages():
	$MissingText.visible = !$MissingText.visible

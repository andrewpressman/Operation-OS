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

var PopupAd = preload("res://Work/popupAd.tscn")
var PopupIst : Node = null

var CurrentScore : int = 0

var ShiftComplete : bool

var FirstTask : bool

# Called when the node enters the scene tree for the first time.
# Lives = amount of times the player can fail a task
# Tasks = Number of tasks the player is given per shift
func _ready():
	SaveLoad.CurrentScreen = "WORK"
	GlobalVar.optionsVisible = false
	FirstTask = true
	$GoHome.visible = false
	$ShiftComplete.visible = false
	ShiftComplete = false
	$Timer.StartTimer()
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
		_:
			GlobalVar.Lives = 10
			GlobalVar.Tasks = 25
		#Continue down for more levels
	GetNewTask(false)
	
func _process(_delta):
	if CurrentScore != GlobalVar.Score:
		UpdateScore()
			#TEMP: show fail and victory
	if GlobalVar.Lives <= 0: #if player is out of lives... ???
			#TODO: something?
			pass	
	
	if (GlobalVar.Tasks == 0 || GlobalVar.ForceShiftEnd) && !ShiftComplete: #if player has finished all tasks
		if GlobalVar.ForceShiftEnd:
			GlobalVar.Lives -= 1
			UpdateScore()
		$GoHome.visible = true
		if ShiftComplete == false:
			ShiftComplete = true
			GlobalVar.CurrentObj = 5
			SetObjective()
	
	if GlobalObj.ObjectiveComplete && !ShiftComplete: #if objectivs is completed or shift ends, reset objective tracker and assign new task
		GlobalObj.ObjectiveComplete = false
		GlobalVar.TimerLock = true
		if !GlobalVar.BribeTaken: #if bribe was not taken deduct task
			GlobalVar.Tasks = GlobalVar.Tasks - 1
			GetNewTask(true)

		else: #if bribe was taken, randomize new bribe, reset task without deducting failures (its done elsewhere)
			GetBribe()
			GetNewTask(false)

	if GlobalVar.TimerFail && !GlobalVar.TimerLock: #if timer runs out amd task is failed, deduct life and task thn reset objective
		GlobalVar.TimerFail = false
		GlobalVar.Tasks = GlobalVar.Tasks - 1
		GlobalVar.Lives = GlobalVar.Lives - 1
		GetNewTask(true)

@export var LowAdChance : int
@export var MedAdChance : int
@export var HighAdChance : int
var PopupChance : int
func CheckAd():
	if GlobalVar.Security <= 10:
		PopupChance = HighAdChance
	elif GlobalVar.Security <= 30:
		PopupChance = MedAdChance
	else:
		PopupChance = LowAdChance
		
	var ShowPopup = randi_range(1,PopupChance)
	if FirstTask:
		FirstTask = false
	elif ShowPopup == 1:
		DisplayPopup()

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
	GlobalVar.Health = GlobalVar.Health - (10 + GlobalVar.CurrentLevel)
	GlobalVar.Hunger = GlobalVar.Hunger - (10 + GlobalVar.CurrentLevel)
	GlobalVar.Security = GlobalVar.Security - (10 + GlobalVar.CurrentLevel)
	SaveLoad.PaidBills = false
	SaveLoad.Save()
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

var LastTask : int
#Gets a new objective
func GetNewTask(bribe : bool):
	CheckAd()
	if !bribe: 
		CheckLives()
	var Obj = randi_range(1,4)
	
	#Repeat Task prevention
	while Obj == LastTask:
		Obj = randi_range(1,4)
		
	match Obj:
		1:
			GlobalObj.GetRandomNumber()
		2:
			GlobalObj.GetRandomButton()
		3:
			GlobalObj.GetFileTransfer()
		4:
			GlobalObj.GetMemoReview()
	LastTask = Obj
	SetObjective()
	UpdateScore()

#Sets objective text
func SetObjective():
	var Objective : String
	Objective = "[b]Current Objective:  [/b]\n"
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
			$ShiftComplete.visible = true
	
	if GlobalVar.BribeTaken && GlobalVar.CurrentObj != 5:
		Objective = Objective + " : BRIBE TASK"
	
	$Header/ObjectiveText.text = Objective
	$Header/TasksRemaining.text = "[b]Tasks Left: [/b]\n" +  str(GlobalVar.Tasks)

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

func DisplayPopup():
	if PopupIst && is_instance_valid(PopupIst):
		PopupIst.queue_free()
		PopupIst = null
	else:
		var t6 = PopupAd.instantiate()
		PopupIst = t6
		add_child(t6)

func DisplayMessages():
	$MissingText.visible = !$MissingText.visible

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if !GlobalVar.optionsVisible:
			$PauseMenu.visible = true
			GlobalVar.optionsVisible = true
			PauseGame()
		else:
			ToggleOptions()

func PauseGame():
	$Timer/Timer.paused = true
	$Taskbar/NumberPad.disabled = true
	$Taskbar/FileManager.disabled = true
	$Taskbar/Messenger.disabled = true
	$Taskbar/Requests.disabled = true
	$Taskbar/Buttons.disabled = true
	$Bribe/Accept.disabled = true
	$Bribe/Decline.disabled = true
	

func ToggleOptions():
	$PauseMenu.visible = false
	GlobalVar.optionsVisible = false
	$Timer/Timer.paused = false
	$Taskbar/NumberPad.disabled = false
	$Taskbar/FileManager.disabled = false
	$Taskbar/Messenger.disabled = false
	$Taskbar/Requests.disabled = false
	$Taskbar/Buttons.disabled = false
	$Bribe/Accept.disabled = false
	$Bribe/Decline.disabled = false

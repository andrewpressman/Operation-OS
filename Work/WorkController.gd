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

var Shop = (preload("res://Work/Shop.tscn"))
var ShopIst : Node = null

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
	$Taskbar/Shop.disabled = false
	$ShiftComplete.visible = false
	$ShiftComplete/RichTextLabel.text = "[b][color=green]Shift Complete[/color][/b]\nReturn home"
	ShiftComplete = false
	$FileUnlocked.visible = false
	ShopVar.OpenShop()

	#Set inital values
	match GlobalVar.CurrentLevel:
		1: 
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
			GlobalVar.Tasks = 20 + GlobalVar.CurrentLevel
		#Continue down for more levels
	
	#Increase number of tasks based on shop level
	GlobalVar.Tasks += (ShopVar.ExtraTasks - 1)
	
	GetNewTask(false)

#DEBUG Function, remove before launch
func SkipTask():
	GlobalObj.ObjectiveComplete = true
	GlobalObj.TaskFailed = false
	
func _process(_delta):
		#TEMP: show fail and victory
	if GlobalVar.Lives == 0: #if player is out of lives... ???
		ShiftFailed()
		GlobalVar.Lives = -1
		GlobalVar.ForceShiftEnd = true
		#Give player fine
	
	if (GlobalVar.Tasks == 0 || GlobalVar.ForceShiftEnd) && !ShiftComplete: #if player has finished all tasks
		if GlobalVar.ForceShiftEnd:
			GlobalVar.Lives -= 1
			UpdateScore()
		$GoHome.visible = true
		$Taskbar/Shop.disabled = true
		if ShopIst && is_instance_valid(ShopIst):
			ShopIst.queue_free()
			ShopIst = null
		if ShiftComplete == false:
			ShiftComplete = true
			GlobalVar.CurrentObj = 5
			SetObjective()
	
	if GlobalObj.ObjectiveComplete && !ShiftComplete: #if objectivs is completed or shift ends, reset objective tracker and assign new task
		GlobalObj.ObjectiveComplete = false
		GlobalVar.TimerLock = true
		GetBribe()
		if !GlobalVar.BribeTaken: #if bribe was not taken deduct task
			GlobalVar.Tasks = GlobalVar.Tasks - 1
			GetNewTask(false)

		else: #if bribe was taken, randomize new bribe, reset task without deducting failures (its done elsewhere)
			GetNewTask(true)

	if GlobalVar.TimerFail && !GlobalVar.TimerLock: #if timer runs out amd task is failed, deduct life and task thn reset objective
		GlobalVar.TimerFail = false
		GlobalVar.Tasks = GlobalVar.Tasks - 1
		GlobalVar.Lives = GlobalVar.Lives - 1
		GetNewTask(true)

func ShiftFailed():
	GlobalVar.ShiftFails += 1
	$ShiftComplete/RichTextLabel.text = "[b][color=red]Shift Failed \n(" + str(GlobalVar.ShiftFails) +  " / 3) remaining [/color][/b]\nReturn home"

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
	ShowPopup = 0
	if FirstTask:
		FirstTask = false
	elif ShowPopup == 1:
		DisplayPopup()

func GetBribe():
	var rand = randi_range(1,7)
	if  rand == 1 && GlobalVar.CurrentLevel != 1:
		$Animations/BribeShow.ToggleBribe()
		$Bribe.reset()

func hideBribe():
	$Animations/BribeShow.ToggleBribe()

#Update stat figures and go to home Desktop			
func GoHome():
	GlobalVar.NewLevel = true
	#Health always goes down
	GlobalVar.Health = GlobalVar.Health - (20 + GlobalVar.CurrentLevel)
	
	#If hunger can go down, decreaes hunger, otherwise decrease health
	if GlobalVar.Hunger > (GlobalVar.Hunger - (20 + GlobalVar.CurrentLevel)):
		GlobalVar.Hunger = GlobalVar.Hunger - (20 + GlobalVar.CurrentLevel)
	else:
		GlobalVar.Health = GlobalVar.Health - (20 + GlobalVar.CurrentLevel)
	
	#if Debt is high, Decrease Security extra 
	GlobalVar.Security = GlobalVar.Security - (10 + GlobalVar.CurrentLevel)
	if GlobalVar.Debt > 1500:
		GlobalVar.Security = GlobalVar.Security - (25 + GlobalVar.CurrentLevel)
	if GlobalVar.Debt > 1000:
		GlobalVar.Security = GlobalVar.Security - (20 + GlobalVar.CurrentLevel)
	if GlobalVar.Debt > 500:
		GlobalVar.Security = GlobalVar.Security - (15 + GlobalVar.CurrentLevel)
		
	SaveLoad.PaidBills = [0,0,0,0,0]
	SaveLoad.Save()
	if GlobalVar.Health <= 0:
		GlobalVar.GameOverReason = 1
		get_tree().change_scene_to_file("res://Game Over/GameOver.tscn")
	elif GlobalVar.Security == 0:
		GlobalVar.GameOverReason = 2
		get_tree().change_scene_to_file("res://Game Over/GameOver.tscn")
	elif GlobalVar.ShiftFails == 3:
		GlobalVar.GameOverReason = 3
		get_tree().change_scene_to_file("res://Game Over/GameOver.tscn")
	else:
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
		
		#Shop Salary boost
		if ShopVar.SalaryLevel > 1:
			GlobalVar.Money += ShopVar.SalaryBoost * ShopVar.SalaryLevel

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
	#Obj = 2 #DEBUG CODE
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
			Objective = Objective + "Perform Control Panel operations"
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

#Updates money header
func UpdateScore():
	var message = "Money: " + str(GlobalVar.Money)
	if GlobalVar.Lives > 0:
		message += "\nFailures: " + str(GlobalVar.Lives)
	else:
		message += "\nFailures: Shift Failed"
	$Header/Score.text = message

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

func DisplayShop():
	if ShopIst && is_instance_valid(ShopIst):
		ShopIst.queue_free()
		ShopIst = null
	else:
		var t7 = Shop.instantiate()
		ShopIst = t7
		add_child(t7)

func DisplayMessages():
	pass

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		OpenOptions()
		
func OpenOptions():
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
	$Taskbar/Shop.disabled = true
	

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
	$Taskbar/Shop.disabled = false
	SaveLoad.SaveOptions()

func FileUnlocked():
	$FileUnlocked.visible = true
	await get_tree().create_timer(4).timeout
	$FileUnlocked.visible = false

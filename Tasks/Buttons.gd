extends Window
#768, 448

var PressedButton : int
var TargetWindow : int
var TargetButton : int
var TargetL1 : int
var TargetR1 : int
var TargetSwitch : int
var TargetSwitchValue : int

var NumTasks

# Called when the node enters the scene tree for the first time.
func _ready():
	NumTasks = GlobalVar.CurrentLevel + 1
	
	#reduce tasks by shop value
	NumTasks -= ShopVar.ButtonLevel - 1
	$Remaining/Text.text = "REMAINING: " + str(NumTasks)
	GetNewTask()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_parent().OpenOptions()

func GetNewTask():
	$Remaining/Text.text = "REMAINING: " + str(NumTasks)
	$Confirm.disabled = false
	SetTarget()
	SetDisplay()
	SetLevers(true)
	SetSwitchBoard(true)

#close the window
func Kill():
	queue_free()

var IsListening : bool
func _process(delta):
	if GlobalObj.TargetWindow == 4:
		IsListening = true
	if IsListening:
		if GlobalObj.TargetWindow != 4:
			IsListening = false
			_ready()

#Gets which button needs to be pressed
func SetTarget():
	if !GlobalObj.ObjectiveComplete:
		TargetWindow = GlobalObj.TargetWindow
		match TargetWindow:
			1:
				#Press 1 of 4 buttons
				TargetButton = GlobalObj.TargetButton
			2:
				#UpdateL1 and R1
				@warning_ignore("narrowing_conversion")
				TargetL1 = GlobalObj.TargetLeversL1
				@warning_ignore("narrowing_conversion")
				TargetR1 = GlobalObj.TargetLeversR1
			3:
				TargetSwitch = GlobalObj.TargetSwitch
				if GlobalObj.SwitchBoard[TargetSwitch] == 0: TargetSwitchValue = 1
				else: TargetSwitchValue = 0
					
	else:
		TargetWindow = 5

func SetDisplay():
	match GlobalObj.TargetWindow:
		1:
			if TargetButton == 1: 
				$Display/Label.text = "Press button: Red"
			if TargetButton == 2: 
				$Display/Label.text = "Press button: Blue"
			if TargetButton == 3: 
				$Display/Label.text = "Press button: Green"
			if TargetButton == 4: 
				$Display/Label.text = "Press button: Yellow"
		2:
			$Display/Label.text = "Set L1 to: " + str(int(GlobalObj.TargetLeversL1)) + " & Set R1 to: " + str(int(GlobalObj.TargetLeversR1))
		3:
			match GlobalObj.TargetSwitch:
				0: $Display/Label.text = "Flip switch: Option A"
				1: $Display/Label.text = "Flip switch: Option B"
				2: $Display/Label.text = "Flip switch: Option C"
				3: $Display/Label.text = "Flip switch: Option D"
				4: $Display/Label.text = "Flip switch: Option E"
				5: $Display/Label.text = "Flip switch: Option F"
		4:
			$Display/Label.text = "No assigned task"

func SetSwitchBoard(input : bool):
	if input:
		if GlobalObj.SwitchBoard[0] == 1: $Switches/Switch1.button_pressed = true
		else: $Switches/Switch1.button_pressed = false
		if GlobalObj.SwitchBoard[1] == 1: $Switches/Switch2.button_pressed = true 
		else: $Switches/Switch2.button_pressed = false 
		if GlobalObj.SwitchBoard[2] == 1: $Switches/Switch3.button_pressed = true 
		else: $Switches/Switch3.button_pressed = false 
		if GlobalObj.SwitchBoard[3] == 1: $Switches/Switch4.button_pressed = true 
		else: $Switches/Switch4.button_pressed = false 
		if GlobalObj.SwitchBoard[4] == 1: $Switches/Switch5.button_pressed = true 
		else: $Switches/Switch5.button_pressed = false 
		if GlobalObj.SwitchBoard[5] == 1: $Switches/Switch6.button_pressed = true 
		else: $Switches/Switch6.button_pressed = false
	else:
		if $Switches/Switch1.button_pressed: GlobalObj.SwitchBoard[0] = 1 
		else: GlobalObj.SwitchBoard[0] = 0 
		if $Switches/Switch2.button_pressed: GlobalObj.SwitchBoard[1] = 1 
		else: GlobalObj.SwitchBoard[1] = 0 
		if $Switches/Switch3.button_pressed: GlobalObj.SwitchBoard[2] = 1 
		else: GlobalObj.SwitchBoard[2] = 0 
		if $Switches/Switch4.button_pressed: GlobalObj.SwitchBoard[3] = 1 
		else: GlobalObj.SwitchBoard[3] = 0 
		if $Switches/Switch5.button_pressed: GlobalObj.SwitchBoard[4] = 1 
		else: GlobalObj.SwitchBoard[4] = 0 
		if $Switches/Switch6.button_pressed: GlobalObj.SwitchBoard[5] = 1 
		else: GlobalObj.SwitchBoard[5] = 0

func SetLevers(input : bool):
	if input:
		$Levers/Slider1/VSlider.set_value(GlobalObj.LeversL1 * 10)
		$Levers/Slider2/VSlider.set_value(GlobalObj.LeversR1 * 10)
	else:
		GlobalObj.LeversL1 = $Levers/Slider1/VSlider.value / 10
		GlobalObj.LeversR1 = $Levers/Slider2/VSlider.value / 10
#COLORS: 175
func Confirm():
	SetLevers(false)
	SetSwitchBoard(false)
	var case = GlobalObj.TargetWindow
	match case:
		2:
			#verify L1 and R1
			if TargetL1 == GlobalObj.TargetLeversL1 && TargetR1 == GlobalObj.TargetLeversR1:
				Verify(true)
			else:
				Verify(false)
		3:
			#verify Switchboard
			if GlobalObj.SwitchBoard[TargetSwitch] == TargetSwitchValue:
				Verify(true)
			else:
				Verify(false)

func Verify(con : bool):
	if con:
		$Display/Label.text = "SUCCESS"
		if GlobalVar.CurrentObj == 2 && !GlobalObj.ObjectiveComplete:
			if NumTasks > 1:
				NumTasks -= 1
				GlobalObj.GetRandomButton()
				GetNewTask()
			else:
				$Remaining/Text.text = "REMAINING: 0"
				GlobalObj.TaskFailed = false
				GlobalObj.TargetWindow = 4
				GlobalObj.ObjectiveComplete = true
				if SaveLoad.AutoClose:
					await get_tree().create_timer(2).timeout
					Kill()
				else:
					SetDisplay()
	else:
		GlobalObj.TaskFailed = true
		$Display/Label.text = "FAILURE"
		GlobalObj.ObjectiveComplete = true
		await get_tree().create_timer(1).timeout
		GlobalObj.TargetWindow = 4
		if SaveLoad.AutoClose:
			Kill()
		else:
			SetDisplay()
	

#Sends a success when correct button is complete, fail when incorrect
#TODO: shift to sequence?
func MatchButton():
	$Confirm.disabled = true
	if PressedButton == TargetButton:
		Verify(true)
	else:
		Verify(false)

func RedButton():
	PressedButton = 1
	MatchButton()
	
func BlueButton():
	PressedButton = 2
	MatchButton()
	
func GreenButton():
	PressedButton = 3
	MatchButton()

func YellowButton():
	PressedButton = 4
	MatchButton()

# 1 in 4 to pick which module
# if Buttons pick button
# if Levers, random 1 - 10 for L1 and R1
# if switches random 1 - 6 (keep values static)

# L1 1 - 10
# R1 1 - 10
# R G B Y buttons
# Switch 1 - 6

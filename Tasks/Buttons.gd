extends Window
#768, 448

var PressedButton : int
var TargetWindow : int
var TargetButton : int

# Called when the node enters the scene tree for the first time.
func _ready():
	SetTarget()
	SetLevers(true)
	SetSwitchBoard(true)

#close the window
func Kill():
	queue_free()

#Gets which button needs to be pressed
func SetTarget():
	if !GlobalObj.ObjectiveComplete:
		TargetWindow = GlobalObj.TargetButton
		match TargetWindow:
			1:
				#Press 1 of 4 buttons
				TargetButton = randi_range(1,4)
			2:
				#UpdateL1
				pass
			3:
				#UpdateR1
				pass
			4:
				pass
	else:
		TargetWindow = 5

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
		if $Switches/Switch1.button_pressed: GlobalObj.SwitchBoard[1] = 1 
		else: GlobalObj.SwitchBoard[0] = 0 
		if $Switches/Switch2.button_pressed: GlobalObj.SwitchBoard[2] = 1 
		else: GlobalObj.SwitchBoard[1] = 0 
		if $Switches/Switch3.button_pressed: GlobalObj.SwitchBoard[3] = 1 
		else: GlobalObj.SwitchBoard[2] = 0 
		if $Switches/Switch4.button_pressed: GlobalObj.SwitchBoard[4] = 1 
		else: GlobalObj.SwitchBoard[3] = 0 
		if $Switches/Switch5.button_pressed: GlobalObj.SwitchBoard[5] = 1 
		else: GlobalObj.SwitchBoard[4] = 0 
		if $Switches/Switch6.button_pressed: GlobalObj.SwitchBoard[6] = 1 
		else: GlobalObj.SwitchBoard[5] = 0

func SetLevers(input : bool):
	if input:
		$Levers/Slider1/VSlider.set_value(GlobalObj.LeversL1 * 10)
		$Levers/Slider2/VSlider.set_value(GlobalObj.LeversR1 * 10)
	else:
		GlobalObj.LeversL1 = $Levers/Slider1/VSlider.value / 10
		GlobalObj.LeversR1 = $Levers/Slider1/VSlider.value / 10

#Sends a success when correct button is complete, fail when incorrect
func MatchButton():
	if PressedButton == TargetButton:
		$Display/Label.text = "SUCESS"
		if GlobalVar.CurrentObj == 2 && !GlobalObj.ObjectiveComplete:
			GlobalObj.TaskFailed == false
			GlobalVar.Score += 1
		await get_tree().create_timer(2).timeout
		Kill()
	else:
		GlobalObj.TaskFailed == false
		$Display/Label.text = "FAILURE"
		await get_tree().create_timer(1).timeout
		Kill()
		
		
	GlobalObj.ObjectiveComplete = true

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

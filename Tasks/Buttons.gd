extends Window

var PressedButton : int
var TargetButton : int

# Called when the node enters the scene tree for the first time.
func _ready():
	$Red.modulate
	SetTarget()

#close the window
func Kill():
	queue_free()

#Gets which button needs to be pressed
func SetTarget():
	if !GlobalObj.ObjectiveComplete:
		TargetButton = GlobalObj.TargetButton
	else:
		TargetButton = 4

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

#175

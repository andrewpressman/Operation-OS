extends Window

var PressedButton : int
var TargetButton : int

# Called when the node enters the scene tree for the first time.
func _ready():
	$Red.modulate
	SetTarget()

func Kill():
	queue_free()

func SetTarget():
	if !GlobalObj.ObjectiveComplete:
		TargetButton = GlobalObj.TargetButton
	else:
		TargetButton = 4

func MatchButton():
	if PressedButton == TargetButton:
		$Display/Label.text = "SUCESS"
		if GlobalVar.CurrentObj == 2 && !GlobalObj.ObjectiveComplete:
			GlobalVar.Score += 1
		GlobalObj.ObjectiveComplete = true
		await get_tree().create_timer(2).timeout
		Kill()
	else:
		$Display/Label.text = "FAILURE"

func RedButton():
	PressedButton = 1
	MatchButton()
	
func BlueButton():
	PressedButton = 2
	MatchButton()
	
func GreenButton():
	PressedButton = 3
	MatchButton()

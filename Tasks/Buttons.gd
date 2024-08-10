extends Window

var PressedButton : int
var TargetButton : int

# Called when the node enters the scene tree for the first time.
func _ready():
	$Red.modulate

func Kill():
	queue_free()

func SetTarget(target : int):
	TargetButton = target

func MatchButton():
	if PressedButton == TargetButton:
		$Display/Label.text = "SUCESS"
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

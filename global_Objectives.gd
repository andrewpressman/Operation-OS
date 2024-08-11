extends Node

var NumberpadNum : int
var TargetButton : int
var ButtonText : String

var ObjectiveComplete : bool

func GetRandomNumber():
	GlobalVar.CurrentObj = 1
	ObjectiveComplete = false
	var random_number = randi() % 90000 + 10000
	NumberpadNum = random_number

func GetRandomButton():
	GlobalVar.CurrentObj = 2
	ObjectiveComplete = false
	var random_number = randi() % 3 + 1
	TargetButton = random_number
	match random_number:
		1:
			ButtonText = "Red"
		2:
			ButtonText = "Blue"
		3:
			ButtonText = "Green"

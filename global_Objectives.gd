extends Node

var NumberpadNum : int

var TargetButton : int
var ButtonText : String

var MemoVerdict: bool

var FilesTransfered : bool

var ObjectiveComplete : bool
var TaskFailed : bool

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

func GetFileTransfer():
	GlobalVar.CurrentObj = 3
	ObjectiveComplete = false

func GetMemoReview():
	var random_number = randi() % 2 + 1
	match random_number:
		1:
			MemoVerdict = true
		2:
			MemoVerdict = false
			
	GlobalVar.CurrentObj = 4
	ObjectiveComplete = false

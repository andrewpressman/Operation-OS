extends Node

var ObjectiveComplete : bool
var TaskFailed : bool

var NumberpadNum : int
func GetRandomNumber():
	GlobalVar.CurrentObj = 1
	ObjectiveComplete = false
	var random_number = randi() % 90000 + 10000
	NumberpadNum = random_number


var TargetWindow: int
var TargetButton : int
var LeversL1 : float
var LeversR1 : float
var TargetLeversL1 : float
var TargetLeversR1 : float
var TargetSwitch : int
var SwitchBoard = [0,0,0,0,0,0]
func GetRandomButton():
	GlobalVar.CurrentObj = 2
	ObjectiveComplete = false
	var random_number = randi_range(1,3)
	TargetWindow = random_number
	match TargetWindow:
		1:
			TargetButton = randi_range(1,4)
		2:
			var Lrand = randi_range(1,10)
			var Rrand = randi_range(1,10)
			TargetLeversL1 = Lrand
			TargetLeversR1 = Rrand
		3:
			TargetSwitch = randi_range(0,5)


var FileTransfered : bool
var FileSource : int
var FileSourceText : String
var FileTargetText : String
var FileTarget : int
func GetFileTransfer():
	GlobalVar.CurrentObj = 3
	ObjectiveComplete = false
	#TODO: make more complex
	FileSource = randi_range(1,3)
	FileTarget = randi_range(1,3)
	SetFileText()
	
#TEMP
func SetFileText():
	match FileSource:
		1:
			FileSourceText = "Corporate"
		2:
			FileSourceText = "Personal"
		3:
			FileSourceText = "Competetor"
	match FileTarget:
		1:
			FileTargetText = "Corporate"
		2:
			FileTargetText = "Personal"
		3:
			FileTargetText = "Competetor"

	

var MemoVerdict: bool
func GetMemoReview():
	var random_number = randi() % 2 + 1
	match random_number:
		1:
			MemoVerdict = true
		2:
			MemoVerdict = false
			
	GlobalVar.CurrentObj = 4
	ObjectiveComplete = false

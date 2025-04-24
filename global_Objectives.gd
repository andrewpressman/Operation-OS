extends Node

var ObjectiveComplete : bool
var TaskFailed : bool

var NumberpadNum : int
func GetRandomNumber():
	#Longer numbers for later levels
	GlobalVar.CurrentObj = 1
	ObjectiveComplete = false
	var numLength = GlobalVar.CurrentLevel + 2
	#Cap at 12 digits
	
	#Shop Value math (default to 4 digits if shop level is greater than num length)
	if numLength - ShopVar.NumpadLevel > 1:
		numLength -= ShopVar.NumpadLevel
	else:
		numLength = 3
	
	if numLength > 12:
		numLength = 12
			
	var minV = pow(10, numLength)
	var maxV = pow(10, numLength + 1) - 1
	var random_number = randi_range(minV, maxV)
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
	#More steps in later levels
	GlobalVar.CurrentObj = 2
	ObjectiveComplete = false
	TargetWindow = randi_range(1,3)
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

var SourceOptions = ["Blackmail", "Finances", "Memos", "Taxes", "Records"]
var TargetOptions = ["Supervisor", "Personal", "Executive", "Trash"]

var FileTransfered : bool
var FileSource : int
var FileSourceText : String
var FileTargetText : String
var FileTarget : int
func GetFileTransfer():
	GlobalVar.CurrentObj = 3
	ObjectiveComplete = false
	#TODO: make more complex
	FileSource = randi_range(1,SourceOptions.size())
	FileTarget = randi_range(1,TargetOptions.size())
	FileSourceText = SourceOptions.get(FileSource - 1)
	FileTargetText = TargetOptions.get(FileTarget - 1)
	

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

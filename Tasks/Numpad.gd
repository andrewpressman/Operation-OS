extends Window

var KeyNumber : String
var WholeNumber: String
var TypeLockout : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	TypeLockout = false
	SetKey()

func Clear():
	WholeNumber = ""	
	$Display/Label.text = WholeNumber

func Kill():
	queue_free()

func SetKey():
	if !GlobalObj.ObjectiveComplete:
		KeyNumber = str(GlobalObj.NumberpadNum)
	else:
		KeyNumber = "null"
	
func UpdateNumber():
	if WholeNumber.length() < 6:
		$Display/Label.text = WholeNumber
	#TODO: logic to check for secret codes if I want them
	
func Match(type : bool):
	TypeLockout = true
	if type:
		$Display/Label.text = "SUCESS"
		if GlobalVar.CurrentObj == 1 && !GlobalObj.ObjectiveComplete:
			GlobalVar.Score += 1
			GlobalObj.TaskFailed = false
		await get_tree().create_timer(1).timeout
		Kill()
	else:
		$Display/Label.text = "FAILURE"
		GlobalObj.TaskFailed = true
		await get_tree().create_timer(.5).timeout
	
	
	GlobalObj.ObjectiveComplete = true
	TypeLockout = false
	Clear()

func GoButton():
	var CompareString = WholeNumber.substr(0,5)
	if CompareString == KeyNumber:
		Match(true) #Add logic for success
	else:
		Match(false) #Add logic for failure

func ButtonZero():
	if !TypeLockout: 
		WholeNumber += "0"
		UpdateNumber()

func ButtonOne():
	if !TypeLockout: 
		WholeNumber += "1"
		UpdateNumber()

func ButtonTwo():
	if !TypeLockout: 
		WholeNumber += "2"
		UpdateNumber()

func ButtonThree():
	if !TypeLockout: 
		WholeNumber += "3"
		UpdateNumber()

func ButtonFour():
	if !TypeLockout: 
		WholeNumber += "4"
		UpdateNumber()

func ButtonFive():
	if !TypeLockout: 
		WholeNumber += "5"
		UpdateNumber()

func ButtonSix():
	if !TypeLockout: 
		WholeNumber += "6"
		UpdateNumber()

func ButtonSeven():
	if !TypeLockout: 
		WholeNumber += "7"
		UpdateNumber()

func ButtonEight():
	if !TypeLockout: 
		WholeNumber += "8"
		UpdateNumber()

func ButtonNine():
	if !TypeLockout: 
		WholeNumber += "9"
		UpdateNumber()

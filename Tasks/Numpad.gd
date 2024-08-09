extends Window

var KeyNumber : String
var WholeNumber: String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func Clear():
	WholeNumber = ""	
	$Display/Label.text = WholeNumber

func UpdateNumber():
	if WholeNumber.length() < 6:
		$Display/Label.text = WholeNumber
	#TODO: logic to check for secret codes if I want them

func Match():
	if WholeNumber == KeyNumber:
		return true
	else:
		return false

func GoButton():
	var CompareString = WholeNumber.substr(0,5)
	if CompareString == KeyNumber:
		Match() #Add logic for success
	else:
		Match() #Add logic for failure
		
	Clear()

func ButtonZero():
	WholeNumber += "0"
	UpdateNumber()

func ButtonOne():
	WholeNumber += "1"
	UpdateNumber()

func ButtonTwo():
	WholeNumber += "2"
	UpdateNumber()

func ButtonThree():
	WholeNumber += "3"
	UpdateNumber()

func ButtonFour():
	WholeNumber += "4"
	UpdateNumber()

func ButtonFive():
	WholeNumber += "5"
	UpdateNumber()

func ButtonSix():
	WholeNumber += "6"
	UpdateNumber()

func ButtonSeven():
	WholeNumber += "7"
	UpdateNumber()

func ButtonEight():
	WholeNumber += "8"
	UpdateNumber()

func ButtonNine():
	WholeNumber += "9"
	UpdateNumber()

extends Panel

var mins : int
var hour : int
var time : String
var amPm : bool #am = true, pm = false

func _ready() -> void:
	mins = 0
	hour = 9
	amPm = true
	GlobalVar.TimerFail = false
	SetTime()

func UpdateClock():
	if mins <= 40:
		mins += 10
	else:
		if !GlobalVar.TimerLock:
			GlobalVar.TimerFail = true
		else:
			GlobalVar.TimerLock = false
		mins = 0
		if hour < 12:
			hour += 1
		else:
			hour = 1
			amPm = false
	SetTime()
	#if hour < 5
	
func SetTime():
	if hour < 10:
		time = "0" + str(hour)
	else:
		time = str(hour)
	
	time = time + ":" 
	
	if mins == 0:
		time += "0" + str(mins)
	else:
		time += str(mins)
	
	if amPm:
		time += " am"
	else:
		time += " pm"
	
	$Label.text = time

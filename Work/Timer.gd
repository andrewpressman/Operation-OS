extends Panel

var mins : int
var hour : int
var time : String
var amPm : bool #am = true, pm = false

@export var MedSkipChance : int
@export var HighSkipChance : int

var SkipChance

func _ready() -> void:
	mins = 0
	hour = 9
	amPm = true
	GlobalVar.TimerFail = false
	GlobalVar.ForceShiftEnd = false
	SetTime()

func UpdateClock():
	TimeSkip()
	if mins <= 40:
		if SkipChance != -1:
			var skip = randi_range(1,SkipChance)
			if skip == 1:
				mins += 20
		mins += 10
	else:
		if !GlobalVar.TimerLock:
			GlobalVar.TimerFail = true
		else:
			GlobalVar.TimerLock = false
		mins = 0
		if hour <= 11:
			amPm = false
			hour += 1
		else:
			hour = 1

	if hour == 5 && !amPm:
		GlobalVar.ForceShiftEnd = true
		$Timer.stop()
	
	SetTime()

func TimeSkip():
	if GlobalVar.Hunger <= 10:
		SkipChance = HighSkipChance
	elif GlobalVar.Hunger <= 30:
		SkipChance = MedSkipChance
	else:
		SkipChance = -1

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

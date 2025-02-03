extends Panel

var CurrDate
var CurrTime
var StartTime = 0800

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CurrTime = StartTime
	updateDate()


func UpdateClock():
	pass
	
func updateDate():
	var Date : String
	match GlobalVar.CurrentLevel:
		0:
			Date = "4/27/2014"
		1:
			Date = "4/28/2014"
		2:
			Date = "4/29/2014"
		3:
			Date = "4/30/2014"
		4:
			Date = "5/1/2014"
		5:
			Date = "5/2/2014"
		6:
			Date = "5/3/2014"
			
	$Label.text = "Date: " + Date + "\nTime:  N/A"

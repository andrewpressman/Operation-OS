extends Panel

var CurrDate
var CurrTime
var StartTime = 0800

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CurrTime = StartTime
	updateDate()


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
		7:
			Date = "5/4/2014"
		8:
			Date = "5/5/2014"
		9:
			Date = "5/6/2014"
		10:
			Date = "5/7/2014"
		11:
			Date = "5/8/2014"
		12:
			Date = "5/9/2014"
		13:
			Date = "5/10/2014"
		14:
			Date = "5/11/2014"
		15:
			Date = "5/12/2014"
		
		
				
	$Label.text = "Date: " + Date

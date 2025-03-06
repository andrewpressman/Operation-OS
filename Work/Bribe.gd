extends Panel

var Value : int
var Risk : int
var Accept : bool

func _ready() -> void:
	SetBribeValue()
	SetBribeRisk()

func reset():
	SetBribeValue()
	SetBribeRisk()
	
func AcceptBribe():
	Accept = true
	GlobalVar.BribeTaken = true
	var SecurityHit = randi_range(0,Risk)
	GlobalVar.Security = GlobalVar.Security - SecurityHit
	get_parent().GetNewTask()
	
	
func DeclineBribe():
	Accept = false
	GlobalVar.BribeTaken = false
	get_parent().hideBribe()

func SetBribeValue():
	var low : int
	var high : int
	
	low = GlobalVar.Security
	high = GlobalVar.Security * 2
	
	Value = randi_range(low, high)
	GlobalVar.BribeValue = Value
	$Value.text = "Value: " + str(Value) 
	
func SetBribeRisk():
	var low : int
	var high : int
	
	low = Value
	high = Value * 2
	
	Risk = randi_range(low, high)
	@warning_ignore("integer_division")
	Risk = Risk / 10
	GlobalVar.BribeRisk = Value
	$Risk.text = "Risk: " + str(Risk) 

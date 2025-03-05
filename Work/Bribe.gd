extends Panel

var Value : int
var Risk : int
var Accept : bool

func _ready() -> void:
	SetBribeRisk()
	SetBribeValue()
	
func AcceptBribe():
	Accept = true
	print("accept")
	#alter task

func DeclineBribe():
	Accept = false
	print("decline")
	#Close window

func SetBribeValue():
	var low : int
	var high : int
	
	low = GlobalVar.Security
	high = GlobalVar.Security * 2
	
	Value = randi_range(low, high)
	$Value.text = "Value: " + str(Value) 
	
func SetBribeRisk():
	var low : int
	var high : int
	
	low = Value
	high = Value * 2
	
	Risk = randi_range(low, high)
	Risk = Risk / 10
	$Risk.text = "Risk: " + str(Risk) 

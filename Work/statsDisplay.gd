extends Panel

var Health : int
var Security : int
var Debt : int
var Hunger : int

func _ready() -> void:
	Health = GlobalVar.Health
	Security = GlobalVar.Security
	Debt = GlobalVar.Debt
	Hunger = GlobalVar.Hunger
	UpdateStats()
	

func UpdateStats():
	var HungerStr : String
	var SecurityStr : String
	var HealthStr : String
	if Hunger < 15:
		HungerStr  = "Starving"
	elif Hunger < 40:
		HungerStr = "Irritated"
	elif Hunger < 80:
		HungerStr = "Fed"
	else:
		HungerStr = "Full"
	
	if GlobalVar.Security < 20:
		SecurityStr  = "High Risk"
	elif GlobalVar.Security < 30:
		SecurityStr = "Med Risk"
	elif GlobalVar.Security < 80:
		SecurityStr = "Low Risk"
	else:
		SecurityStr = "Safe"
			
	if GlobalVar.Health < 25:
		HealthStr = "Poor"
	elif GlobalVar.Health < 50:
		HealthStr = "Okay"
	elif GlobalVar.Health < 80:
		HealthStr = "Good"
	else:
		HealthStr += "Perfect"
	
	$Label.text = "Health: \n" + HealthStr + "\n
						 Hunger: \n" + HungerStr + "\n
						 Security: \n" + SecurityStr + "\n
						 Debt: \n" + str(Debt)

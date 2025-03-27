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
	if Hunger < 10:
		HungerStr  = "Starving"
	elif Hunger < 30:
		HungerStr = "Irritated"
	elif Hunger < 60:
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
	
	$Label.text = "Health: \n" + str(Health) + "\n
						 Hunger: \n" + HungerStr + "\n
						 Security: \n" + SecurityStr + "\n
						 Debt: \n" + str(Debt)

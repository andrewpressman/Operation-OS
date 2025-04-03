extends Panel
@warning_ignore_start("integer_division")
var PaidRent : bool
var PaidFood : bool
var PaidMeds : bool
var PaidSecurity : bool
var PaidDebt : bool

var DebtAmout: int

var AmountDue : int
var CurrentDebt: int

var HomeScreen = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SetPrices()
	UpdateMoney()
	PaidRent = false
	PaidFood = false
	PaidMeds = false
	PaidSecurity = false
	PaidDebt = false
	$Bills/Food.disabled = true
	$Bills/Meds.disabled = true
	init()
	SetAvailable()
	
	if GlobalVar.CurrentLevel == 0:
		$Bills/Food.visible = false
		$Bills/FoodQuality.visible = false
		$Bills/Meds.visible = false
		$Bills/MedsQuality.visible = false
		$Bills/Security.visible = false
		$Bills/Security.disabled = true
		$Bills/Debt.visible = false
		PaidFood = true
		PaidMeds = true
		PaidSecurity = true
		if SaveLoad.PaidBills[0] == 1:
			$Bills/Rent.disabled = true
			$Bills/Rent.button_pressed = false

func SetAvailable(): #Other bills can only be paid when debt is 0 (Or some arbitray value)
	if GlobalVar.Debt == 0:
		if !PaidRent && !PaidFood && !PaidMeds && !PaidSecurity:
			$Bills/Debt.visible = false
			$Bills/Rent.disabled = false
			$Bills/Security.disabled = false
	else:
		$Bills/Debt.visible = true
		$Bills/Rent.disabled = true
		$Bills/Rent.button_pressed = false
		$Bills/Food.disabled = true
		$Bills/Food.button_pressed = false
		$Bills/Meds.disabled = true
		$Bills/Meds.button_pressed = false
		$Bills/Security.disabled = true
		$Bills/Security.button_pressed = false


func init():
	if SaveLoad.PaidBills[0] == 1:
		$Bills/Rent.text = "Rent: PAID"
		$Bills/Rent.disabled = true
		$Bills/Rent.button_pressed = false
		PaidRent = true
	else:
		$Bills/Rent.disabled = false
	
	if SaveLoad.PaidBills[1] == 1:	
		$Bills/Food.text = "Food: PAID"
		$Bills/Food.disabled = true
		$Bills/Food.button_pressed = false
		$Bills/FoodQuality.disabled = true
		PaidFood = true
	else:
		$Bills/FoodQuality.disabled = false
	
	if SaveLoad.PaidBills[2] == 1:
		$Bills/Meds.text = "Meds: PAID"
		$Bills/Meds.disabled = true
		$Bills/Meds.button_pressed = false
		$Bills/MedsQuality.disabled = true
		PaidMeds = true
	else:
		$Bills/MedsQuality.disabled = false

	if SaveLoad.PaidBills[3] == 1:
		$Bills/Security.text = "Security: PAID"
		$Bills/Security.disabled = true
		$Bills/Security.button_pressed = false
		PaidSecurity = true
	else:
		$Bills/Security.disabled = false
			
	if SaveLoad.PaidBills[4] == 1:
		$Bills/Debt.text = "Debt: PAID"
		$Bills/Debt.disabled = true
		$Bills/Debt.button_pressed = false
		PaidDebt = true
	else:
		$Bills/Debt.disabled = false
		
	if GlobalVar.Debt == 0:
		$Bills/Debt.visible = false
	else:
		$Bills/Debt.visible = true
	
#Update Money amount and check if work can be attended (Only Rent needs to be paid to go to work)
func UpdateMoney():
	$Money/Label.text = "Current Money: " + str(GlobalVar.Money)
	if PaidRent:
		get_parent().EnableWork()

func UpdateStats():
	var Hunger
	var Security
	if GlobalVar.Hunger < 10:
		Hunger  = "Starving"
	elif GlobalVar.Hunger < 30:
		Hunger = "Irritated"
	elif GlobalVar.Hunger < 60:
		Hunger = "Fed"
	else:
		Hunger = "Full"
	
	if GlobalVar.Security < 20:
		Security  = "High Risk"
	elif GlobalVar.Security < 30:
		Security = "Med Risk"
	elif GlobalVar.Security < 80:
		Security = "Low Risk"
	else:
		Security = "Safe"
	
	$Stats/Label.text = "Health: \n" + str(GlobalVar.Health) + "\n
						 Hunger: \n" + Hunger + "\n
						 Security: \n" + Security + "\n
						 Debt: \n" + str(GlobalVar.Debt)

func UpdateDue():
	if AmountDue == 0:
		$Pay.disabled = true
	else:
		$Pay.disabled = false
	$AmountDue.text = "Amount Due: $" + str(AmountDue)
	
func SetPrices():
	print(str(GlobalVar.CurrentLevel))
	print(str(GlobalVar.Hunger))
	print(str(GlobalVar.Security))
	if GlobalVar.CurrentLevel > 1:
		GlobalVar.RentPrice += GlobalVar.RentIncrease * GlobalVar.CurrentLevel
		GlobalVar.FoodPrice += GlobalVar.FoodIncrease * GlobalVar.CurrentLevel
		GlobalVar.MedsPrice += GlobalVar.MedsIncrease * GlobalVar.CurrentLevel
		GlobalVar.SecurityPrice += GlobalVar.SecurityIncrease * GlobalVar.CurrentLevel

	$Bills/Rent.text = "Rent: $" + str(GlobalVar.RentPrice) 
	$Bills/Security.text = "Security: $" + str(GlobalVar.SecurityPrice)
	
	if GlobalVar.Money > GlobalVar.Debt:
		$Bills/Debt.text = "Debt: $" + str(GlobalVar.Debt)
	else:
		$Bills/Debt.text = "Debt: $" + str(GlobalVar.Money)
	
@export var HealthChange : int
@export var HungerChange : int
@export var SecurityChange : int

func PayBills():
	if AmountDue <= GlobalVar.Money:
		GlobalVar.Money += -AmountDue
	else:
		GlobalVar.Money = 0
		CurrentDebt = (GlobalVar.Money - AmountDue) * -1 + GlobalVar.Debt
		GlobalVar.Debt = CurrentDebt
		if GlobalVar.Debt >= GlobalVar.MaxDebt:
			GlobalVar.GameOverReason = 4
			get_tree().change_scene_to_file("res://Game Over/GameOver.tscn")
	
	match $Bills/FoodQuality.get_selected_id():
			1:
				HungerChange = HungerChange / 2
			3:
				HungerChange = HungerChange * 2
				
	match $Bills/MedsQuality.get_selected_id():
			1:
				HealthChange = HealthChange / 2
			3:
				HealthChange = HealthChange * 2	
		
	if PaidRent: 
		$Bills/Rent.text = "Rent: PAID"
		$Bills/Rent.disabled = true
		$Bills/Rent.button_pressed = false
		SaveLoad.PaidBills[0] = 1
	
	if PaidFood:
		$Bills/Food.text = "Food: PAID"
		GlobalVar.Hunger = GlobalVar.Hunger + (HungerChange)
		$Bills/Food.disabled = true
		$Bills/Food.button_pressed = false
		SaveLoad.PaidBills[1] = 1
	
	if PaidMeds:
		$Bills/Meds.text = "Meds: PAID"
		GlobalVar.Health = GlobalVar.Health + (HealthChange)
		$Bills/Meds.disabled = true
		$Bills/Meds.button_pressed = false
		SaveLoad.PaidBills[2] = 1
		
	if PaidSecurity:
		$Bills/Security.text = "Security: PAID"
		GlobalVar.Security = GlobalVar.Security + (SecurityChange)
		$Bills/Security.disabled = true
		$Bills/Security.button_pressed = false
		SaveLoad.PaidBills[3] = 1
		
	if PaidDebt:
		$Bills/Debt.text = "Debt: PAID"
		$Bills/Debt.disabled = true
		$Bills/Debt.button_pressed = false
		GlobalVar.Debt = GlobalVar.Debt - DebtAmout
		SaveLoad.PaidBills[4] = 1
	
	if AmountDue == 0:
		$Pay.disabled = true
	else:
		$Pay.disabled = false	
	
	
	UpdateMoney()
	UpdateStats()
	AmountDue = 0
	UpdateDue()
	SetAvailable()

func ToggleRent():
	PaidRent = !PaidRent
	if PaidRent:
		AmountDue += GlobalVar.RentPrice
	else:
		AmountDue -= GlobalVar.RentPrice
	UpdateDue()

func foodSelected(input):
	$Bills/Food.disabled = false
	match input:
		1:
			$Bills/Food.text = "Food: $" + str(GlobalVar.FoodPrice / 2) 
		2:
			$Bills/Food.text = "Food: $" + str(GlobalVar.FoodPrice) 
		3:
			$Bills/Food.text = "Food: $" + str(GlobalVar.FoodPrice * 2) 
	
func MedsSelected(input):
	$Bills/Meds.disabled = false
	match input:
		1:
			$Bills/Meds.text = "Meds: $" + str(GlobalVar.MedsPrice / 2) 
		2:
			$Bills/Meds.text = "Meds: $" + str(GlobalVar.MedsPrice) 
		3:
			$Bills/Meds.text = "Meds: $" + str(GlobalVar.MedsPrice * 2) 

func ToggleFood():
	PaidFood = !PaidFood
	if PaidFood:
		$Bills/FoodQuality.disabled = true
		match $Bills/FoodQuality.get_selected_id():
			1:
				AmountDue += GlobalVar.FoodPrice / 2
			2:
				AmountDue += GlobalVar.FoodPrice
			3:
				AmountDue += GlobalVar.FoodPrice * 2

	else:
		$Bills/FoodQuality.disabled = false
		match $Bills/FoodQuality.get_selected_id():
			1:
				AmountDue -= GlobalVar.FoodPrice / 2
			2:
				AmountDue -= GlobalVar.FoodPrice
			3:
				AmountDue -= GlobalVar.FoodPrice * 2
	UpdateDue()

func ToggleMeds():
	PaidMeds = !PaidMeds
	if PaidMeds:
		$Bills/MedsQuality.disabled = true
		match $Bills/MedsQuality.get_selected_id():
			1:
				AmountDue += GlobalVar.MedsPrice / 2
			2:
				AmountDue += GlobalVar.MedsPrice
			3:
				AmountDue += GlobalVar.MedsPrice * 2
	else:
		$Bills/MedsQuality.disabled = false
		match $Bills/MedsQuality.get_selected_id():
			1:
				AmountDue -= GlobalVar.MedsPrice / 2
			2:
				AmountDue -= GlobalVar.MedsPrice
			3:
				AmountDue -= GlobalVar.MedsPrice * 2
	UpdateDue()

func ToggleSecurity():
	PaidSecurity = !PaidSecurity
	if PaidSecurity:
		AmountDue += GlobalVar.SecurityPrice
	else:
		AmountDue -= GlobalVar.SecurityPrice
	UpdateDue()

func ToggleDebt():
	PaidDebt = !PaidDebt
	if PaidDebt:
		if GlobalVar.Money > GlobalVar.Debt:
			DebtAmout = GlobalVar.Debt
			AmountDue += GlobalVar.Debt
		else:
			DebtAmout = GlobalVar.Money
			AmountDue += GlobalVar.Money
	else:
		if GlobalVar.Money > GlobalVar.Debt:
			AmountDue -= GlobalVar.Debt
		else:
			AmountDue -= GlobalVar.Money
	UpdateDue()

@warning_ignore_restore("integer_division")

extends Panel

var PaidRent: bool
var PaidFood : bool
var PaidMeds : bool
var PaidSecurity : bool
var PaidDebt : bool

var DebtAmout: int

var AmountDue : int
var CurrentDebt: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CurrentDebt = GlobalVar.Debt
	SetPrices()
	UpdateMoney()
	UpdateStats()
	PaidRent = false
	PaidFood = false
	PaidMeds = false
	PaidSecurity = false
	PaidDebt = false
	SetAvailable()
	AmountDue = 0

func SetAvailable():
	if GlobalVar.Debt == 0:
		$Pay.disabled = false
		$Bills/Rent.disabled = false
		$Bills/Food.disabled = false
		$Bills/Meds.disabled = false
		$Bills/Security.disabled = false
		$Bills/Debt.visible = false
	else:
		$Bills/Debt.visible = true
		$Bills/Rent.disabled = true
		$Bills/Food.disabled = true
		$Bills/Meds.disabled = true
		$Bills/Security.disabled = true

func UpdateMoney():
	$Money/Label.text = "Current Money: " + str(GlobalVar.Money)

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
	$AmountDue.text = "Amount Due: $" + str(AmountDue)
	
func SetPrices():
	if GlobalVar.CurrentLevel == 0:
		GlobalVar.Money = GlobalVar.StartMoney
		GlobalVar.RentPrice = GlobalVar.StartRentPrice
		GlobalVar.FoodPrice = GlobalVar.StartFoodPrice
		GlobalVar.MedsPrice = GlobalVar.StartMedsPrice
		GlobalVar.SecurityPrice = GlobalVar.StartSecurityPrice
		GlobalVar.Health = 100
		GlobalVar.Hunger = 100
		GlobalVar.Security = 100
	else:
		GlobalVar.RentPrice += GlobalVar.RentIncrease
		GlobalVar.FoodPrice += GlobalVar.FoodIncrease
		GlobalVar.MedsPrice += GlobalVar.MedsIncrease
		GlobalVar.SecurityPrice += GlobalVar.SecurityIncrease

	$Bills/Rent.text = "Rent: $" + str(GlobalVar.RentPrice) 
	$Bills/Food.text = "Food: $" + str(GlobalVar.FoodPrice) 
	$Bills/Meds.text = "Meds: $" + str(GlobalVar.MedsPrice)
	$Bills/Security.text = "Security: $" + str(GlobalVar.SecurityPrice)
	
	if GlobalVar.Money > GlobalVar.Debt:
		$Bills/Debt.text = "Debt: $" + str(GlobalVar.Debt)
	else:
		$Bills/Debt.text = "Debt: $" + str(GlobalVar.Money)
	

func PayBills():
	if AmountDue <= GlobalVar.Money:
		GlobalVar.Money += -AmountDue
	else:
		GlobalVar.Money = 0
		CurrentDebt = (GlobalVar.Money - AmountDue) * -1 + GlobalVar.Debt
		GlobalVar.Debt = CurrentDebt

	if PaidRent: 
		$Bills/Rent.text = "Rent: PAID"
		$Bills/Rent.disabled = true
		$Bills/Rent.button_pressed = false
	if PaidFood:
		$Bills/Food.text = "Food: PAID" 
		$Bills/Food.disabled = true
		$Bills/Food.button_pressed = false
	if PaidMeds:
		$Bills/Meds.text = "Meds: PAID"
		$Bills/Meds.disabled = true
		$Bills/Meds.button_pressed = false
	if PaidSecurity:
		$Bills/Security.text = "Security: PAID"
		$Bills/Security.disabled = true
		$Bills/Security.button_pressed = false
	if PaidDebt:
		$Bills/Debt.text = "Debt: PAID"
		$Bills/Debt.disabled = true
		$Bills/Debt.button_pressed = false
		GlobalVar.Debt = GlobalVar.Debt - DebtAmout
	
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
		AmountDue += -GlobalVar.RentPrice
	UpdateDue()

func ToggleFood():
	PaidFood = !PaidFood
	if PaidFood:
		AmountDue += GlobalVar.FoodPrice
	else:
		AmountDue += -GlobalVar.FoodPrice
	UpdateDue()

func ToggleMeds():
	PaidMeds = !PaidMeds
	if PaidMeds:
		AmountDue += GlobalVar.MedsPrice
	else:
		AmountDue += -GlobalVar.MedsPrice
	UpdateDue()

func ToggleSecurity():
	PaidSecurity = !PaidSecurity
	if PaidSecurity:
		AmountDue += GlobalVar.SecurityPrice
	else:
		AmountDue += -GlobalVar.SecurityPrice
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

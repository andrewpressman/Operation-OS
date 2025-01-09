extends Panel

var PaidRent: bool
var PaidFood : bool
var PaidMeds : bool
var PaidSecurity : bool

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
	$Pay.disabled = false
	$Bills/Rent.disabled = false
	$Bills/Food.disabled = false
	$Bills/Meds.disabled = false
	$Bills/Security.disabled = false
	AmountDue = 0

func UpdateMoney():
	$Money/Label.text = "Current Money: " + str(GlobalVar.Money)

func UpdateStats():
	$Stats/Label.text = "Health: XX\n
						 Hunger: XX\n
						 Security: XX\n
						 Debt: " + str(GlobalVar.Debt)

func UpdateDue():
	$AmountDue.text = "Amount Due: $" + str(AmountDue)
	
func SetPrices():
	if GlobalVar.CurrentLevel == 0:
		GlobalVar.Money = GlobalVar.StartMoney
		GlobalVar.RentPrice = GlobalVar.StartRentPrice
		GlobalVar.FoodPrice = GlobalVar.StartFoodPrice
		GlobalVar.MedsPrice = GlobalVar.StartMedsPrice
		GlobalVar.SecurityPrice = GlobalVar.StartSecurityPrice
		GlobalVar.Debt = GlobalVar.StartDebt
	else:
		GlobalVar.RentPrice += GlobalVar.RentIncrease
		GlobalVar.FoodPrice += GlobalVar.FoodIncrease
		GlobalVar.MedsPrice += GlobalVar.MedsIncrease
		GlobalVar.SecurityPrice += GlobalVar.SecurityIncrease

	$Bills/Rent.text = "Rent: $" + str(GlobalVar.RentPrice) 
	$Bills/Food.text = "Food: $" + str(GlobalVar.FoodPrice) 
	$Bills/Meds.text = "Meds: $" + str(GlobalVar.MedsPrice)
	$Bills/Security.text = "Security: $" + str(GlobalVar.SecurityPrice)

func PayBills():
	if AmountDue < GlobalVar.Money:
		GlobalVar.Money += -AmountDue
	#elif GlobalVar.Money > 0 :
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
	
	if AmountDue == 0:
		$Pay.disabled = true
	else:
		$Pay.disabled = false	
	
	UpdateMoney()
	UpdateStats()
	AmountDue = 0
	UpdateDue()

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

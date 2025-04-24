extends Window

@export var ShopButtons : ButtonGroup

var Price : int
var CanBuy : bool
var LastSelected : Button
var SelectedButton : Button
var ShopItem : int

func _ready() -> void:
	Price = 0
	CanBuy = false
	$Buy.disabled = true
	CheckOpen()
	SetLevels()
	var LastSelected = ShopButtons.get_pressed_button()

func kill():
	queue_free()

func _process(delta) -> void:
	SelectedButton = ShopButtons.get_pressed_button()
	if LastSelected != SelectedButton:
		LastSelected = SelectedButton
		if SelectedButton != null:
			ButtonSelected()
		else:
			$Descrption.text = ""
			CheckAfford(0)

func CheckOpen():
	if ShopVar.ButtonBought:
		$ShopGrid/ButtonUpgrade.disabled = true
	else:
		$ShopGrid/ButtonUpgrade.disabled = false
	if ShopVar.NumpadBought:
		$ShopGrid/NumpadUpgrade.disabled = true
	else:
		$ShopGrid/NumpadUpgrade.disabled = false
	if ShopVar.TransferBought || ShopVar.TransferLevel >= 4:
		$ShopGrid/TransferUpgrade.disabled = true
	else:
		$ShopGrid/TransferUpgrade.disabled = false
	if ShopVar.SalaryBought:
		$ShopGrid/SalaryUpgrade.disabled = true
	else:
		$ShopGrid/SalaryUpgrade.disabled = false
	if ShopVar.TasksBought:
		$ShopGrid/ExtraTasks.disabled = true
	else:
		$ShopGrid/ExtraTasks.disabled = false
	if !ShopVar.OverTimeBought:
		$ShopGrid/ExtendShift.disabled = false
	else:
		$ShopGrid/ExtendShift.disabled = true

func SetLevels():
	$ShopGrid/ButtonUpgrade.text = "Button Upgrade (" + str(ShopVar.ButtonLevel) + ")"
	$ShopGrid/NumpadUpgrade.text = "Smaller Number (" + str(ShopVar.NumpadLevel) + ")"
	$ShopGrid/TransferUpgrade.text = "Transfer Speed (" + str(ShopVar.TransferLevel) + ")"
	$ShopGrid/SalaryUpgrade.text = "Salary Upgrade (" + str(ShopVar.SalaryLevel) + ")"
	$ShopGrid/ExtraTasks.text = "Extra Tasks (" + str(ShopVar.ExtraTasks) + ")"
	if ShopVar.TransferLevel >= 4:
		$ShopGrid/TransferUpgrade.text = "Transfer Speed (MAX)"

	

func ButtonSelected():
	match SelectedButton.name:
		"ButtonUpgrade":
			$Descrption.text = "Reduce the number of inputs on buttons window"
			ShopItem = 1
			CheckAfford(ShopVar.ButtonPrice * ShopVar.ButtonLevel)
		"NumpadUpgrade":
			$Descrption.text = "Decrease length of number command"
			ShopItem = 2
			CheckAfford(ShopVar.NupadPrice * ShopVar.NumpadLevel)
		"TransferUpgrade":
			$Descrption.text = "Speed up file transfer"
			ShopItem = 3
			CheckAfford(ShopVar.TrasferPrice * ShopVar.TransferLevel)
		"SalaryUpgrade":
			$Descrption.text = "More money per task"
			ShopItem = 4
			CheckAfford(ShopVar.SalaryPrice * ShopVar.SalaryLevel)
		"ExtraTasks":
			$Descrption.text = "increase number of tasks per shift\nWill take effect next shift"
			ShopItem = 5
			CheckAfford(ShopVar.ExtraTaskPrice * ShopVar.ExtraTasks)
		"ExtendShift":
			$Descrption.text = "Extend length of work shift\nWill take effect next shift"
			ShopItem = 6
			CheckAfford(ShopVar.OvertimePrice)

func CheckAfford(Price : int):
	$Price.text = "Price: $" + str(Price)
	FinalPrice = Price
	if Price <= GlobalVar.Money || Price == 0:
		$Buy.disabled = false
	else:
		$Buy.disabled = true

var FinalPrice
func Pay():
	GlobalVar.Money -= FinalPrice
	get_parent().UpdateScore()
	match ShopItem:
		1:
			ShopVar.ButtonLevel += 1
			$ShopGrid/ButtonUpgrade.disabled = true
			$ShopGrid/ButtonUpgrade.button_pressed = false
		2:
			ShopVar.NumpadLevel += 1
			$ShopGrid/NumpadUpgrade.disabled = true
			$ShopGrid/NumpadUpgrade.button_pressed = false
		3:
			ShopVar.TransferLevel += 1
			$ShopGrid/TransferUpgrade.disabled = true
			$ShopGrid/TransferUpgrade.button_pressed = false
		4:
			ShopVar.SalaryLevel += 1
			$ShopGrid/SalaryUpgrade.disabled = true
			$ShopGrid/SalaryUpgrade.button_pressed = false
		5:
			ShopVar.ExtraTasks += 1
			$ShopGrid/ExtraTasks.disabled = true
			$ShopGrid/ExtraTasks.button_pressed = false
		6:
			ShopVar.OverTimeBought = true
			$ShopGrid/ExtendShift.disabled = true
			$ShopGrid/ExtendShift.button_pressed = false
	

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
	var LastSelected = ShopButtons.get_pressed_button()

func _process(delta) -> void:
	SelectedButton = ShopButtons.get_pressed_button()
	if LastSelected != SelectedButton:
		LastSelected = SelectedButton
		if SelectedButton != null:
			ButtonSelected()
		else:
			$Descrption.text = ""
			print("null")

func ButtonSelected():
	match SelectedButton.name:
		"ButtonUpgrade":
			$Descrption.text = "Reduce the number of inputs on buttons window"
			ShopItem = 1
			CheckAfford(GlobalVar.ButtonPrice)
			print("1")
		"NumpadUpgrade":
			$Descrption.text = "Decrease length of number command"
			ShopItem = 2
			CheckAfford(GlobalVar.NupadPrice)
			print("2")
		"TransferUpgrade":
			$Descrption.text = "Speed up file transfer"
			ShopItem = 3
			CheckAfford(GlobalVar.TrasferPrice)
			print("3")
		"SalaryUpgrade":
			$Descrption.text = "More money per task"
			ShopItem = 4
			CheckAfford(GlobalVar.SalaryPrice)
			print("4")
		"ExtraTasks":
			$Descrption.text = "increase number of tasks per shift"
			ShopItem = 5
			CheckAfford(GlobalVar.ExtraTaskPrice)
			print("5")
		"ExtendShift":
			$Descrption.text = "Extend length of work shift"
			ShopItem = 6
			CheckAfford(GlobalVar.OvertimePrice)
			print("6")

func CheckAfford(Price : int):
	if Price <= GlobalVar.Money:
		$Buy.disabled = false
	else:
		$Buy.disabled = true

func Pay():
	var SelectedButton = ShopButtons.get_pressed_button()
	if SelectedButton:
		print(SelectedButton.name)
	else:
		print("null")
	

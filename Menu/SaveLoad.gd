extends Node

var OpenFromSave : bool
var PaidBills

#Options menu settings
var AutoClose : bool
var WindowMode : int
var ExclusiveWindow : bool

var CurrentScreen

func Save():
	OpenFromSave = false
	var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var save_data = {
		"Money" : GlobalVar.Money,
		"Debt" : GlobalVar.Debt,
		"Health" : GlobalVar.Health,
		"Hunger" : GlobalVar.Hunger,
		"Security" : GlobalVar.Security,
		"Score" : GlobalVar.Score,
		"Salary" : GlobalVar.Salary,
		"CurrLevel" : GlobalVar.CurrentLevel,
		"MedsPrice" : GlobalVar.MedsPrice,
		"MedsRate" : GlobalVar.MedsIncrease,
		"FoodPrice" : GlobalVar.FoodPrice,
		"FoodRate" : GlobalVar.FoodIncrease,
		"RentPrice" : GlobalVar.RentPrice,
		"RentRate" : GlobalVar.RentIncrease,
		"SecurityPrice" : GlobalVar.SecurityPrice,
		"SecurityRate" : GlobalVar.SecurityIncrease,
		"PaidBills" : PaidBills,
		"ButtonLevel" : ShopVar.ButtonLevel,
		"NumpadLevel" : ShopVar.NumpadLevel,
		"TransferLevel" : ShopVar.TransferLevel,
		"SalaryLevel" : ShopVar.SalaryLevel,
		"ExtraTasks" : ShopVar.ExtraTasks,
		"OvertimeBought" : ShopVar.OverTimeBought
	}
	var json_str = JSON.stringify(save_data)
	save_game.store_line(json_str)

func LoadGame():
	OpenFromSave = true
	if not FileAccess.file_exists("user://savegame.save"):
		return #no save game detected.

	var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	var json_str = save_game.get_as_text()
	save_game.close()
	
	var save_data = JSON.parse_string(json_str)
	if "Money" in save_data:
		GlobalVar.Money = save_data["Money"]
	if "Debt" in save_data:
		GlobalVar.Debt = save_data["Debt"]
	if "Health" in save_data:
		GlobalVar.Health = save_data["Health"]
	if "Hunger" in save_data:
		GlobalVar.Hunger = save_data["Hunger"]
	if "Security" in save_data:
		GlobalVar.Security = save_data["Security"]
	if "Score" in save_data:
		GlobalVar.Score = save_data["Score"]
	if "Salary" in save_data:
		GlobalVar.Salary = save_data["Salary"]
	if "CurrLevel" in save_data:
		GlobalVar.CurrentLevel = save_data["CurrLevel"]
	if "MedsPrice" in save_data:
		GlobalVar.MedsPrice = save_data["MedsPrice"]
	if "MedsRate" in save_data:
		GlobalVar.MedsIncrease = save_data["MedsRate"]
	if "FoodPrice" in save_data:
		GlobalVar.FoodPrice = save_data["FoodPrice"]
	if "FoodRate" in save_data:
		GlobalVar.FoodIncrease = save_data["FoodRate"]
	if "RentPrice" in save_data:
		GlobalVar.RentPrice = save_data["RentPrice"]
	if "RentRate" in save_data:
		GlobalVar.RentIncrease = save_data["RentRate"]
	if "SecurityPrice" in save_data:
		GlobalVar.SecurityPrice = save_data["SecurityPrice"]
	if "SecurityRate" in save_data:
		GlobalVar.SecurityIncrease = save_data["SecurityRate"]
	if "PaidBills" in save_data:
		PaidBills = save_data["PaidBills"]
	if "ButtonLevel" in save_data:
		ShopVar.ButtonLevel = save_data["ButtonLevel"]
	if "NumpadLevel" in save_data:
		ShopVar.NumpadLevel = save_data["NumpadLevel"]
	if "TransferLevel" in save_data:
		ShopVar.TransferLevel = save_data["TransferLevel"]
	if "SalaryLevel" in save_data:
		ShopVar.SalaryLevel = save_data["SalaryLevel"]
	if "ExtraTasks"	 in save_data:
		ShopVar.ExtraTasks = save_data["ExtraTasks"]
	if "OvertimeBought" in save_data:
		ShopVar.OverTimeBought = save_data["OvertimeBought"]

func SaveOptions():
	var Settigns = FileAccess.open("user://Options.save", FileAccess.WRITE)
	var options = {
		"AutoClose" : AutoClose,
		"ExclusiveWindow" : ExclusiveWindow,
		"WindowMode" : WindowMode
	}
	var json_str = JSON.stringify(options)
	Settigns.store_line(json_str)

func LoadOptions():
	if not FileAccess.file_exists("user://Options.save"):
		return #no save game detected.

	var Settings = FileAccess.open("user://Options.save", FileAccess.READ)
	var json_str = Settings.get_as_text()
	Settings.close()
	
	var options = JSON.parse_string(json_str)
	if "AutoClose" in options:
		AutoClose = options["AutoClose"]
	if "ExclusiveWindow" in options:
		ExclusiveWindow = options["ExclusiveWindow"]
	if "WindowMode" in options:
		WindowMode = options["WindowMode"]
	
	match WindowMode:
		0: #FullScreen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		1: #Windowed
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		
func ClearDir(): #Only for DEBUG purpoeses.
	if not FileAccess.file_exists("user://savegame.save"):
		return #no save game detected.
	var file_to_remove = "user://savegame.save"
	OS.move_to_trash(ProjectSettings.globalize_path(file_to_remove))

func ClearOptDir():	
	if not FileAccess.file_exists("user://Options.savee"):
		return #no save game detected.
	var file_to_remove = "user://Options.savee"
	OS.move_to_trash(ProjectSettings.globalize_path(file_to_remove))
	

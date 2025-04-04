extends Node

var OpenFromSave : bool
var PaidBills
var AutoClose : bool

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
	if "FoodPrice" in save_data:
		GlobalVar.FoodPrice = save_data["FoodPrice"]
	if "RentPrice" in save_data:
		GlobalVar.RentPrice = save_data["RentPrice"]
	if "SecurityPrice" in save_data:
		GlobalVar.SecurityPrice = save_data["SecurityPrice"]
	if "PaidBills" in save_data:
		PaidBills = save_data["PaidBills"]	

func SaveOptions():
	var Settigns = FileAccess.open("user://Options.save", FileAccess.WRITE)
	var options = {
		"AutoClose" : AutoClose
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
	

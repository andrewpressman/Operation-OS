extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func NewGame():
	GlobalVar.CurrentLevel = 0
	GlobalVar.Money = GlobalVar.StartMoney
	GlobalVar.RentPrice = GlobalVar.StartRentPrice
	GlobalVar.FoodPrice = GlobalVar.StartFoodPrice
	GlobalVar.MedsPrice = GlobalVar.StartMedsPrice
	GlobalVar.SecurityPrice = GlobalVar.StartSecurityPrice
	GlobalVar.Health = 100
	GlobalVar.Hunger = 100
	GlobalVar.Security = 100
	get_tree().change_scene_to_file("res://Home/HomeDesktop.tscn")

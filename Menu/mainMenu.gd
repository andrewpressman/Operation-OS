extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

@export var SecurityIncrease : int
@export var MedsIncrease : int
@export var FoodIncrease : int
@export var RentIncrease : int

func NewGame():
	GlobalVar.CurrentLevel = 0
	GlobalVar.Money = GlobalVar.StartMoney
	
	GlobalVar.RentPrice = GlobalVar.StartRentPrice
	GlobalVar.RentIncrease = RentIncrease
	
	GlobalVar.FoodPrice = GlobalVar.StartFoodPrice
	GlobalVar.FoodIncrease = FoodIncrease
	
	GlobalVar.MedsPrice = GlobalVar.StartMedsPrice
	GlobalVar.MedsIncrease = MedsIncrease
	
	GlobalVar.SecurityPrice = GlobalVar.StartSecurityPrice
	GlobalVar.SecurityIncrease = SecurityIncrease
	
	GlobalVar.Health = 100
	GlobalVar.Hunger = 100
	GlobalVar.Security = 100
	get_tree().change_scene_to_file("res://Home/HomeDesktop.tscn")

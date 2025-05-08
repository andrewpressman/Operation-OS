extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SaveLoad.CurrentScreen = "MENU"
	SaveLoad.LoadGame()
	SaveLoad.LoadOptions()
	GlobalVar.LastAd = 0 #set ad value to 0
	
func NewGame():
	#TODO: consider asking if player wants to delete unlocked secerts? / Confirm reset to level 0
	GlobalVar.Reset()
	ShopVar.Reset()
	get_tree().change_scene_to_file("res://Menu/NewGameStart.tscn")

func Continue():
	GlobalVar.NewLevel = false
	get_tree().change_scene_to_file("res://Home/HomeDesktop.tscn")

func PurgeSave():
	SaveLoad.ClearDir()

func Quit():
	get_tree().quit()

extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SaveLoad.CurrentScreen = "MENU"
	SaveLoad.LoadGame()
	SaveLoad.LoadOptions()

func NewGame():
	#TODO: consider asking if player wants to delete unlocked secerts?
	GlobalVar.Reset()
	get_tree().change_scene_to_file("res://Home/HomeDesktop.tscn")

func Continue():
	get_tree().change_scene_to_file("res://Home/HomeDesktop.tscn")

func PurgeSave():
	SaveLoad.ClearDir()

func Quit():
	get_tree().quit()

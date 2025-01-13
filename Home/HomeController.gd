extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Finances.visible = false
	$Files.visible = false

func GoWork():
	GlobalVar.CurrentLevel += 1
	get_tree().change_scene_to_file("res://Work/WorkDesktop.tscn")

func FinancesButton():
	$Finances.visible = !$Finances.visible
	
func FilesButton():
	$Files.visible = !$Files.visible

extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Finances.visible = false
	$Files.visibile = false





func FinancesButton():
	$Finances.visible = !$Finances.visible
	
func FilesButton():
	$Files.visible = !$Files.visible

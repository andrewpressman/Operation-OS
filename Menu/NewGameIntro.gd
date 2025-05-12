extends Node2D

func _ready() -> void:
	$Intro.visible = true
	$Tutorial.visible = false

func Start():
	get_tree().change_scene_to_file("res://Home/HomeDesktop.tscn")

func Next():
	$Intro.visible = false
	$Tutorial.visible = true

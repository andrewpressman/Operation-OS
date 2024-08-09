extends Node2D

#Windows to be shown/removed
#var Options = #prelead options
var Numpad = preload("res://Tasks/Numpad.tscn")
var NumpadIst: Node = null
#var FileManager = preload("res://Tasks/Numpad.tscn")
#var Messenger = preload("res://Tasks/Numpad.tscn")
#var Memo = preload("res://Tasks/Numpad.tscn")
#var Buttons = preload("res://Tasks/Numpad.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		#Show Options Window
		print("escape")



func DisplayNumpad():
	if NumpadIst and is_instance_valid(NumpadIst):
		NumpadIst.queue_free()
		NumpadIst = null
	else:
		var p1 = Numpad.instantiate()
		NumpadIst = p1
		add_child(p1)

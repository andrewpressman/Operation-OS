extends Node2D

#Windows to be shown/removed
#var Options = #prelead options
var Numpad = preload("res://Tasks/Numpad.tscn")
var NumpadIst: Node = null
#var FileManager = preload("res://Tasks/Numpad.tscn")
#var Messenger = preload("res://Tasks/Numpad.tscn")
#var Memo = preload("res://Tasks/Numpad.tscn")
var Buttons = preload("res://Tasks/Buttons.tscn")
var ButtonsIst: Node = null


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
		var t1 = Numpad.instantiate()
		NumpadIst = t1
		add_child(t1)
		t1.SetKey("12345")

func DisplayButtons():
	if ButtonsIst and is_instance_valid(ButtonsIst):
		ButtonsIst.queue_free()
		ButtonsIst = null
	else:
		var t2 = Buttons.instantiate()
		ButtonsIst = t2
		add_child(t2)
		t2.SetTarget(1)

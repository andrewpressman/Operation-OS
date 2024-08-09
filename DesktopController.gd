extends Node2D

#Windows to be shown/removed
#var Options = #prelead options
var Numpad = preload("res://Tasks/Numpad.tscn")
#var FileManager = preload("res://Tasks/Numpad.tscn")
#var Messenger = preload("res://Tasks/Numpad.tscn")
#var Memo = preload("res://Tasks/Numpad.tscn")
#var Buttons = preload("res://Tasks/Numpad.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_key_pressesd(KEY_ESCAPE):
		#Show Options Window
		pass

func DisplayNumpad(view : bool):
	if view:
		add_child(Numpad.instantiate())
	else:
		pass
		

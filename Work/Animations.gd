extends AnimationPlayer

@export var Target : String

var StatsVisible: bool
var BribeVisible: bool

func _ready() -> void:
	if Target == "Stats":
		StatsVisible = false
	elif Target == "Bribe":
		BribeVisible = false

func _input(_event: InputEvent) -> void:
	if Target == "Stats":	
		if Input.is_key_pressed(KEY_Q) && StatsVisible == false:	
			play("Slide_in")
			StatsVisible = true
		elif !Input.is_key_pressed(KEY_Q) && StatsVisible == true:
			play("Slide_out")
			StatsVisible = false

func ToggleBribe():
	if Target == "Bribe":
		if !BribeVisible:
			play("BribeShow")
			BribeVisible = true
		else:
			play("BribeHide")
			BribeVisible = false

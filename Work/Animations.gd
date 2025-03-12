extends AnimationPlayer

var StatsVisible: bool

func _ready() -> void:
	StatsVisible = false
	play("RESET")
	

func _input(event: InputEvent) -> void:
		if Input.is_action_pressed("ui_tab") && StatsVisible == false:	
			play("Slide_in")
			StatsVisible = true
		elif Input.is_action_just_released("ui_tab") && StatsVisible == true:
			play("Slide_out")
			StatsVisible = false

extends Window

@export var Countdown : int

var close : bool

func _ready() -> void:
	$Timer.start()
	$Button.text = str(Countdown)
	$Button.disabled = true
	close = false
	
func Kill():
	queue_free()

func _on_timer_timeout() -> void:
	if Countdown != 0:
		Countdown -= 1
		$Button.text = str(Countdown)
		$Timer.start()
	else:
		$Button.text = "X"
		$Button.disabled = false
		close = true
		


func _on_button_pressed() -> void:
	if close:
		Kill()

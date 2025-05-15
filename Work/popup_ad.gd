extends Window

@export var Countdown : int

var close : bool
var NewAd : int

func _ready() -> void:
	$AnimationPlayer.play("WindowAppear")
	await get_tree().create_timer(.3).timeout
	$Timer.start()
	$Button.text = str(Countdown)
	$Button.disabled = true
	close = false
	PickNewAd()
	
func PickNewAd():
	NewAd = randi_range(1,5)
	if NewAd == GlobalVar.LastAd:
		PickNewAd()
	else:
		GlobalVar.LastAd = NewAd
		match NewAd:
			1:
				$Ad1.visible = true
			2:
				$Ad2.visible = true
			3:
				$Ad3.visible = true
			4:
				$Ad4.visible = true
			5:
				$Ad5.visible = true

func ClearAds():
	$Ad1.visible = false
	$Ad2.visible = false
	$Ad3.visible = false
	$Ad4.visible = false
	$Ad5.visible = false
	
func Kill():
	ClearAds()
	$AnimationPlayer.play("WindowHide")
	await get_tree().create_timer(.3).timeout
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

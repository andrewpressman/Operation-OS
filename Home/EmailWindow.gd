extends Window

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("window_appear")

func kill():
	$AnimationPlayer.play("window_hide")
	await get_tree().create_timer(.5).timeout
	queue_free()

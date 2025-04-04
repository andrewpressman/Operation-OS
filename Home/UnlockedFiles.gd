extends Panel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioFiles.visible = false
	$TextFiles.visible = false
	$Close.visible = false

func ShowAudioFiles():
	$AudioFiles.visible = true
	$TextFiles.visible = false
	$Close.visible = true
	
func ShowTextFiles():
	$AudioFiles.visible = false
	$TextFiles.visible = true
	$Close.visible = true
	
func Close():
	$AudioFiles.visible = false
	$TextFiles.visible = false
	$Close.visible = false

extends Panel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioFiles.visible = false
	$TextFiles.visible = false
	$Close.visible = false
	$NewsFiles.visible = false

func ShowAudioFiles():
	$NewsFiles.visible = false
	$AudioFiles.visible = true
	$TextFiles.visible = false
	$Close.visible = true
	
func ShowTextFiles():
	$NewsFiles.visible = false
	$AudioFiles.visible = false
	$TextFiles.visible = true
	$Close.visible = true
	
func ShowNews():
	$NewsFiles.visible = true
	$AudioFiles.visible = false
	$TextFiles.visible = false
	$Close.visible = true
	
func Close():
	$AudioFiles.visible = false
	$TextFiles.visible = false
	$NewsFiles.visible = false
	$Close.visible = false

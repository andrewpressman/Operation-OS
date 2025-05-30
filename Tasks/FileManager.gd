extends Window
#668x, 284y


var Next : bool

var TransferActive : bool
var Progress : int
var Complete : bool

var SourceDropdown : OptionButton
var TargetDropdown : OptionButton

var CurrSource : int
var CurrTarget : int

var CanTransfer : bool
var Pressed : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("WindowShow")
	Pressed = false
	SourceDropdown = $Source
	TargetDropdown = $Target
	CanTransfer = false
	$Message.visible = false
	ResetProgress()
	if GlobalVar.CurrentObj == 3:
		Next = true
	else:
		Next = false
	Complete = false
	
	#Redcude timer by shop value
	$Timer.wait_time = 1.5 - (.25  * (ShopVar.TransferLevel - 1))
	SetDropdown()

func Kill():
	getPosition()
	$AnimationPlayer.play("WindowHide")
	await get_tree().create_timer(.3).timeout
	queue_free()

func getPosition():
	var Hide = $AnimationPlayer.get_animation("WindowHide")
	Hide.track_set_key_value(1,0,Vector2i(position.x,position.y))

func _process(_delta):
	if TargetDropdown.get_selected_id() != 0 && SourceDropdown.get_selected_id() != 0:
		$Transfer.disabled = false
		CanTransfer = true
	else:
		$Transfer.disabled = true
		CanTransfer = false
		
	if TransferActive && Next && !Complete:
		Next = false
		match Progress:
			0: 
				TimeDelay()
			1:
				$Progress/One.visible = true
				$Timer.start()
			2:
				$Progress/Two.visible = true
				$Timer.start()
			3:
				$Progress/Three.visible = true
				$Timer.start()
			4:
				$Progress/Four.visible = true
				$Timer.start()
			5:
				$Progress/Five.visible = true
				$Timer.start()
			6:
				$Progress/Six.visible = true
				Complete = true
		Progress += 1

func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("ui_select") && CanTransfer && !Pressed:	
		Pressed = true
		ButtonDown()
	elif Input.is_action_just_released("ui_select") && CanTransfer:
		Pressed = false
		ButtonUp()
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_parent().OpenOptions()

func ButtonDown():
	CurrSource = SourceDropdown.get_selected_id()
	CurrTarget = TargetDropdown.get_selected_id()
	TransferActive = true
	
func ButtonUp():
	TransferActive = false
	if !Complete:
		ResetProgress()
	else:
		if GlobalObj.FileSource == CurrSource && GlobalObj.FileTarget == CurrTarget:
			GlobalObj.TaskFailed = false
			$Message.text = "Success"
		else:
			GlobalObj.TaskFailed = true
			$Message.text = "Failure"
		
		GlobalObj.ObjectiveComplete = true
		$Message.visible = true
		await get_tree().create_timer(1).timeout
		if SaveLoad.AutoClose:
			Kill()
		else:
			CanTransfer = false
			ResetProgress()
			TargetDropdown.select(0)
			SourceDropdown.select(0)
			$Message.visible = false
			
	
func ResetProgress():
	Progress = 0
	Complete = false
	$Progress/One.visible = false
	$Progress/Two.visible = false
	$Progress/Three.visible = false
	$Progress/Four.visible = false
	$Progress/Five.visible = false
	$Progress/Six.visible = false
	
func TimeDelay():
		Next = true
#Add items from array to dropdown
func SetDropdown():
	for item in GlobalObj.SourceOptions:
		SourceDropdown.add_item(item, GlobalObj.SourceOptions.find(item) + 1)
	
	for item in GlobalObj.TargetOptions:
		TargetDropdown.add_item(item, GlobalObj.TargetOptions.find(item) + 1)

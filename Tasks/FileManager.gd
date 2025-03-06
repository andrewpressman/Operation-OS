extends Window
#768x, 384y


var Next : bool

var TransferActive : bool
var Progress : int
var Complete : bool

var SourceDropdown : OptionButton
var TargetDropdown : OptionButton

var CurrSource : int
var CurrTarget : int

# Called when the node enters the scene tree for the first time.
func _ready():
	SourceDropdown = $Source
	TargetDropdown = $Target
	
	$Message.visible = false
	ResetProgress()
	if GlobalVar.CurrentObj == 3:
		Next = true
	else:
		Next = false
	Complete = false
	
	SetDropdown()

func Kill():
	queue_free()

func _process(_delta):
	if TargetDropdown.get_selected_id() != 0 && SourceDropdown.get_selected_id() != 0:
		$Transfer.disabled = false
	else:
		$Transfer.disabled = true
		
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
		Kill()
	
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

func SetDropdown():
	SourceDropdown.add_item("Corporate", 1)
	SourceDropdown.add_item("Personal", 2)
	SourceDropdown.add_item("Competetor", 3)
	TargetDropdown.add_item("Corporate", 1)
	TargetDropdown.add_item("Personal", 2)
	TargetDropdown.add_item("Competetor", 3)
	

extends Window

var Next : bool

var TransferActive : bool
var Progress : int
var Complete : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	ResetProgress()
	Next = true
	Complete = false

func _process(delta):
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
				$Timer.start()
			7:
				$Progress/Seven.visible = true
				$Timer.start()
			8:
				$Progress/Eight.visible = true
				$Timer.start()
			9:
				$Progress/Nine.visible = true
				$Timer.start()
			10:
				Complete = true
		Progress += 1
	
func ButtonDown():
	TransferActive = true
	
func ButtonUp():
	TransferActive = false
	if !Complete:
		ResetProgress()
	
func ResetProgress():
	Progress = 0
	Complete = false
	$Progress/One.visible = false
	$Progress/Two.visible = false
	$Progress/Three.visible = false
	$Progress/Four.visible = false
	$Progress/Five.visible = false
	$Progress/Six.visible = false
	$Progress/Seven.visible = false
	$Progress/Eight.visible = false
	$Progress/Nine.visible = false
	
func TimeDelay():
		Next = true

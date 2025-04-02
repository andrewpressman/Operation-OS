extends Window
#448x , 512y

var Step : int

var PressedButton: int

var Memos = []
#Template
#Company: \nSupervisor: \nDetails:

# Called when the node enters the scene tree for the first time.
func _ready():
	#load Memo's from text file
	var file = FileAccess.open("res://Assets/TextFiles/Memos.txt", FileAccess.READ)
	while !file.eof_reached():
		var line = file.get_line()
		line = line.replace("\\n","\n")
		Memos.append(line)
	file.close()

	ClearText()
	LockButtons()
	$Memo/Analyze.disabled = true
	$Memo/Suggestion.text = "Action: "
	if GlobalVar.CurrentObj == 4:
		Step = 0
		$Memo/Suggestion.text = "Action: Review"
		$Memo/Analyze.disabled = false
	else:
		Step = -1

func Kill():
	queue_free()

func Review():
	if Step == 0:
		ShowText()
		await get_tree().create_timer(.5).timeout
		UnlockButtons()
		if GlobalObj.MemoVerdict:
			$Memo/Suggestion.text = "Action: Approve"
		else:
			$Memo/Suggestion.text = "Action: Deny"

func Verify():
	if GlobalObj.MemoVerdict && PressedButton == 1:
		GlobalObj.TaskFailed = false
		$Memo/Suggestion.text = "Task Complete"
	elif !GlobalObj.MemoVerdict && PressedButton == 2:
		GlobalObj.TaskFailed = false
		$Memo/Suggestion.text = "Task Complete"
	else:
		$Memo/Suggestion.text = "Task Failed"
		GlobalObj.TaskFailed = true
	
	GlobalObj.ObjectiveComplete = true
	if SaveLoad.AutoClose:
		await get_tree().create_timer(.5).timeout
		Kill()

func UnlockButtons():
	$Panel/Approve.disabled = false
	$Panel/Deny.disabled = false
	
func LockButtons():	
	$Panel/Approve.disabled = true
	$Panel/Deny.disabled = true

func OnApprovePressed():
	PressedButton = 1
	Step += 1
	LockButtons()
	Verify()

func OnDenyPressed():
	PressedButton = 2
	Step += 1
	LockButtons()
	Verify()
	
func ShowText():
	var rand = randi_range(0, 3)
	$Memo/Body.text = Memos[rand]
	
func ClearText():
	$Memo/Body.text = "Company: N/A \nSupervisor: N/A\nRisk: N/A\nDetails:N/A"

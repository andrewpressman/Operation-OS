extends Window
#448x , 512y

var Step : int

var PressedButton: int

# Called when the node enters the scene tree for the first time.
func _ready():
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
	$Memo/Body.text = "Company: Blizzard \nSupervisor: Daddy Jeff Kaplan\nRisk: High\nDetails:Overwatch needs your help, send $10 via paypal to help stop Talon in their tracks"
	
func ClearText():
	$Memo/Body.text = "Company: N/A \nSupervisor: N/A\nRisk: N/A\nDetails:N/A"

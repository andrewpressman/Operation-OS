extends Node2D

var FinalHealth
var FinalHunger
var FinalSecurity
var FinalDebt

func _ready() -> void:
	GetStats()
	GlobalVar.Reset()
	SaveLoad.Save()

#1: health = 0 (dead)
#2: Security = 0 (locked  up)
#3: Too many failed shifts (fired)
#4: Too much debt: (repossed)
func SetFailReason():
	match GlobalVar.GameOverReason:
		1:
			$Reason.text = "You Died (Health hit 0)"
		2:
			$Reason.text = "You got caught (Security hit 0)"
		3:
			$Reason.text = "You got Fired (Too many failed shifts)"
		4:
			$Reason.text = "Your property got repossed (Too much debt)"
		_:
			$Reason.text = "You broke something..."

func GetStats():
	FinalHealth =   "[b]Health: [/b] " + str(GlobalVar.Health)
	FinalHunger =   "     [b]Hunger: [/b]" + str(GlobalVar.Hunger)
	FinalSecurity = "     [b]Security: [/b]" + str(GlobalVar.Security)
	FinalDebt =     "     [b]Debt: [/b]" + str(GlobalVar.Debt)
	$Stats.text = "[b]Stats: [/b]\n" +  FinalHealth + FinalHunger + FinalSecurity +  FinalDebt

func NewGame():
	get_tree().change_scene_to_file("res://Home/HomeDesktop.tscn")
	
func Quit():
	get_tree().quit()
	

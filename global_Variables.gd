extends Node

#Work variables
var Score : int
var CurrentObj : int

var Lives : int #numebr of times the player can fail a task
var Tasks : int #Number of tasks the player is given

#Home variables
var Money: int = 0
var Salary: int = 50
#TODO: add salary increase modifier

var RentPrice: int
var RentIncrease: int

var FoodPrice: int
var FoodIncrease : int

var MedsPrice: int
var MedsIncrease: int

var SecurityPrice : int
var SecurityIncrease: int

#Status trackers
var Debt : int #straight number
var Health : int # 0 -> 100
var Hunger : int # 0 - 100 -> starving, hungry, irritated, fed, full
var Security : int #0 - 100 -> Imminent Threat, In Danger, Low Risk, Safe

#Bribes tracker
var BribeValue : int
var BribeRisk : int
var BribeTaken : int

#ClockManagement
var TimerFail : bool 
var TimerLock : bool
var ForceShiftEnd : bool

#Intial Starting Values
var StartMoney : int = 500
var StartRentPrice : int = 100
var StartFoodPrice : int = 100
var StartMedsPrice : int = 100
var StartSecurityPrice : int = 100
var StartDebt : int = 0

#Current Level tracker
var CurrentLevel : int = 0

var optionsVisible = false

var ToggleAutoClose : bool
#TODO: implement

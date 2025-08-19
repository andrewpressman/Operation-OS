extends Node

#Work variables
var Score : int
var CurrentObj : int
var NewLevel : bool

var Lives : int #numebr of times the player can fail a task
var Tasks : int #Number of tasks the player is given
var ShiftFails : int #number of times the player can fail a shift
var LastAd : int #Makes sure the game doesnt repeat the same popup ad

#Home variables
var Money: int = 0
var Salary: int = 25
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
var MaxDebt : int = 5000

#Starting price increases
var StartRentRate : int = 50
var StartFoodRate : int = 50
var StartMedsRate : int = 50
var StartSecurityRate : int = 50

#StartingStats
var StartHealth : int = 100
var StartHunger : int = 100
var StartSecurity : int = 100

#Current Level tracker
var CurrentLevel : int = 0

var GameOverReason : int
#1: health = 0 (dead)
#2: Security = 0 (repossed)
#3: Too many failed shifts (fired)

var optionsVisible = false

#Email tracker
var AvailableEmails : int

func Reset():
	SaveLoad.PaidBills = [0,0,0,0,0]
	CurrentLevel = 0
	Money = StartMoney
	
	RentPrice = StartRentPrice
	RentIncrease = StartRentRate
	
	FoodPrice = StartFoodPrice
	FoodIncrease = StartFoodRate
	
	MedsPrice = StartMedsPrice
	MedsIncrease = StartMedsRate
	
	SecurityPrice = StartSecurityPrice
	SecurityIncrease = StartSecurityRate
	
	Health = StartHealth
	Hunger = StartHunger
	Security = StartSecurity
	Debt = StartDebt
	
	ShiftFails = 0
	
	AvailableEmails = 0

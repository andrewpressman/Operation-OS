extends Node

#Shop Values #TODO: balance
var ButtonPrice : int = 100
var NupadPrice : int = 100
var TrasferPrice : int = 100
var SalaryPrice : int = 100
var ExtraTaskPrice : int = 100
var OvertimePrice : int = 500

var ExtraTasks : int
var ButtonLevel : int
var NumpadLevel : int
var TransferLevel : int
var SalaryLevel : int
var MaxExtraTasks : int
var OverTimeBought : bool

var SalaryBoost : int = 25

var ButtonBought : bool
var NumpadBought : bool
var TransferBought : bool
var SalaryBought : bool
var TasksBought : bool

func OpenShop():
	ButtonBought = false
	NumpadBought = false
	TransferBought = false
	SalaryBought = false
	TasksBought = false

func Reset():
	ButtonLevel = 1
	NumpadLevel = 1
	TransferLevel = 1
	SalaryLevel = 1
	ExtraTasks = 1
	OverTimeBought = false

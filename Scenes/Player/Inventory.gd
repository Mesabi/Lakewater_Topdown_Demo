extends Node2D


# Declare member variables here. Examples:
export var health = 100
#figure out how to anchor inventory to camera. 
export var AmmoRevolver = 0
export var AmmoRevolverInWeapon = 0
export var hasRevolver = true

var inventoryOpen = false
var showSelf 

onready var chamberAmmo = $Revolver_Box/Revolver_Chamber_Label
onready var totalRevolverAmmo = $Revolver_Box/Revolver_Total_Ammo
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	doAmmoNumbers()
	openCloseInventory()

	pass



func openCloseInventory():
	#opens / closes inventory. 
	if(!inventoryOpen):
		self.hide()
	else:
		self.show()



func doAmmoNumbers():
	chamberAmmo.text = "Chamber " + String(AmmoRevolverInWeapon)
	totalRevolverAmmo.text ="Total " + String(AmmoRevolver)



func changeRevolverAmmo(amt):
	AmmoRevolver += amt

func firedRevolverOnTrue():
	if(AmmoRevolverInWeapon > 0):
		AmmoRevolverInWeapon -= 1
		return true
	else:
		return false
	
func reloadRevolver():
	if(AmmoRevolver == 0):
		print("out of bullets!!")
		return
	#fix me!!!, keeps loading chamber > 6
	elif(AmmoRevolver > 6):
		AmmoRevolver += AmmoRevolverInWeapon
		AmmoRevolverInWeapon = 0
		AmmoRevolver -= 6
		AmmoRevolverInWeapon = 6
	else:
		AmmoRevolver += AmmoRevolverInWeapon
		AmmoRevolverInWeapon = 0
		AmmoRevolverInWeapon = AmmoRevolver
		AmmoRevolver = 0
		

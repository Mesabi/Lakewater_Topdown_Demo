extends KinematicBody2D

export var speed = 160
var color_set = Color.white
var hover = false
var selected = false
var velocity = Vector2()
var myPlace
#not using these as of yet, remove if set differently later.
export var myStartX = 0
export var myStartY = 0
###
onready var mySprite = $Crew_Sprite
#
#
#
#onready var myIndicator = preload("res://Scenes/Scene/Move_Target_Indicator.tscn")
#onready var myTarget = preload("res://Scenes/Scene/Weapons/Cursor_Aim.tscn")
var moveToVisual
var aimHere
#
onready var myInventory = $Inventory

#onready var firePoint = $Fire_Point
#onready var testSpr = $Fire_Point/Test
var weaponRotation = 0
var weaponDrawn = false
var canFire = true
var hasBullets = true
var currentWeaponAmmo = 0
onready var weapon = get_node("Firepoint/Weapon")


#use this to set the inventory in the process function.
var pickUpRecieved = null
var pickUpAmt = 0


var testAMT = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#this needs to be declared here to set it properly as crew instantiates. Else, object gets set to 0,0
	myPlace = self.global_position

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#the order of these is probably important <.<
	getInput()
	movePlayer()
	interactFromRightClick()
	handleWeaponsActive()
	fireWeaponIfCan()
	test()
	handlePickUp()
	inventoryOpenClose()
	#test_rotation()
	pass


func test_rotation():

	#look_at(get_global_mouse_position())
	#.rotation = self.get_angle_to(get_global_mouse_position())
	pass

func test():
	#look_at()
	if Input.is_action_just_pressed("TEST"):
		print(myInventory.AmmoRevolver)


func handlePickUp():
	if(pickUpRecieved==null):
		return
	else:
		pickUpIn()
		pass



func pickUpIn():
	match(pickUpRecieved):
		"AmmoRevolver":
			myInventory.changeRevolverAmmo(pickUpAmt)
		_:
			pass
	clearPickUp()

func clearPickUp():
	pickUpRecieved = null
	pickUpAmt = 0

func handleAmmo():
	#handles the ammo functions of the weapons
	pass

func isThereAmmoForGun():
	currentWeaponAmmo = myInventory.AmmoRevolver
	if(currentWeaponAmmo > 0):
		hasBullets = true
	else:
		hasBullets = false



func handleWeaponsActive():
	#handles the weapon activation and deactivation.
	if(Input.is_action_pressed("Aim")):
		weaponDrawn = true
		#aimHere = myTarget.instance()
		#aimHere.position = get_global_mouse_position()
		#add_child(aimHere)
	elif(Input.is_action_just_released("Aim")):
		weaponDrawn = false
	#	aimHere.queue_free()
	if(!weaponDrawn):#hides weapon when not in use.
		weaponDrawn = false
		weapon.hideWeapon()
		return
	else:
		weapon.showWeapon()
		pass
		#holdWeapon()



func inventoryOpenClose():
	if(Input.is_action_just_released("open_inventory")):
		if(myInventory.inventoryOpen):
			myInventory.inventoryOpen = false
		else:
			myInventory.inventoryOpen = true


func fireWeaponIfCan():
	if(weaponDrawn):
		reloadWeapon()
		if(hasBullets):
			shootWeapon()

func shootWeapon():
	#this will need a switch statement with all weapons later.
	if(Input.is_action_just_pressed("left_click")):
		if(myInventory.AmmoRevolverInWeapon > 0):
			weapon.useRevolver()
			myInventory.firedRevolverOnTrue()
		else:
			print("click!!!!")
			
func reloadWeapon():
	if(Input.is_action_just_pressed("reload_weapon")):
		print("reloading")
		if(myInventory.AmmoRevolverInWeapon < 6):
			myInventory.reloadRevolver()
		else:
			print("no need")
	
	

func interactFromRightClick():
	#used to activate crew abilites, and make them use objects.
	if(selected && Input.is_action_just_pressed("right_click")):
		pass
	else:
		return
		

func movePlayer():
	velocity = move_and_slide(velocity)
	pass
	
	
func getInput():
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		 velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

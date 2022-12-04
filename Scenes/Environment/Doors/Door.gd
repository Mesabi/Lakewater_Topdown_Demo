extends Node2D


onready var closeSprite = $Closed_Door
onready var body = $Doorway_Block
onready var solid = $Doorway_Block/Doorway_Area_Shape
var open = false

var selected = false
var canToggle = false
var isBlocked = false


var openMenu = false



# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	if(canToggle):
		if Input.is_action_just_pressed("right_click"):
			if(!isBlocked):
				toggleDoor()

func closeDoor():
	open = false
	doDoor()
	
func openDoor():
	open = true
	doDoor()

func toggleDoor():
	#door set it to opened or closed. 

	if(open):
		open = false
	else:
		open = true
	doDoor()

func isOpen():
	return open

func doDoor():
	#sets the door to either open or closed. 
	body.shape_owner_set_disabled(0, open)
	closeSprite.visible = !open


func _on_Interact_mouse_entered():
	#door is hovered over.
	closeSprite.modulate = Color.yellow
	selected = true
	pass # Replace with function body.


func _on_Interact_mouse_exited():
	#door is no longer hovered over.
	closeSprite.modulate = Color.white
	openMenu = false
	selected = false
	pass # Replace with function body.


func _on_Interact_body_entered(body):
	#tells door that there is a crew standing within opening range. 
	if(body.is_in_group("Valid_Actor")):
		canToggle = true
	
	pass # Replace with function body.


func _on_Interact_body_exited(body):
	#tells door that there is not a crew standing within opening range. 
	if(body.is_in_group("Valid_Actor")):
		canToggle = false
	pass # Replace with function body.



func _on_Doorway_Area_body_entered(body):
	if(body.is_in_group("Valid_Actor")):#add more groups later
		isBlocked = true
	pass # Replace with function body.


func _on_Doorway_Area_body_exited(body):
	isBlocked = false
	pass # Replace with function body.

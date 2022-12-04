extends Area2D


# Declare member variables here. Examples:
onready var myHighlight = $Highlight_Sprite
onready var myClickArea = $Pick_Up_Select
onready var myValidArea = $Pick_Up_Valid
var mouseHover = false
var validToPickup = false
var playerBody
export var amt = 1
export var myTypeSelect = 0
var myTypeArray = ["AmmoRevolver","TEST"]



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#I hate using and statements in if statments. 
	if mouseHover:
		if validToPickup:
			if Input.is_action_just_pressed("right_click"):
				if(!playerBody == null):
					playerBody.pickUpRecieved =myTypeArray[myTypeSelect]
					playerBody.pickUpAmt = amt
	pass


func givePickup():
	playerBody.testAMT += 1


func clearSelf():
	pass
	
	


func _on_Pick_Up_mouse_entered():
	mouseHover = true
	myHighlight.modulate = Color.yellow
	pass # Replace with function body.


func _on_Pick_Up_mouse_exited():
	mouseHover = false
	myHighlight.modulate = Color.white
	pass # Replace with function body.


func _on_Radius_body_entered(body):
	if body.is_in_group("Player"):
		validToPickup = true
		playerBody = body
	pass # Replace with function body.


func _on_Radius_body_exited(body):
	if body.is_in_group("Player"):
		validToPickup = false
	pass # Replace with function body.

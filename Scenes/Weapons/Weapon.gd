extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

enum weaponType {Revolver, Shotgun}

var bullet = preload("res://Scenes/Weapons/Bullet.tscn")
onready var firepoint = get_node("Firepoint")
onready var sprite = get_node("Sprite")
export var bullet_speed = 1000
var isActive = true
# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.

func hideWeapon():
	sprite.hide()
	isActive = false

func showWeapon():
	sprite.show()
	isActive = true



func useRevolver():
	var bullet_instance = bullet.instance()
	bullet_instance.position = firepoint.get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
	get_tree().get_root().add_child(bullet_instance)
	#replace with a switch statement later.
	pass
	

func useShotgun():
	pass
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(get_global_mouse_position())

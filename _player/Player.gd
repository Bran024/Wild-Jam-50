extends KinematicBody2D


var max_health := 10
var health := 10

var speed := 200
var velocity := Vector2()

var mushrooms := 0
var moss := 0
var feathers := 0

var inventory_opened := false

var can_interact := false
var can_harvest := false
var harvest_target := "None"
var interaction_target := "None"

var components_gathered := false

func _ready():
	$Inventory.set_deferred("visible", false)

func _physics_process(_delta):
	if mushrooms + moss + feathers >= 14:
		components_gathered = true
	if can_interact or can_harvest:
		$Label.set_text("Press 'E'")
	if !can_interact and !can_harvest:
		$Label.set_text("")
		pass
	$Inventory.set_deferred("visible", inventory_opened)
	$Inventory/HBoxContainer/Feathers/Label.set_text(str(feathers))
	$Inventory/HBoxContainer/Moss/Label.set_text(str(moss))
	$Inventory/HBoxContainer/Mushrooms/Label.set_text(str(mushrooms))
	open_inventory()
	move_player()
	
	
	
func move_player():
	var input_vector := Vector2()
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vector.x = Input.get_action_raw_strength("right") - Input.get_action_strength("left")
	if input_vector != Vector2.ZERO:
		velocity = speed * input_vector
	else:
		velocity = Vector2.ZERO * speed

	velocity = velocity.normalized()
	
# warning-ignore:return_value_discarded
	move_and_slide(velocity * speed)

func open_inventory():
	if Input.is_action_just_pressed("inventory"):
		inventory_opened = !inventory_opened

extends KinematicBody2D

onready var spawn = get_parent().find_node("Spawn")

var speed := 200
var velocity := Vector2()

var mushrooms := 0
var moss := 0
var feathers := 0
var tinder := 0

var inventory_opened := false

var quest_stage := 0
var can_interact := false
var can_harvest := false
var harvest_target := "None"
var interaction_target := "None"

var components_gathered := false

func _ready():
	global_position = spawn.global_position
	$Inventory.set_deferred("visible", false)

func _physics_process(_delta):
	mushrooms = Global.mushrooms
	moss = Global.moss
	feathers = Global.feathers
	tinder = Global.tinder
	if mushrooms + moss + feathers >= 14:
		components_gathered = true
	if can_interact:
		$Label.set_text("Press 'E' to Interact")
	if can_harvest:
		$Label.set_text("Press 'E' to Harvest")
	if !can_interact and !can_harvest:
		$Label.set_text("")
		pass
	$Inventory.set_deferred("visible", inventory_opened)
	$Inventory/HBoxContainer/Feathers/Label.set_text(str(feathers))
	$Inventory/HBoxContainer/Moss/Label.set_text(str(moss))
	$Inventory/HBoxContainer/Mushrooms/Label.set_text(str(mushrooms))
	$Inventory/HBoxContainer/Tinder/Label.set_text(str(tinder))
	open_inventory()
	move_player()
	
	
	
func move_player():
	var input_vector := Vector2()
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	if input_vector != Vector2.ZERO:
		velocity = speed * input_vector
	else:
		velocity = Vector2.ZERO * speed

	velocity = velocity.normalized()
	if input_vector.y <= 0:
		$Sprite.frame = 1
	if input_vector.y >= 0:
		$Sprite.frame = 0
	
	move_and_slide(velocity * speed)

func open_inventory():
	var inventory_button = Input.get_action_strength("inventory")
	if inventory_button > 0:
		inventory_opened = true
	else:
		inventory_opened = false

#func clear_components():
#	mushrooms = 0
#	moss = 0
#	feathers = 0

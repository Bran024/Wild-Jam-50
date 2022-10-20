extends Area2D

onready var player = get_parent().find_node("Player")

const component_type := "Tinder"

export(int) var component_amount

var harvestable := false
var interactable := false

func _ready():
	if Global.tinder_collected:
		component_amount = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Global.quest_stage >= 3:
		interactable = true
	if harvestable and Input.is_action_just_pressed("interact"):
		Global.tinder += 1
		component_amount -= 1
	if component_amount <= 0:
		_on_InteractionZone_body_exited(player)
		queue_free()
	pass


func _on_InteractionZone_body_entered(body):
	if body == player and interactable:
		harvestable = true
		player.harvest_target = component_type
		player.can_harvest = true
	else:
		pass # Replace with function body.


func _on_InteractionZone_body_exited(body):
	if body == player:
		harvestable = false
		player.can_harvest = false
		player.harvest_target = "None"
	else:
		pass

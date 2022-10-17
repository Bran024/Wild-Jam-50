extends Area2D

onready var player = get_parent().find_node("Player")

const component_type = "Feather"

export(int) var component_amount

var harvestable = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if harvestable and Input.is_action_just_pressed("interact"):
		Global.feathers += 1
		component_amount -= 1
	if component_amount <= 0:
		_on_InteractionZone_body_exited(player)
		queue_free()
	pass


func _on_InteractionZone_body_entered(body):
	if body == player:
		harvestable = true
		player.harvest_target = component_type
		player.can_harvest = true
		print(player.can_harvest)
		print(player.harvest_target)
	else:
		pass # Replace with function body.


func _on_InteractionZone_body_exited(body):
	if body == player:
		harvestable = false
		player.can_harvest = false
		player.harvest_target = "None"
	else:
		pass

extends Area2D

export(String) var npc_name

onready var player = get_parent().find_node("Player")

var dialog_index := 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if player.interaction_target == npc_name and Input.is_action_just_pressed("interact"):
		start_dialog()
	else:
		pass

# dialogic function to begin dialog
func start_dialog():
	var dialog = Dialogic.start(npc_name + str(dialog_index)) # change input of function to change dialogic
	dialog.pause_mode = PAUSE_MODE_PROCESS
	get_parent().add_child(dialog)
	dialog.connect("timeline_end", self, "end_dialog")
	dialog.connect("dialogic_signal", self, "dialogic_signal_event")
	get_tree().paused = true

# dialogic function to end dialog
func end_dialog(data): # data must be here or function does not work. either a bug or something i dont understand
	get_tree().paused = false


func _on_InteractionZone_body_entered(body):
	if body == player:
		player.interaction_target = npc_name
		player.can_interact = true
	else:
		pass


func _on_InteractionZone_body_exited(body):
	if body == player:
		player.interaction_target = "None"
		player.can_interact = false
	else:
		pass

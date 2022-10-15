extends StaticBody2D

onready var player = get_parent().find_node("Player")

export(String) var npc_name = "Cauldron"

var dialog_index := 0


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_to_group(npc_name)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	if dialog_index == 0:
		start_dialog()
	if player.components_gathered:
		dialog_index = 3
	if player.interaction_target == npc_name and Input.is_action_just_pressed("interact"):
		start_dialog()
	else:
		pass

func _on_InteractionZone_body_entered(body):
	if body == player:
		player.can_interact = true
		player.interaction_target = npc_name
	else:
		pass


func _on_InteractionZone_body_exited(body):
	if body == player:
		player.can_interact = false
		player.interaction_target = "None"
	pass # Replace with function body.

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

# dialogic signal reciever
func dialogic_signal_event(param):
	if param == "increase dialog index":
		dialog_index += 1
	if param == "end demo":
		get_tree().change_scene("res://Main.tscn")

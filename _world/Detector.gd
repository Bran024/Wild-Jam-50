extends Area2D

const npc_name := "Blocker"
const dialog_index := 0

onready var player = get_parent().find_node("Player")
onready var detector_spot = get_parent().find_node("DetectorSpot")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	if Global.quest_stage >= 2:
		$CollisionShape2D.set_deferred("disabled", true)
	else:
		$CollisionShape2D.set_deferred("disabled", false)
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
	if param == "move player":
		player.global_position = detector_spot.global_position
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Detector_body_entered(body):
	if body == player:
		start_dialog()
	else:
		pass

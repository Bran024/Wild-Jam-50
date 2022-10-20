extends Area2D


onready var player = get_parent().find_node("Player")

export(String) var npc_name
export(String) var item_name
export(Texture) var item_sprite

var dialog_index := 0
var interactable := false


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.texture = item_sprite
	$Sprite.scale.x = 1
	$Sprite.scale.y = 1
	self.add_to_group("items")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	if Global.mundane_item == item_name:
		queue_free()
	if Global.quest_stage >= 4:
		interactable = true
	if Global.mundane_item != "None":
		interactable = false
	if player.interaction_target == npc_name and Input.is_action_just_pressed("interact") and interactable:
		start_dialog()
	else:
		pass
func _on_InteractionZone_body_entered(body):
	if body == player and interactable:
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
	if param == "set mundane item":
		Global.mundane_item = item_name

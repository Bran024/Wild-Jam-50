extends Node2D

var intro_complete := false
var insight := 0
var quest_stage := 0
var mushrooms := 0
var moss := 0
var feathers := 0
var tinder := 0
var tinder_collected := false
var mundane_item := "None"




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	Dialogic.set_variable("insight", insight)
	if quest_stage >= 3:
		mushrooms = 0
		moss = 0
		feathers = 0
	if tinder >= 3:
		tinder_collected
	if quest_stage >= 4:
		tinder = 0
		tinder_collected = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

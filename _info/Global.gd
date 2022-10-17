extends Node2D

var intro_complete := false
var quest_stage := 0
var mushrooms := 0
var moss := 0
var feathers := 0



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if quest_stage >= 3:
		mushrooms = 0
		moss = 0
		feathers = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

extends Control

var audio_bus = AudioServer.get_bus_index("Master")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if !$AudioStreamPlayer.is_playing():
		$AudioStreamPlayer.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	get_tree().change_scene("res://_world/Hut.tscn")
	self.queue_free()


func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(audio_bus, value)
	if value == -30:
		AudioServer.set_bus_mute(audio_bus, true)
	else:
		AudioServer.set_bus_mute(audio_bus, false)
	pass # Replace with function body.

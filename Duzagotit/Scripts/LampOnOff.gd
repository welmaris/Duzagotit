extends Node2D

var off = false

func _ready():
	$Lamp.animation = "On"

# If clicked, turn off
func _on_Area2D_input_event(viewport, event, shape_idx):
	
	if(event is InputEventMouseButton) and event.is_pressed():
		print(off)
		off = true
		$Lamp.animation = "Off"
		emit_signal("finished")
		print(off)


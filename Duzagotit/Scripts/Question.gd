extends CanvasLayer
signal _button_pressed(button_int)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_B0_pressed():
	emit_signal("_button_pressed", 0)


func _on_B1_pressed():
	emit_signal("_button_pressed", 1)


func _on_B2_pressed():
	emit_signal("_button_pressed", 2)


func _on_B3_pressed():
	emit_signal("_button_pressed", 3)

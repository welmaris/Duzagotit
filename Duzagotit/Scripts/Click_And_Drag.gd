extends Area2D

var dragging = false
var mouse_offset = Vector2()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (dragging):
		position = get_viewport().get_mouse_position() + mouse_offset


func _on_Click_input_event(viewport, event, shape_idx):
	print("gothere")
	if(event is InputEventMouseButton):
		dragging = !dragging
		mouse_offset = position - event.position


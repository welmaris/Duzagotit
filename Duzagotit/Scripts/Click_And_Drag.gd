extends Area2D

signal correct_waste_disposal
signal incorrect_waste_disposal

var dragging = false
var mouse_offset = Vector2()
var wastetype = "glass"
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
	if(event is InputEventMouseButton):
		dragging = !dragging
		mouse_offset = position - event.position



func _on_Click_and_Drag_area_entered(area):
	if("MinigameInterractObject" in area.name):
		if wastetype == "glass" and area.get_node("Sprite").frame == 2:
			emit_signal("correct_waste_disposal")
		else:
			emit_signal("incorrect_waste_disposal")
		queue_free()

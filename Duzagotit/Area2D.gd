extends Area2D
var dragging = false
var mouse_offset = Vector2()
var rotation_offset = Vector2()
var total_rotation = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _process(delta):
	#print(delta)
	if (dragging):
		var previous_rotation = rotation
		mouse_offset = position - get_viewport().get_mouse_position()
		rotation = atan2(mouse_offset.y,mouse_offset.x) + rotation_offset
		if(abs(rotation - previous_rotation) < 1):
			total_rotation += rotation - previous_rotation
		#print(total_rotation)
		get_parent().update_temperature(total_rotation)

func _input(event):
	if event is InputEventMouseButton:
		dragging = !dragging
		#if !event.is_pressed():
		#	dragging = false
		mouse_offset = position - event.position
		rotation_offset = rotation - atan2(mouse_offset.y,mouse_offset.x)

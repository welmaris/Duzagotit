extends Area2D

signal correct_waste_disposal
signal incorrect_waste_disposal

var dragging = false
var mouse_offset = Vector2()
var wastetype = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	if wastetype == "paper":
		$Sprite.frame = 0
	if wastetype == "plastic":
		$Sprite.frame = 1 + (randi()%2)*2
	if wastetype == "glass":
		$Sprite.frame = 2
	if wastetype == "green":
		$Sprite.frame = 4
	if wastetype == "rest":
		$Sprite.frame = 8


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (dragging):
		position = get_viewport().get_mouse_position() + mouse_offset


func _on_Click_input_event(viewport, event, shape_idx):
	if(event is InputEventMouseButton):
		dragging = true
		if !event.is_pressed():
			dragging = false
		mouse_offset = position - event.position



func _on_Click_and_Drag_area_entered(area):
	if("MinigameInterractObject" in area.name):
		var bintype
		if "1.png" in  area.get_node("Sprite").texture.get_path():
			bintype = "paper"
		if "2.png" in  area.get_node("Sprite").texture.get_path():
			bintype = "glass"
		if "3.png" in  area.get_node("Sprite").texture.get_path():
			bintype = "rest"
		if "4.png" in  area.get_node("Sprite").texture.get_path():
			bintype = "green"
		if "5.png" in  area.get_node("Sprite").texture.get_path():
			bintype = "plastic"
		if wastetype == bintype:
			emit_signal("correct_waste_disposal")
		else:
			emit_signal("incorrect_waste_disposal")
		queue_free()

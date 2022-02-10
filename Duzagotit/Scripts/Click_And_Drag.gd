extends Area2D

signal correct_waste_disposal
signal incorrect_waste_disposal

var dragging = false
var mouse_offset = Vector2()
var wastetype = ""
var can_drag = true


# Called when the node enters the scene tree for the first time.
func _ready():
	$Line2D.hide()
	if wastetype == "paper" or wastetype == "plastic" or wastetype == "glass" or wastetype == "green" or wastetype == "rest":
		$Sprite.show()
		$Sprite2.hide()
	else:
		$Sprite.hide()
		$Sprite2.show()
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
	if wastetype == "plate":
		$Sprite2.texture = load("res://Art/Images/plate.png")
	if wastetype == "bowl":
		$Sprite2.texture = load("res://Art/Images/plate.png")
	if wastetype == "sponge" or wastetype == "aquasponge" :
		$Sprite2.texture = load("res://Art/Images/sponge.png")
	if wastetype == "needle":
		$Sprite2.texture = load("res://Art/Images/naald.png")
		$Line2D.show()
	if wastetype == "solar":
		$Sprite2.texture = load("res://Art/Images/solar.png")
		$Sprite2.scale = Vector2(0.9,0.9)
		$CollisionShape2D.shape = RectangleShape2D.new()
		$CollisionShape2D.shape.set_extents(Vector2(80,100))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (dragging):
		position = get_viewport().get_mouse_position() + mouse_offset
	if wastetype == "needle":
		$Line2D.set_points([-position+Vector2(478,900),Vector2(105,85)])


func _on_Click_input_event(viewport, event, shape_idx):
	#print("something")
	if(event is InputEventMouseButton):
		if can_drag:
			dragging = true
			if !event.is_pressed():
				dragging = false
			mouse_offset = position - event.position

func _on_Click_and_Drag_area_entered(area):
	if("MinigameInterractObject" in area.name):
		if wastetype == "needle":
			area.scale -= Vector2(0.02,0.02) 
			if area.scale.x <= 0.8:
				area.queue_free()
				emit_signal("correct_waste_disposal")
		elif wastetype == "aquasponge":
			area.modulate.a -= 0.1 
			if area.modulate.a <= 0.5:
				area.queue_free()
				emit_signal("correct_waste_disposal")
		elif wastetype == "solar":
			position = area.position
			area.queue_free()
			can_drag = false
			dragging = false
			emit_signal("correct_waste_disposal")
		else:
			var bintype = "dishes"
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
			if wastetype == bintype or bintype == "dishes":
				emit_signal("correct_waste_disposal")
			else:
				emit_signal("incorrect_waste_disposal")
			queue_free()

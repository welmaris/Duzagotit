extends Node
export (PackedScene) var TrashItem
export (PackedScene) var Trashcan

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var minigame_name = "recycle_glass"

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	if minigame_name == "recycle_glass":
		for x in range(5):
			spawn_trash()
		spawn_trash_cans()

func spawn_trash(): # spawns a trash item
	$Path2D/PathFollow2D.offset = randi()
	var trash = TrashItem.instance()
	trash.connect("input_event", trash, "_on_Click_input_event")
	trash.connect("correct_waste_disposal", self, "_on_Click_and_Drag_correct_waste_disposal")
	trash.connect("incorrect_waste_disposal", self, "_on_Click_and_Drag_incorrect_waste_disposal")
	trash.wastetype = "glass"
	add_child(trash)
	trash.position = $Path2D/PathFollow2D.position

func spawn_trash_cans():
	for x in range(5):
		var trashcan = Trashcan.instance()
		#trashcan.connect("input_event", trashcan, "_on_Click_input_event")
		trashcan.get_node("Sprite").frame = x
		add_child(trashcan)
		trashcan.position = Vector2(300+300*x,800)


#func _on_Click_input_event(event):
#	print("gothere")
#	if(event is InputEventMouseButton):
#		dragging = !dragging
#		mouse_offset = position - event.position


func _on_Click_and_Drag_correct_waste_disposal():
	print("wow correct indeed")


func _on_Click_and_Drag_incorrect_waste_disposal():
	print("hmmm not so correct actually")

extends Node
export (PackedScene) var TrashItem

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	for x in range(5):
		spawn_trash()

func spawn_trash(): # spawns a question bubble for the player to click on
	$Path2D/PathFollow2D.offset = randi()
	var trash = TrashItem.instance()
	trash.connect("input_event", trash, "_on_Click_input_event")
	add_child(trash)
	trash.position = $Path2D/PathFollow2D.position

#func _on_Click_input_event(event):
#	print("gothere")
#	if(event is InputEventMouseButton):
#		dragging = !dragging
#		mouse_offset = position - event.position

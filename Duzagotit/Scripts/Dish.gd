extends Area2D
var sponge_is_on_dish = true
var previous_mouse_pos
var total_moved = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _ready():
	previous_mouse_pos = get_viewport().get_mouse_position()

func _process(delta):
	#print(delta)
	if (sponge_is_on_dish):
		var difference = get_viewport().get_mouse_position() - previous_mouse_pos
		var distance_moved = difference.length()
		total_moved += distance_moved
		if total_moved > 5000:
			total_moved = 0
			get_parent().did_a_dish()
			$Sprite.texture = load("res://Art/Images/plate_clean.png")
			position = Vector2(1100+50*get_parent().in_minigame_score,400)
		#print(total_rotation)
	previous_mouse_pos = get_viewport().get_mouse_position()




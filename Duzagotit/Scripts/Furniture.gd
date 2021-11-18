extends StaticBody2D

var nearby_areas = []
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("interact"):
		if(len(nearby_areas) > 0):
			if nearby_areas[0] == get_parent().get_node("Player"):
				print("player just clicked: ", self.name)


func _on_Area2D_area_entered(area):
	nearby_areas.append(area)

func _on_Area2D_area_exited(area):
	nearby_areas.erase(area)

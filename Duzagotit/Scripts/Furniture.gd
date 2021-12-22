extends StaticBody2D

signal _player_interract
var nearby_areas = []
var minigame_name
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureRect/Outline.visible = false
	minigame_name = ""


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(len(nearby_areas) > 0):
		if nearby_areas[0] == get_parent().get_node("Player"):
			$TextureRect/Outline.visible = true
		else:
			$TextureRect/Outline.visible = false
	else:
		$TextureRect/Outline.visible = false
	if Input.is_action_just_pressed("interact"):
		if(len(nearby_areas) > 0):
			if nearby_areas[0] == get_parent().get_node("Player"):
				print("player just clicked: ", self.name)
				emit_signal("_player_interract",minigame_name)

func _on_Area2D_body_entered(body):
	if(get_parent().get_node("Player") == body):
		nearby_areas.append(body)

func _on_Area2D_body_exited(body):
	nearby_areas.erase(body)

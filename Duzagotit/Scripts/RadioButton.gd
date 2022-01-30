extends Node

var selected = 1
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


## Called when the node enters the scene tree for the first time.
#func _ready():
#	set_disabled(2)
#	set_disabled(3)
#	set_disabled(4)
#	set_disabled(5)
#	pass # Replace with function body.

func set_disabled(index):
	get_node("HouseSelect"+str(index)).disabled = true

func set_enabled(index):
	get_node("HouseSelect"+str(index)).disabled = false

func set_unpressed(notindex):
	selected = notindex
	get_parent().selected = selected
	for index in range(1,6):
		if index != notindex:
			get_node("HouseSelect"+str(index)).pressed = false



func _on_HouseSelect1_pressed():
	set_unpressed(1)

func _on_HouseSelect2_pressed():
	set_unpressed(2)

func _on_HouseSelect3_pressed():
	set_unpressed(3)

func _on_HouseSelect4_pressed():
	set_unpressed(4)

func _on_HouseSelect5_pressed():
	set_unpressed(5)

extends Node2D

export (PackedScene) var Minigame
export (PackedScene) var Furniture

var player_exists = false

func _ready():
	pass
##	Call method to place minigames
#	var minigame_names = ["recycling_bins","collect_dishes","cd2","do_dishes","teddybear"]
#	spawn_minigames(minigame_names)
#	print(get_tree())


## spawn furniture and games
#func spawn_minigames(minigame_names: Array):
##	var minigame_names = ["recycling_bins","collect_dishes","cd2","do_dishes"]
#	for name in minigame_names:
##		add connection
#		var furn = Furniture.instance()
#		furn.connect("_on_Area2D_body_entered", furn, "_on_Area2D_body_entered")
#		furn.connect("_on_Area2D_body_exited", furn, "_on_Area2D_body_exited")
#		furn.connect("_player_interract", get_parent(), "_player_interract")
#		furn.minigame_name = name
#
#		if "cd" in name:
#			furn.minigame_name = "collect_dishes"
#
##		loop through games 
#		if name == "recycling_bins":
#			mini_recycling(furn)
#		elif name == "collect_dishes" or name == "cd2":
#			furn.position = Vector2(500,810)
#			if name == "cd2":
#				furn.position = Vector2(925,315)
#			mini_collect_dishes(furn)
#		elif name == "do_dishes":
#			mini_do_dishes(furn)
#		elif name == "teddybear":
#			mini_teddybear(furn)
#
#		add_child(furn)
#		move_child(furn,furn.get_index() - 1)


func _on_Area2D_body_entered(body):
	if !player_exists:
		player_exists = true
	else:
		print("testing")
		get_parent().goto_house_select()

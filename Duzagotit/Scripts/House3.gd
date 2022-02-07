extends Node2D

export (PackedScene) var Minigame
export (PackedScene) var Furniture

var player_exists = false

func _ready():
#	Call method to place minigames]
	var minigame_names = [""]
	spawn_minigames(minigame_names)

func spawn_minigames(minigame_names: Array):
	pass

extends Node2D

export (PackedScene) var Minigame
export (PackedScene) var Furniture

var player_exists = false

func _ready():
#	Call method to place minigames

#	var minigame_names = ["recycling_bins","collect_dishes","cd2","do_dishes","teddybear", "lamp", "lamp2", "fridge"]
	var minigame_names = ["lamp", "lamp2", "fridge","thermostat","solar"]
	spawn_minigames(minigame_names)
#	print(get_tree())


# spawn furniture and games
func spawn_minigames(minigame_names: Array):
#	var minigame_names = ["recycling_bins","collect_dishes","cd2","do_dishes"]
	for name in minigame_names:
#		add connection
		var furn = Furniture.instance()
		furn.connect("_on_Area2D_body_entered", furn, "_on_Area2D_body_entered")
		furn.connect("_on_Area2D_body_exited", furn, "_on_Area2D_body_exited")
		furn.connect("_player_interract", get_parent(), "_player_interract")
		furn.minigame_name = name
		
		if "cd" in name:
			furn.minigame_name = "collect_dishes"
		
#		loop through games 
		if name == "lamp":
			furn.position = Vector2(390, 750)
			mini_lamp(furn)
		elif name == "lamp2":
			furn.position = Vector2(1350, 750)
			mini_lamp(furn)
		elif name == "fridge":
			mini_fridge(furn)
		elif name == "thermostat":
			mini_thermostat(furn)
		elif name == "solar":
			mini_solar(furn)
		add_child(furn)
		move_child(furn,furn.get_index() - 1)


func mini_lamp(furn):
#	place and add texture
	furn.scale = Vector2(1.5,1.5)

	furn.get_node("TextureRect").texture = load("res://Art/Images/pixel_lamp_on.png")
	furn.get_node("TextureRect").get_node("Outline").texture = load("res://Art/Images/pixel_lamp_on.png")
	furn.get_node("TextureRect").get_node("Outline").margin_left = -1
	furn.get_node("TextureRect").get_node("Outline").margin_top = -2
#	add collision
	furn.get_node("CollisionShape2D").position = Vector2(12,22)
	furn.get_node("CollisionShape2D").scale = Vector2(0.2,1)
	furn.get_node("Area2D").get_node("InteractionSpace").position = Vector2(10,10)
	furn.get_node("Area2D").get_node("InteractionSpace").scale = Vector2(1,1)
	print("is pickable: " , furn.is_pickable())

func mini_fridge(furn):
	furn.position = Vector2(1235, 520)
	furn.scale = Vector2(1.5,1.5)
	furn.get_node("TextureRect").texture = load("res://Art/Images/pixel_fridge.png")
	furn.get_node("TextureRect").get_node("Outline").texture = load("res://Art/Images/pixel_fridge.png")
	furn.get_node("TextureRect").get_node("Outline").margin_left = 0
	furn.get_node("TextureRect").get_node("Outline").margin_top = -3
#	add collision
	furn.get_node("CollisionShape2D").position = Vector2(22,25)
	furn.get_node("CollisionShape2D").scale = Vector2(.5,1)
	furn.get_node("Area2D").get_node("InteractionSpace").position = Vector2(25,50)
	furn.get_node("Area2D").get_node("InteractionSpace").scale = Vector2(1,1)
	pass
	
func mini_thermostat(furn):
#	place and add texture
	furn.position = Vector2(910,500)
	furn.scale = Vector2(0.1,0.1)
	furn.get_node("TextureRect").texture = load("res://Art/Images/thermostat.png")
	furn.get_node("TextureRect").get_node("Outline").texture = load("res://Art/Images/thermostat.png")
	furn.get_node("TextureRect").get_node("Outline").margin_left = -20
	furn.get_node("TextureRect").get_node("Outline").margin_top = -10
#	add collision
	furn.get_node("CollisionShape2D").position = Vector2(212,22)
	furn.get_node("CollisionShape2D").scale = Vector2(3,2)
	furn.get_node("Area2D").get_node("InteractionSpace").position = Vector2(0,350)
	furn.get_node("Area2D").get_node("InteractionSpace").scale = Vector2(5,10)
	pass
	
func mini_solar(furn):
#	place and add texture
	furn.position = Vector2(840,43)
	furn.scale = Vector2(0.3,0.4)
	furn.get_node("TextureRect").texture = load("res://Art/Images/ladder.png")
	furn.get_node("TextureRect").get_node("Outline").texture = load("res://Art/Images/ladder.png")
	furn.get_node("TextureRect").get_node("Outline").margin_left = -7
	furn.get_node("TextureRect").get_node("Outline").margin_top = -20
#	add collision
	furn.get_node("CollisionShape2D").position = Vector2(212,22)
	furn.get_node("CollisionShape2D").scale = Vector2(3,2)
	furn.get_node("Area2D").get_node("InteractionSpace").position = Vector2(150,350)
	furn.get_node("Area2D").get_node("InteractionSpace").scale = Vector2(2,3)
	pass
	

func _on_Area2D_body_entered(body):
	if !player_exists:
		player_exists = true
	else:
		print("testing")
		get_parent().goto_house_select()

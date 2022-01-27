extends Node2D

#export (PackedScene) var QuestionBubble
#export (PackedScene) var Question
export (PackedScene) var Minigame
export (PackedScene) var Furniture

func _ready():
#	$House.show()
#	Call method to place minigames
	var minigame_names = ["recycling_bins","collect_dishes","cd2","do_dishes"]
	spawn_minigames(minigame_names)


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
		if name == "recycling_bins":
			mini_recycling(furn)
		elif name == "collect_dishes" or name == "cd2":
			furn.position = Vector2(500,810)
			if name == "cd2":
				furn.position = Vector2(925,315)
			mini_collect_dishes(furn)
		elif name == "do_dishes":
			mini_do_dishes(furn)
			
		add_child(furn)
		move_child(furn,furn.get_index() - 2)

func mini_recycling(furn):
#	place furniture
	furn.position = Vector2(1270,640)
	furn.scale = Vector2(.08,.08)
#	add texture
	furn.get_node("TextureRect").texture = load("res://Art/Images/prullebak/4.png")
	furn.get_node("TextureRect").get_node("Outline").texture = load("res://Art/Images/prullebak/4.png")
	furn.get_node("TextureRect").get_node("Outline").margin_left = -55
	furn.get_node("TextureRect").get_node("Outline").margin_top = -90
#	add collision shape
	furn.get_node("CollisionShape2D").position = Vector2(35.341,533.782)
	furn.get_node("CollisionShape2D").scale = Vector2(30,30)
#
	furn.get_node("Area2D").get_node("InteractionSpace").position = Vector2(635.19,532.518)
	furn.get_node("Area2D").get_node("InteractionSpace").scale = Vector2(10,30)

func mini_collect_dishes(furn):
#	place and add texture
	furn.scale = Vector2(.1,.1)
	furn.get_node("TextureRect").texture = load("res://Art/Images/plate.png")
	furn.get_node("TextureRect").get_node("Outline").texture = load("res://Art/Images/plate.png")
	furn.get_node("TextureRect").get_node("Outline").margin_left = -20
	furn.get_node("TextureRect").get_node("Outline").margin_top = -20
#	add collision
	furn.get_node("CollisionShape2D").position = Vector2(200,38)
	furn.get_node("CollisionShape2D").scale = Vector2(5,2)
#	
	furn.get_node("Area2D").get_node("InteractionSpace").position = Vector2(200,200)
	furn.get_node("Area2D").get_node("InteractionSpace").scale = Vector2(5,13)

func mini_do_dishes(furn):
#	place and add texture
	furn.position = Vector2(1150,715)
	furn.scale = Vector2(.13,.13)
	furn.get_node("TextureRect").texture = load("res://Art/Images/sponge.png")
	furn.get_node("TextureRect").get_node("Outline").texture = load("res://Art/Images/sponge.png")
	furn.get_node("TextureRect").get_node("Outline").margin_left = -10
	furn.get_node("TextureRect").get_node("Outline").margin_top = -10
#	add collision
	furn.get_node("CollisionShape2D").position = Vector2(200,38)
	furn.get_node("CollisionShape2D").scale = Vector2(2,1)
	furn.get_node("Area2D").get_node("InteractionSpace").position = Vector2(120,200)
	furn.get_node("Area2D").get_node("InteractionSpace").scale = Vector2(2,6)

func minigame_stop():
	if is_instance_valid(Minigame):
		get_node("Minigame").minigame_not_done()
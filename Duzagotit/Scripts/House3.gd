extends Node2D

export (PackedScene) var Minigame
export (PackedScene) var Furniture

var player_exists = false

func _ready():
#	Call method to place minigames]
	var minigame_names = ["washing_machine","shower", "do_dishes", "vissenkom"]
	spawn_minigames(minigame_names)

func spawn_minigames(minigame_names: Array):
	for name in minigame_names:
#		add connection
		var furn = Furniture.instance()
		furn.connect("_on_Area2D_body_entered", furn, "_on_Area2D_body_entered")
		furn.connect("_on_Area2D_body_exited", furn, "_on_Area2D_body_exited")
		furn.connect("_player_interract", get_parent(), "_player_interract")
		furn.minigame_name = name
		
		
		if name == "washing_machine":
			mini_washing(furn)
		elif name == "shower":
			mini_shower(furn)
		elif name == "do_dishes":
			mini_do_dishes(furn)
		elif name == "vissenkom":
			mini_vissenkom(furn)
			
		add_child(furn)
		move_child(furn,furn.get_index() - 1)
		
func mini_washing(furn):
	furn.position = Vector2(1088,260)
	furn.scale = Vector2(1.5,1.5)
	furn.get_node("TextureRect").texture = load("res://Art/Images/pixel_washingmachine.png")
	furn.get_node("TextureRect").get_node("Outline").texture = load("res://Art/Images/pixel_washingmachine.png")
	furn.get_node("TextureRect").get_node("Outline").margin_left = -2
	furn.get_node("TextureRect").get_node("Outline").margin_top = -2
#	add collision
	furn.get_node("CollisionShape2D").position = Vector2(10,30)
	furn.get_node("CollisionShape2D").scale = Vector2(0.8,0.5)
	furn.get_node("Area2D").get_node("InteractionSpace").position = Vector2(20,10)
	furn.get_node("Area2D").get_node("InteractionSpace").scale = Vector2(0.5,1)

func mini_shower(furn):
	furn.position = Vector2(1405,210)
	furn.scale = Vector2(1.5,1.5)
	furn.get_node("TextureRect").texture = load("res://Art/Images/pixel_shower.png")
	furn.get_node("TextureRect").get_node("Outline").texture = load("res://Art/Images/pixel_shower.png")
	furn.get_node("TextureRect").get_node("Outline").margin_left = -2
	furn.get_node("TextureRect").get_node("Outline").margin_top = -2
#	add collision
	furn.get_node("CollisionShape2D").position = Vector2(30,60)
	furn.get_node("CollisionShape2D").scale = Vector2(1,1)
	furn.get_node("Area2D").get_node("InteractionSpace").position = Vector2(20,10)
	furn.get_node("Area2D").get_node("InteractionSpace").scale = Vector2(1,2)
	
func mini_do_dishes(furn):
#	place and add texture
	furn.position = Vector2(1275,670)
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

func mini_vissenkom(furn):
	#	place and add texture
	furn.position = Vector2(625, 660)
	
	furn.get_node("TextureRect").texture = load("res://Art/Images/vissenkom_rpg.png")
	furn.get_node("TextureRect").get_node("Outline").texture = load("res://Art/Images/vissenkom_rpg.png")
	furn.get_node("TextureRect").get_node("Outline").margin_left = 0
	furn.get_node("TextureRect").get_node("Outline").margin_top = 0
	#	add collision
	furn.get_node("CollisionShape2D").position = Vector2(15,15)
	furn.get_node("CollisionShape2D").scale = Vector2(.5,.5)
	furn.get_node("Area2D").get_node("InteractionSpace").position = Vector2(15,30)
	furn.get_node("Area2D").get_node("InteractionSpace").scale = Vector2(.8,1)

func _on_Area2D_body_entered(body):
	if !player_exists:
		player_exists = true
	else:
		#print("testing")
		get_parent().goto_house_select()

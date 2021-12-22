extends Node
export (PackedScene) var TrashItem
export (PackedScene) var Trashcan
export (PackedScene) var LightSwitch
export (PackedScene) var Faucet
export (PackedScene) var FaucetKnob

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var minigame_name = ""
var in_minigame_score = 0
var in_minigame_max_score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	in_minigame_score = 0
	if minigame_name == "recycling_bins":
		in_minigame_max_score = 5
		for x in range(5):
			spawn_trash(["glass","plastic","green","paper","rest"])
		spawn_trash_cans()
	if minigame_name == "fixing_faucet":
		spawn_faucet()
	if minigame_name == "collect_dishes":
		for x in range(3):
			spawn_trash(["plate"])
			spawn_trash(["bowl"])
		spawn_dish_bowl()
		pass
		

func spawn_trash(possible_wastetype): # spawns a trash item
	$Path2D/PathFollow2D.offset = randi()
	var trash = TrashItem.instance()
	trash.connect("input_event", trash, "_on_Click_input_event")
	trash.connect("correct_waste_disposal", self, "_on_Click_and_Drag_correct_waste_disposal")
	trash.connect("incorrect_waste_disposal", self, "_on_Click_and_Drag_incorrect_waste_disposal")
	
	trash.wastetype = possible_wastetype[randi()%len(possible_wastetype)]
	add_child(trash)
	trash.position = $Path2D/PathFollow2D.position

func spawn_dish_bowl():
	var dishbowl = Trashcan.instance()
	dishbowl.get_node("Sprite").texture = load("res://Art/Images/wasbak.png")
	dishbowl.get_node("Sprite").scale = Vector2(1,1)
	dishbowl.get_node("CollisionShape2D").scale = Vector2(1,2.5)
	
	add_child(dishbowl)
	dishbowl.position = Vector2(1300,500)

func spawn_trash_cans():
	for x in range(5):
		var trashcan = Trashcan.instance()
		trashcan.get_node("Sprite").scale = Vector2(0.2,0.2)
		trashcan.get_node("CollisionShape2D").scale = Vector2(1,1)
		#trashcan.connect("input_event", trashcan, "_on_Click_input_event")
		trashcan.get_node("Sprite").texture = load("res://Art/Images/prullebak/"+str(x+1)+".png")
		add_child(trashcan)
		trashcan.position = Vector2(300+300*x,800)

func check_done():
	print(get_child_count())
	if minigame_name == "collect_dishes" and get_child_count() == 4:
		minigame_done()
	if minigame_name == "recycling_bins" and get_child_count() == 8:
		minigame_done()

func minigame_done():
	get_parent().score += in_minigame_score
	for x in get_parent().get_children():
		if "urni" in x.name:
			if x.minigame_name == "collect_dishes":
				x.queue_free()
			else:
				x.get_node("TextureRect").get_node("Outline").scale = Vector2(0,0)
	queue_free()

func spawn_faucet():
	var faucet = Faucet.instance()
	var faucetknob = FaucetKnob.instance()
	add_child(faucet)
	add_child(faucetknob)

func _on_Click_and_Drag_correct_waste_disposal():
	in_minigame_score += 1
	check_done()
	print("wow correct indeed")


func _on_Click_and_Drag_incorrect_waste_disposal():
	check_done()
	print("hmmm not so correct actually")

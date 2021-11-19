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
	if minigame_name == "recycling_bins":
		in_minigame_max_score = 5
		for x in range(5):
			spawn_trash()
		spawn_trash_cans()
	if minigame_name == "fixing_faucet":
		spawn_faucet()
		

func spawn_trash(): # spawns a trash item
	$Path2D/PathFollow2D.offset = randi()
	var trash = TrashItem.instance()
	trash.connect("input_event", trash, "_on_Click_input_event")
	trash.connect("correct_waste_disposal", self, "_on_Click_and_Drag_correct_waste_disposal")
	trash.connect("incorrect_waste_disposal", self, "_on_Click_and_Drag_incorrect_waste_disposal")
	
	var possible_wastetype = ["glass","plastic","green","paper","rest"]
	trash.wastetype = possible_wastetype[randi()%len(possible_wastetype)]
	add_child(trash)
	trash.position = $Path2D/PathFollow2D.position

func spawn_trash_cans():
	for x in range(5):
		var trashcan = Trashcan.instance()
		#trashcan.connect("input_event", trashcan, "_on_Click_input_event")
		trashcan.get_node("Sprite").texture = load("res://Art/Images/prullebak/"+str(x+1)+".png")
		add_child(trashcan)
		trashcan.position = Vector2(300+300*x,800)

func spawn_faucet():
	var faucet = Faucet.instance()
	var faucetknob = FaucetKnob.instance()
	add_child(faucet)
	add_child(faucetknob)

func _on_Click_and_Drag_correct_waste_disposal():
	in_minigame_score += 1
	print("wow correct indeed")


func _on_Click_and_Drag_incorrect_waste_disposal():
	print("hmmm not so correct actually")

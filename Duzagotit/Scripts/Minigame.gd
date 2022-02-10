extends Node
export (PackedScene) var TrashItem
export (PackedScene) var Trashcan
export (PackedScene) var LightSwitch
export (PackedScene) var Faucet
export (PackedScene) var FaucetKnob
export (PackedScene) var Dishes
export (PackedScene) var Teddy
export (PackedScene) var LampOnOff
export (PackedScene) var Turning
export (PackedScene) var Fridge

signal finished


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var minigame_name = ""
var in_minigame_score = 0
var in_minigame_max_score = 0

var thermostat
var shower
var can_turn = true

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	in_minigame_score = 0
	if minigame_name == "recycling_bins":
		in_minigame_max_score = 5
		for x in range(5):
			spawn_trash(["glass","plastic","green","paper","rest"])
		spawn_trash_cans()
		$Explanation.text = "Gooi al het afval in de juiste bak"
	if minigame_name == "fixing_faucet":
		spawn_faucet()
	if minigame_name == "collect_dishes":
		in_minigame_max_score = 6
		for x in range(6):
			spawn_trash(["plate"])
		spawn_dish_bowl()
		$Explanation.text = "Verzamel alle afwas"
	if minigame_name == "do_dishes":
		spawn_dish()
		spawn_trash(["sponge"])
		$Explanation.text = "Poets de borden schoon met de spons"
	if minigame_name == "teddybear":
		spawn_teddy()
		$Explanation.text = "Gebruik de naald en draad om de teddybeer weer heel te maken"
	if minigame_name == "lamp_woonkamer" or minigame_name == "lamp_slaapkamer":
		spawn_lamp()
		$Explanation.text = "Zet de lamp uit om stroom te besparen"
	if minigame_name == "thermostat":
		spawn_thermostat()
		$Explanation.text = "Zet de verwarming lager om stroom te besparen"
	if minigame_name == "fridge":
		spawn_fridge()
		$Explanation.text = "Welke Koelkast kunnen je ouders het beste kopen?"
	if minigame_name == "solar":
		spawn_solar()
		$Explanation.text = "Plaats de zonnepanelen op het dak"
	if minigame_name == "washing_machine":
		spawn_washing()
		$Explanation.text = "Welke wasmachine kunnen je ouders het beste kopen?"
	if minigame_name == "shower":
		spawn_shower()
		$Explanation.text = "Zet de douche uit om water te besparen"
	if minigame_name == "aquarium":
		spawn_aquarium()
		$Explanation.text = "Maak het aquarium schoon"

# Minigame finished succesfully
func minigame_done(_wrong = 0):
	if $AudioStreamPlayer.playing:
		yield($AudioStreamPlayer, "finished")
	var correct_sprite = Sprite.new()
	correct_sprite.position = Vector2(500,500)
	add_child(correct_sprite)
	if(_wrong == 1):
		play_wrong()
		correct_sprite.texture = load("res://Art/Images/incorrect.png")
	else:
		play_finished()
		correct_sprite.texture = load("res://Art/Images/correct.png")
	var minigame_show_result_timer = Timer.new()
	minigame_show_result_timer.set_one_shot(true)
	minigame_show_result_timer.set_wait_time(2)
	minigame_show_result_timer.connect("timeout",self,"mgad")
	add_child(minigame_show_result_timer)
	minigame_show_result_timer.start()
	get_parent().get_node("QuestionSpawnTimer").start()

func mgad():
	get_parent().minigame_is_showing = false
	get_parent().update_score(in_minigame_score)
	in_minigame_score = 0
	for y in get_parent().get_children():     #Delete the correct furniture that starts the minigame
		if "ous" in y.name:
			for x in y.get_children():
				if "Furni" in x.name:
					if x.minigame_name == "collect_dishes" and x.minigame_name == minigame_name and len(x.nearby_areas) > 0:
						if x.nearby_areas[0] == get_parent().get_node("Player"):
							x.queue_free()
#					else:
#						x.get_node("TextureRect").get_node("Outline").scale = Vector2(0,0)
		
	queue_free()

func minigame_not_done():
	get_parent().minigame_is_showing = false
	queue_free()



# check if minigame has finished
func check_done():
	
#	timeout to give it time to register change in child count
	yield(get_tree().create_timer(0.5), "timeout")
	
	
	if minigame_name == "collect_dishes" and get_child_count() == 5:
		minigame_done()
	if minigame_name == "recycling_bins" and get_child_count() == 9:
		if in_minigame_score < 3:
			minigame_done(1)
		else:
			minigame_done()
	if minigame_name == "teddybear" and get_child_count() == 6:
		minigame_done()
	if minigame_name == "solar" and in_minigame_score == 6:
		minigame_done()
	if minigame_name == "aquarium" and in_minigame_score == 10:
		minigame_done()




func spawn_trash(possible_wastetype): # spawns a trash item
	$Path2D/PathFollow2D.offset = randi()
	var trash = TrashItem.instance()
	trash.connect("input_event", trash, "_on_Click_input_event")
	trash.connect("correct_waste_disposal", self, "_on_Click_and_Drag_correct_waste_disposal")
	trash.connect("incorrect_waste_disposal", self, "_on_Click_and_Drag_incorrect_waste_disposal")
	
	trash.wastetype = possible_wastetype[randi()%len(possible_wastetype)]
	add_child(trash)
	trash.position = $Path2D/PathFollow2D.position
	if possible_wastetype[0] == "plate" or possible_wastetype[0] == "sponge":
		trash.position.x = trash.position.x / 2
	if possible_wastetype[0] == "solar":
		trash.position = Vector2(1700,400)

func spawn_dish_bowl():
	var dishbowl = Trashcan.instance()
	dishbowl.get_node("Sprite").texture = load("res://Art/Images/wasbak.png")
	dishbowl.get_node("Sprite").scale = Vector2(1,1)
	dishbowl.get_node("CollisionShape2D").scale = Vector2(2.5,2.5)
	dishbowl.get_node("CollisionShape2D").position = Vector2(0,150)
	
	add_child(dishbowl)
	dishbowl.position = Vector2(1300,500)

func spawn_teddy():
	var bear = Teddy.instance()
	bear.get_node("Wool").show()
	bear.get_node("Bear").texture = load("res://Art/Images/beer_heel.png")
	bear.get_node("Bear").scale = Vector2(0.6,0.6)
	bear.get_node("Bear").position = Vector2(1263,429)
	bear.get_node("Temperature").hide()
	bear.get_node("Ladder").hide()
	add_child(bear)
	move_child(bear,bear.get_index() - 1)
	for x in range(3):
		var fluff = Trashcan.instance()
		fluff.get_node("Sprite").texture = load("res://Art/Images/beer_pluis.png")
		fluff.get_node("Sprite").scale = Vector2(0.2,0.2)
		fluff.position = Vector2(1100+200*x,400)
		if x == 2:
			fluff.position = Vector2(1200,675)
		add_child(fluff)
	spawn_trash(["needle"])
	get_child(get_child_count()-1).position = Vector2(800,400)

func spawn_aquarium():
	var aqua = Teddy.instance()
	aqua.get_node("Wool").hide()
	aqua.get_node("Bear").texture = load("res://Art/Images/aquarium.png")
	aqua.get_node("Bear").scale = Vector2(4.4,4.4)
	aqua.get_node("Bear").position = Vector2(963,629)
	aqua.get_node("Temperature").hide()
	aqua.get_node("Ladder").hide()
	add_child(aqua)
	move_child(aqua,aqua.get_index() - 1)
	for x in range(10):
		var stain = Trashcan.instance()
		stain.get_node("Sprite").texture = load("res://Art/Images/stain.png")
		stain.get_node("Sprite").scale = Vector2(0.3,0.3)
		stain.position = Vector2(500+randi()%1000,400+randi()%550)
		add_child(stain)
	spawn_trash(["aquasponge"])
	get_child(get_child_count()-1).position = Vector2(800,400)
																			# 300-1000 500-1500
func spawn_dish():
	var dish = Dishes.instance()
	dish.get_node("Sprite").texture = load("res://Art/Images/plate.png")
	dish.position = Vector2(400,400)
	add_child(dish)
	#move_child(dish,dish.get_index() - 1)

func did_a_dish():
	play_correct()
	in_minigame_score += 1
	if in_minigame_score == 5:
		minigame_done()
	else:
		spawn_dish()
	for x in get_children():
		if "Click" in x.name:
			move_child(x,get_child_count())

func spawn_trash_cans():
	for x in range(5):
		var trashcan = Trashcan.instance()
		trashcan.get_node("Sprite").scale = Vector2(0.2,0.2)
		trashcan.get_node("CollisionShape2D").scale = Vector2(1,1)
		#trashcan.connect("input_event", trashcan, "_on_Click_input_event")
		trashcan.get_node("Sprite").texture = load("res://Art/Images/prullebak/"+str(x+1)+".png")
		add_child(trashcan)
		trashcan.position = Vector2(300+300*x,800)


func spawn_faucet():
	var faucet = Faucet.instance()
	var faucetknob = FaucetKnob.instance()
	add_child(faucet)
	add_child(faucetknob)

func spawn_lamp():
	var lamp = LampOnOff.instance()
	lamp.connect("finished", self, "lamp_off")
	add_child(lamp)

func spawn_shower():
	can_turn = true
	var knob = Turning.instance()
	knob.get_node("Sprite").texture = load("res://Art/Images/knob.png")
	knob.get_node("Sprite").scale = Vector2(0.5,0.5)
	shower = Trashcan.instance()
	shower.get_node("Sprite").texture = load("res://Art/Images/douche2.png")
	shower.get_node("Sprite").scale = Vector2(0.5,0.5)
	shower.position = Vector2(1070,600)
	shower.get_node("Sprite").flip_h = true
	add_child(shower)
	add_child(knob)

func spawn_thermostat():
	can_turn = true
	thermostat = Teddy.instance()
	thermostat.get_node("Bear").texture = load("res://Art/Images/thermostat.png")
	thermostat.get_node("Bear").scale = Vector2(2.2,2.2)
	thermostat.get_node("Bear").position = Vector2(950,600)
	thermostat.get_node("Wool").hide()
	thermostat.get_node("Temperature").show()
	thermostat.get_node("Ladder").hide()
	var thermostatknob = Turning.instance()
	thermostatknob.get_node("Sprite").texture = load("res://Art/Images/thermostatknob.png")
	add_child(thermostat)
	add_child(thermostatknob)

func update_temperature(rotation):
	if minigame_name == "thermostat":
		thermostat.get_node("Temperature").text = str(round(50+rotation)/2)
		if round(50+rotation)/2 == 19:
			in_minigame_score = 5
			minigame_done()
		if round(50+rotation)/2 == 30:
			in_minigame_score = 0
			minigame_done(1)
	elif minigame_name == "shower" and can_turn:
		var ammount_turned = round(rotation)/3
		if ammount_turned > 2 and ammount_turned <= 4:
			shower.get_node("Sprite").texture = load("res://Art/Images/douche3.png")
		if ammount_turned > 4:
			shower.get_node("Sprite").texture = load("res://Art/Images/douche4.png")
			in_minigame_score = 0
			minigame_done(1)
			can_turn = false
		if ammount_turned <= 2 and ammount_turned > -1:
			shower.get_node("Sprite").texture = load("res://Art/Images/douche2.png")
		if ammount_turned <= -1 and ammount_turned > -3:
			shower.get_node("Sprite").texture = load("res://Art/Images/douche1.png")
		if ammount_turned < -3:
			shower.get_node("Sprite").texture = load("res://Art/Images/douche0.png")
			in_minigame_score = 5
			minigame_done()
			can_turn = false

			

func spawn_fridge():
	var fridge = Fridge.instance()
	fridge.get_node("TB0").set_normal_texture(load("res://Art/Images/FridgeAAA.png"))
	fridge.get_node("TB1").set_normal_texture(load("res://Art/Images/FridgeD.png"))
	fridge.connect("wrong", self, "fridge_wrong")
	fridge.connect("correct", self, "fridge_correct")
	add_child(fridge)


func spawn_washing():
	var washingmachine = Fridge.instance()
	washingmachine.get_node("TB0").set_normal_texture(load("res://Art/Images/FridgeAAA.png"))
	washingmachine.get_node("TB1").set_normal_texture(load("res://Art/Images/FridgeD.png"))
	washingmachine.connect("wrong", self, "fridge_wrong")
	washingmachine.connect("correct", self, "fridge_correct")
	add_child(washingmachine)
	
	
	
func spawn_solar():
	var roof = Teddy.instance()
	roof.get_node("Bear").texture = load("res://Art/Images/dak.png")
	roof.get_node("Bear").scale = Vector2(0.75,0.75)
	roof.get_node("Bear").position = Vector2(1000,550)
	roof.get_node("Wool").hide()
	roof.get_node("Temperature").hide()
	roof.get_node("Ladder").show()
	
	for x in range(6):
		var solar_holder = Trashcan.instance()
		solar_holder.get_node("Sprite").texture = load("res://Art/Images/solar.png")
		solar_holder.get_node("Sprite").scale = Vector2(0.2,0.2)
		solar_holder.position = Vector2(500+300*x,375)
		if x > 2:
			solar_holder.position = Vector2(501+300*(x-3),725)
		add_child(solar_holder)
	add_child(roof)
	spawn_trash(["solar"])

func _on_Click_and_Drag_correct_waste_disposal():
	if minigame_name == "solar" and in_minigame_score < 5:
		spawn_trash(["solar"])
	in_minigame_score += 1
	play_correct()
	check_done()
	#print("wow correct indeed")

func _on_Click_and_Drag_incorrect_waste_disposal():
	play_wrong()
	check_done()
	#print("hmmm not so correct actually")

func lamp_off():
	in_minigame_score += 1
	minigame_done()

func fridge_correct():
	in_minigame_score += 2
	minigame_done()
	
func fridge_wrong():
	minigame_done(1)

func play_correct():
	$AudioStreamPlayer.stream = load("res://Art/Sound/ding.ogg")
	$AudioStreamPlayer.play()

func play_wrong():
	#print("it's wrong")
	$AudioStreamPlayer.stream = load("res://Art/Sound/wrong.ogg")
	$AudioStreamPlayer.play()

func play_finished():
	$AudioStreamPlayer.stream = load("res://Art/Sound/correct.ogg")
	$AudioStreamPlayer.play()

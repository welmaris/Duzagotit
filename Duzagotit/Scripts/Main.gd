extends Node

export (PackedScene) var QuestionBubble
export (PackedScene) var Question
export (PackedScene) var Minigame
export (PackedScene) var House1
export (PackedScene) var House2
export (PackedScene) var House3
export (PackedScene) var House4
export (PackedScene) var House5


var current_question_correct_answers = null
var QuestionScene
var MinigameScene
var questionnumber
var question_is_showing = false
var minigame_is_showing = false
var can_still_press_answer = true
var house
var housenumber = 0
var totalscore = 0
var array_of_questions_not_answered = []

# main
func new_game():
	$Player.position = (Vector2(600,900))
	house_select($HUD.selected)
	$Player.show()
	print($Player.get_index())
	$QuestionSpawnTimer.start()
	#remove_child(house)

# main
func _ready():
	$Player.hide()
	$HUD.reset_score()
	randomize()

func goto_house_select():
	$House.queue_free()
	$HUD.show_select()
	$HUD.update_house_score(totalscore)
	$Player.hide()
	$QuestionSpawnTimer.stop()
	for child in self.get_children(): 
			if (child.has_method("_on_VisibilityNotifier2D_screen_exited")): 
				child.queue_free()

func house_select(index):
	housenumber = index
	if index == 1:
		house = House1.instance()
	if index == 2:
		house = House2.instance()
	if index == 3:
		house = House3.instance()
	if index == 4:
		house = House4.instance()
	if index == 5:
		house = House5.instance()
	
	add_child(house)
	move_child(house,house.get_index() - 3)

# questions mc
func _on_QuestionSpawnTimer_timeout(): # spawns a question bubble for the player to click on
	$Path2D/PathFollow2D.offset = randi()
	var QB = QuestionBubble.instance()
	QB.connect("_on_Click_Question", self, "_on_Click_Question")
	add_child(QB)
	move_child(QB, get_child_count())
	QB.position = $Path2D/PathFollow2D.position
	if housenumber == 1:
		QB.category = "waste"
	if housenumber == 2:
		QB.category = "electricity"
	if housenumber == 3:
		QB.category = "water"

# questions mc
func answer_pressed(buttonint):
	if can_still_press_answer:
		var correct_style = StyleBoxFlat.new()
		var incorrect_style = StyleBoxFlat.new()
		correct_style.set_bg_color(Color("#aaea55"))
		incorrect_style.set_bg_color(Color("#eb5e54"))
		var btn = QuestionScene.get_node("B"+str(buttonint))
		if buttonint == current_question_correct_answers:
			# score += 2
			update_score(2)
			btn.set('custom_styles/pressed', correct_style)
			btn.set('custom_styles/hover', correct_style)
			btn.set('custom_styles/normal', correct_style)
			can_still_press_answer = false
			array_of_questions_not_answered[questionnumber] += 1
			play_correct()
		else:
	#		print("Not correct")
			btn.set('custom_styles/pressed', incorrect_style)
			btn.set('custom_styles/hover', incorrect_style)
			btn.set('custom_styles/normal', incorrect_style)
			QuestionScene.get_node("B"+str(current_question_correct_answers)).set('custom_styles/normal', correct_style)
			QuestionScene.get_node("B"+str(current_question_correct_answers)).set('custom_styles/hover', correct_style)
			QuestionScene.get_node("B"+str(current_question_correct_answers)).set('custom_styles/pressed', correct_style)
			can_still_press_answer = false
			play_wrong()
		var timer = Timer.new()
		timer.connect("timeout",self,"_on_answer_show_timeout") 
		timer.set_wait_time(2)
		timer.one_shot = true
		add_child(timer) 
		timer.start() 

func _on_answer_show_timeout():
	if is_instance_valid(QuestionScene):
		QuestionScene.queue_free()
	question_is_showing = false
	$QuestionSpawnTimer.start()

# stopt minigame na drukken op esc
func minigame_stop():
	if is_instance_valid(MinigameScene):
		get_node("Minigame").minigame_not_done()

# questions mc
func _on_Click_Question(category):
	if !minigame_is_showing and !question_is_showing:
		question_is_showing = true
		can_still_press_answer = true
		for child in self.get_children(): 
			if (child.has_method("_on_VisibilityNotifier2D_screen_exited")): 
				child.queue_free()
		var questionarray = get_New_Question(category) #TODO : make it so only new questions get shown
		$QuestionSpawnTimer.stop()
		#summon question scene
		QuestionScene = Question.instance()
		QuestionScene.connect("_button_pressed",self,"answer_pressed")
		add_child(QuestionScene)
		
		var numberofanswers = len(questionarray["answer"]) + 1
		var correctanswerindex = randi()% numberofanswers
		current_question_correct_answers = correctanswerindex
		var simplequestionarray
		simplequestionarray = questionarray["answer"]
		simplequestionarray.insert(correctanswerindex,questionarray["answercorrect"])
		#print(simplequestionarray)
		QuestionScene.get_node("QuestionTitle").text = questionarray["question"]   #display the question and answers
		QuestionScene.get_node("B0").text = simplequestionarray[0]
		QuestionScene.get_node("B1").text = simplequestionarray[1]
		QuestionScene.get_node("B0").show()
		QuestionScene.get_node("B1").show()
		if numberofanswers == 3 or numberofanswers == 4:
			QuestionScene.get_node("B2").text = simplequestionarray[2]
			QuestionScene.get_node("B2").show()
		else:
			QuestionScene.get_node("B2").hide()
		if numberofanswers == 4:
			QuestionScene.get_node("B3").text = simplequestionarray[3]
			QuestionScene.get_node("B3").show()
		else:
			QuestionScene.get_node("B3").hide()

# calls for a minigame to start
func _player_interract(name):
	if !minigame_is_showing and !question_is_showing:
		minigame_is_showing = true
		for child in self.get_children(): 
			if (child.has_method("_on_VisibilityNotifier2D_screen_exited")): 
				child.queue_free()
		$QuestionSpawnTimer.stop()
		MinigameScene = Minigame.instance()
		
		MinigameScene.minigame_name = name
		add_child(MinigameScene)

# questions mc
func get_New_Question(category):
	var questionfile = File.new()
	if questionfile.open("res://Art/Questions/questions.json", File.READ) != OK:  #parse questions.json to a usable object
		print("EVERYTHING IS BROKEN!!! (file didnt open)")
	var questionfiletext = questionfile.get_as_text()
	questionfile.close()
	var questionparse = JSON.parse(questionfiletext)
	if questionparse.error != OK:
		print("EVERYTHING IS BROKEN!!! (file didnt parse)")
	var questions = questionparse.result
	var numberofquestions = len(questions[category])
#	if array_of_questions_not_answered.size() == 0:
	var x = array_of_questions_not_answered.size()
	while x < numberofquestions:
		array_of_questions_not_answered.append(0)
		x+=1
	questionnumber = randi()% numberofquestions
	while array_of_questions_not_answered[questionnumber] > array_of_questions_not_answered.min():
		questionnumber = randi()% numberofquestions
	
	
	return questions[category][questionnumber]

func play_correct():
	#yield($AudioStreamPlayer, "finished")
	$AudioStreamPlayer.stream = load("res://Art/Sound/correct.ogg")
	$AudioStreamPlayer.play()

func play_wrong():
	#yield($AudioStreamPlayer, "finished")
	$AudioStreamPlayer.stream = load("res://Art/Sound/wrong.ogg")
	$AudioStreamPlayer.play()

func update_score(score: int):
	totalscore += score
	$HUD.update_score(score)

extends Node

export (PackedScene) var QuestionBubble
export (PackedScene) var Question
var score
var questionstatus = {}
var current_question_correct_answers = null
var QuestionScene
var question_is_showing = false

func new_game():
	$Player.start(Vector2(400,400))


func _ready():
	randomize()
	new_game()
	
func _on_QuestionSpawnTimer_timeout(): # spawns a question bubble for the player to click on
	$Path2D/PathFollow2D.offset = randi()
	var QB = QuestionBubble.instance()
	QB.connect("_on_Click_Question", self, "_on_Click_Question")
	add_child(QB)
	QB.position = $Path2D/PathFollow2D.position

func answer_pressed(buttonint):
	var correct_style = StyleBoxFlat.new()
	var incorrect_style = StyleBoxFlat.new()
	correct_style.set_bg_color(Color("#aaea55"))
	incorrect_style.set_bg_color(Color("#eb5e54"))
	var btn = QuestionScene.get_node("B"+str(buttonint))
	if buttonint == current_question_correct_answers:
#		print("Correct")
#		QuestionScene.get_node("B0").hide()
#		QuestionScene.get_node("B1").hide()
#		QuestionScene.get_node("B2").hide()
#		QuestionScene.get_node("B3").hide()
		btn.set('custom_styles/pressed', correct_style)
	else:
#		print("Not correct")
		btn.set('custom_styles/pressed', incorrect_style)
		QuestionScene.get_node("B"+str(current_question_correct_answers)).set('custom_styles/normal', correct_style)
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

func _on_Click_Question(category):
	question_is_showing = true
	var questionarray = get_New_Question(category) #TODO : make it so only new questions get shown
	$QuestionSpawnTimer.stop()
	#summon question scene
	QuestionScene = Question.instance()
	QuestionScene.connect("_button_pressed",self,"answer_pressed")
	add_child(QuestionScene)
	
	
	var numberofanswers = len(questionarray) - 1
	var correctanswerindex = randi()% numberofanswers
	current_question_correct_answers = correctanswerindex
	var simplequestionarray
	simplequestionarray = questionarray["answer"]
	simplequestionarray.insert(correctanswerindex,questionarray["answercorrect"])
	print(simplequestionarray)
	QuestionScene.get_node("QuestionTitle").text = questionarray["question"]   #display the question and answers
	QuestionScene.get_node("B0").text = simplequestionarray[0]
	QuestionScene.get_node("B1").text = simplequestionarray[1]
	QuestionScene.get_node("B2").text = simplequestionarray[2]
	QuestionScene.get_node("B0").show()
	QuestionScene.get_node("B1").show()
	QuestionScene.get_node("B2").show()
	if numberofanswers == 4:
		QuestionScene.get_node("B3").text = simplequestionarray[3]
		QuestionScene.get_node("B3").show()
	else:
		QuestionScene.get_node("B3").hide()

func get_New_Question(category):
	var questionfile = File.new()
	if questionfile.open("res://Art/Questions/test.json", File.READ) != OK:  #parse questions.json to a usable object
		print("EVERYTHING IS BROKEN!!! (file didnt open)")
	var questionfiletext = questionfile.get_as_text()
	questionfile.close()
	var questionparse = JSON.parse(questionfiletext)
	if questionparse.error != OK:
		print("EVERYTHING IS BROKEN!!! (file didnt parse)")
	var questions = questionparse.result
	var numberofquestions = len(questions[category])
	var questionnumber = randi()% numberofquestions
	
	if questionstatus.has(questions[category][questionnumber]) == null:
		questionstatus[questions[category][questionnumber]] = "shown" #sets the status of the question as shown so it doesnt appear again
	
	
	return questions[category][questionnumber]


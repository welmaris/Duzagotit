extends Node

export (PackedScene) var QuestionBubble
export (PackedScene) var Question
var score

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

func _on_Click_Question(category):
	print("gothretho")
	get_New_Question(category)
	print("hi", category)
	$QuestionSpawnTimer.stop()
	#summon question scene
	var QuestionScene = Question.instance()
	add_child(QuestionScene)
	QuestionScene.get_node("B1").text = "hi"

func get_New_Question(category):
	var parser = XMLParser.new()
	parser.open("res://test.xml")
	parser.read();
	parser.skip_section()
	print(parser.get_current_line())
	for x in range(parser.get_attribute_count()):
		print(parser.get_attribute_name(x))
	print(parser.get_node_name())

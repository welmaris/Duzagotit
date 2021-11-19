extends Panel


var scoreLabel
var score = 0

func _ready():
	scoreLabel = get_node("Score")
	scoreLabel.set_text(score)

func increase_score():
	score+= 1
	scoreLabel.set_text(score)


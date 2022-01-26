extends CanvasLayer
signal start_game

var score = 0
var goal = 150

# Reset the score to 0
func reset_score():
	score = 0
	$ScoreLabel.text = "Score: " + str(score) + "/" + str(goal)

# increase score
func update_score(change: int):
#	Animation for the change in score?
	score += change
	var new = str(score)
	$ScoreLabel.text = "Score: " + str(score) + "/" + str(goal)

# 
func set_goal(newGoal : int):
	goal = newGoal
	$ScoreLabel.text = "Score: " + str(score) + "/" + str(goal)


func _on_StartGame_pressed():
	$StartButton.hide()
	emit_signal("start_game")

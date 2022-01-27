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
	goal_reached()
	$ScoreLabel.text = "Score: " + str(score) + "/" + str(goal)

# 
func set_goal(newGoal : int):
	goal = newGoal
	$ScoreLabel.text = "Score: " + str(score) + "/" + str(goal)

func show_instruction():
	$RichTextLabel.show()

func hide_instruction():
	$RichTextLabel.hide()	

func goal_reached():
	if score >= goal:
		print("succes!!!")
		return true
	return false
	

func _on_StartGame_pressed():
	$StartButton.hide()
	hide_instruction()
	emit_signal("start_game")

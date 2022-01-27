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

func set_goal(newGoal : int):
	goal = newGoal
	$ScoreLabel.text = "Score: " + str(score) + "/" + str(goal)

func show_instruction():
	$RichTextLabel.show()

func hide_instruction():
	$RichTextLabel.clear()
	
	$RichTextLabel.bbcode_text = "[b]%s[/b]" % "Bewegen:"
	$RichTextLabel.append_bbcode("[indent]%s[/indent]" % "- WASD")
	$RichTextLabel.append_bbcode("[indent]%s[/indent]" % "- Pijltjestoetsen")
	$RichTextLabel.newline()
	$RichTextLabel.newline()
	$RichTextLabel.append_bbcode("[b]%s[/b]" % "Interactie (met objecten):")
	$RichTextLabel.append_bbcode("[indent]%s[/indent]" % "- E")
	$RichTextLabel.append_bbcode("[indent]%s[/indent]" % "- Shift")
	$RichTextLabel.append_bbcode("[indent]%s[/indent]" % "- Spatiebalk")
	$RichTextLabel.append_bbcode("[indent]%s[/indent]" % "- Enter")

#	$RichTextLabel.hide()	

func goal_reached():
	if score >= goal:
		var success
		print("succes!!!")
		return true
	return false

func _on_StartGame_pressed():
	$StartButton.hide()
	hide_instruction()
	emit_signal("start_game")

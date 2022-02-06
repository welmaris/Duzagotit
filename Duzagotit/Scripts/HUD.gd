extends CanvasLayer
signal start_game

var score = 0
var goal = 5
var selected = 1
var house_select_enabled_index = 1 # which house is the last unlocked house
var sound_player
var last_goal_reached = false

func _ready():
	sound_player = AudioStreamPlayer.new()
	sound_player.stream = load("res://Art/Sound/unlock.wav")
	add_child(sound_player)

# Reset the score to 0
func reset_score():
	score = 0
	$ScoreLabel.text = "Score: " + str(score) if last_goal_reached else "Score: " + str(score) + "/" + str(goal)
	$HouseScore.text = "Score: " + str(score) if last_goal_reached else "Score: " + str(score) + "/" + str(goal)

# increase score
func update_score(change: int):
#	Animation for the change in score?
	score += change
	var new = str(score)
	goal_reached()
	$ScoreLabel.text = "Score: " + str(score) if last_goal_reached else "Score: " + str(score) + "/" + str(goal)

func set_goal(newGoal : int):
	if newGoal == 0:
		last_goal_reached = true
	goal = newGoal
	$ScoreLabel.text = "Score: " + str(score) if last_goal_reached else "Score: " + str(score) + "/" + str(goal)

func show_instruction():
	$RichTextLabel.show()

func update_house_score(score):
	$HouseScore.text = "" if last_goal_reached else "Score: " + str(score) + "/" + str(goal)

func hide_select():
	$Select/HouseSelect1.hide()
	$Select/HouseSelect2.hide()
	$Select/HouseSelect3.hide()
	$StartButton.hide()
	$HouseScore.hide()

func show_select():
	$Select/HouseSelect1.show()
	$Select/HouseSelect2.show()
	$Select/HouseSelect3.show()
	$StartButton.show()
	$HouseScore.show()

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
	$RichTextLabel.newline()
	$RichTextLabel.newline()
	$RichTextLabel.append_bbcode("[b]%s[/b]" % "Minigame verlaten:")
	$RichTextLabel.append_bbcode("[indent]%s[/indent]" % "- Escape")
#	$RichTextLabel.hide()	

func goal_reached():
	if score >= goal:
		var success
		#print("succes!!!")
		sound_player.play()
		if house_select_enabled_index < 3:
			house_select_enabled_index += 1
		$Select.get_node("HouseSelect" + str(house_select_enabled_index)).disabled = false
		$HouseScore.rect_position.y += 100
		$Message.text = "Huis "+str(house_select_enabled_index)+" is ontgrendeld."
		$Message.show()
		var message_timer = Timer.new()
		message_timer.connect("timeout",self,"_on_message_show_timeout") 
		message_timer.set_wait_time(3)
		message_timer.one_shot = true
		add_child(message_timer) 
		message_timer.start() 
		set_goal(goal + 5)
		if house_select_enabled_index == 3:
			set_goal(0)
		return true
	return false

func _on_message_show_timeout():
	$Message.hide()
		
func _on_StartGame_pressed():
	hide_select()
	hide_instruction()
	emit_signal("start_game")

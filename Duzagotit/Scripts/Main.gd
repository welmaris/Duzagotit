extends Node

export (PackedScene) var QuestionBubble
var score

func new_game():
	$Player.start(Vector2(400,400))


func _ready():
	randomize()
	new_game()
	
func _on_QuestionSpawnTimer_timeout():
	$Path2D/PathFollow2D.offset = randi()
	var QB = QuestionBubble.instance()
	add_child(QB)
	#var direction = Vector2()
	#QB.linear_velocity = Vector2(rand_range(QB.min_speed, QB.max_speed), 0)

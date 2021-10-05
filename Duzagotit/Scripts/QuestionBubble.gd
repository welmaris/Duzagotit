extends Area2D
signal _on_Click_Question(question_category)

export var min_speed = 30  # Minimum speed range.
export var max_speed = 50  # Maximum speed range.
var possible_categories
var category


# Called when the node enters the scene tree for the first time.
func _ready():
	category = "waste"
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y -= min_speed * delta
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_VraagBubbel_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		emit_signal("_on_Click_Question", category)
		queue_free()

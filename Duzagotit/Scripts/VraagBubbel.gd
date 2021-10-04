extends Area2D

export var min_speed = 30  # Minimum speed range.
export var max_speed = 50  # Maximum speed range.



# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y -= min_speed * delta
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

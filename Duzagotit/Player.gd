extends Area2D

signal hit

export var speed = 400
var screen_size


func _ready():
	#hide()
	screen_size = get_viewport_rect().size

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func _process(delta):
	var velocity = Vector2()

	if Input.is_action_pressed("move_right"):
	   velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()

	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

	if velocity.x > 0:
		$AnimatedSprite.animation = "walkR"
	elif velocity.x < 0:
		$AnimatedSprite.animation = "walkL"
	elif velocity.y < 0:
		$AnimatedSprite.animation = "walkU"
	elif velocity.y > 0:
		$AnimatedSprite.animation = "walkD"

func _on_Player_body_entered(_body ):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)

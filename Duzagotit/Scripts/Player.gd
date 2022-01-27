extends KinematicBody2D

signal hit

export var speed = 200
var screen_size
var velocity

func _ready():
	screen_size = get_viewport_rect().size
	$InteractArea/InteractionShape.disabled = true
	$WalkCollision.disabled = false


func start(pos):
	position = pos
	show()
#	$CollisionShape2D.disabled = false


func get_input(delta):
	var velocity = Vector2()
	if !get_parent().question_is_showing and !get_parent().minigame_is_showing:
		if Input.is_action_pressed("move_right"):
		   velocity.x += 1
		if Input.is_action_pressed("move_left"):
			velocity.x -= 1
		if Input.is_action_pressed("move_down"):
			velocity.y += 1
		if Input.is_action_pressed("move_up"):
			velocity.y -= 1
	else:
		if Input.is_action_pressed("ui_cancel"):
			get_parent()._on_answer_show_timeout()
			get_parent().minigame_stop()
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
		
	move_and_collide((velocity * delta))

#func _on_Player_body_entered( _body ):
#	hide()
#	print("yeah")
#	emit_signal("hit")
#	$InteractionShape.set_deferred("disabled", true)
#

func _physics_process(delta):
	get_input(delta)

#
#func _on_Player_hit():
#	hide()
#	emit_signal("hit")
#	$InteractionShape.set_deferred("disabled", true)

extends KinematicBody2D

signal hit

export var speed = 200
var screen_size
var velocity

func _ready():
	#hide()
	screen_size = get_viewport_rect().size

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func get_input(delta):
	velocity = Vector2()
#	if !get_parent().question_is_showing:
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
		
	velocity = velocity.normalized() * speed
 # end of commented if

func _physics_process(delta):
	get_input(delta)
	move_and_collide((velocity * delta))

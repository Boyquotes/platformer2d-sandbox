extends KinematicBody2D


export var gravity = 300
export var speed = 180
export var jump_speed = 200


var velocity = Vector2.ZERO


onready var ASprite = $AnimatedSprite


func _physics_process(delta):
	velocity.x = 0
	
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
	
	if velocity.x > 0:
		ASprite.play("walk")
		ASprite.flip_h = false
	elif velocity.x < 0:
		ASprite.play("walk")
		ASprite.flip_h = true
	else:
#		ASprite.play("idle")
		if velocity.y != 0:
			ASprite.play("jump")
		else:
			ASprite.play("idle")
	
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if Input.is_action_just_pressed("move_jump"):
		if is_on_floor():
			velocity.y -= jump_speed
	
	

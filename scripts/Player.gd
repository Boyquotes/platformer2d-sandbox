extends KinematicBody2D

class_name Player

const ATTACK_DISTANCE = 50
const ATTACK_STRENGTH = 10
const BLOCK_STRENGTH = 0.1

export var gravity = 300
export var speed = 180
export var jump_speed = 200


var velocity = Vector2.ZERO
var health = 100
var is_blocked = false

onready var ASprite = $AnimatedSprite
onready var AttackRaycast = $AttackRaycast
onready var Healthbar = $Healthbar

func _physics_process(delta):
	if Input.is_action_just_pressed("attack"):
		attack()
	
	velocity.x = 0
	
	if Input.is_action_pressed("block"):
		is_blocked = true
	else:
		is_blocked = false
	
	if not is_blocked:
		if Input.is_action_pressed("move_left"):
			velocity.x -= speed
		if Input.is_action_pressed("move_right"):
			velocity.x += speed
	
	if velocity.x > 0:
		ASprite.play("walk")
		ASprite.flip_h = false
		AttackRaycast.cast_to.x = ATTACK_DISTANCE
	elif velocity.x < 0:
		ASprite.play("walk")
		ASprite.flip_h = true
		AttackRaycast.cast_to.x = -ATTACK_DISTANCE
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
	
	update_ui()

func _ready():
	add_to_group('Player')


func capture_life():
	health += 25


func capture_diamond():
	GameState.diamonds_count += 1
	print('Current diamonds: ' + str(GameState.diamonds_count))


func hurt(damage):
	if not is_blocked:
		print('Not blocked!')
		if health > damage:
			health -= damage
			print('Player health: '+str(health))
		else:
			print('I am dead')
	else:
		print('I am blocked!')
		if health > damage:
			health -= (damage * BLOCK_STRENGTH)
			print('Player health: ' +str(health))
		else:
			print('I am dead')
	

func attack():
	if AttackRaycast.is_colliding():
		var target = AttackRaycast.get_collider()
		if target.is_in_group('Enemies'):
			if target.has_method('hurt'):
				if not is_blocked:
					target.hurt(ATTACK_STRENGTH)

func update_ui():
	Healthbar.value = health


#func block():
#	can_move = false

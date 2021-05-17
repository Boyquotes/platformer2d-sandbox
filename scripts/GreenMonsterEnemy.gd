extends KinematicBody2D


export var speed = 50
export var damage = 10


var health = 100
var target:Player = null
var motion: Vector2
var can_attack:bool = false

onready var ASprite = $AnimatedSprite
onready var DetectionRaycast = $DetectionRaycast
onready var AttackRaycast = $AttackRaycast
onready var AttackTimer = $AttackTimer


func follow_player(delta):
	if not can_attack:
		var direction = motion.direction_to(target.position) * speed
		motion.x = -(direction.x)
		motion.y = 0
		move_and_slide(motion)
		ASprite.play('walk')
	else:
		ASprite.play('idle')


func _physics_process(delta):
	if DetectionRaycast.is_colliding():
		var collider = DetectionRaycast.get_collider()
		if collider is Player:
			if not target:
				target = collider as Player
			follow_player(delta)
	else:
		target = null
		ASprite.play('idle')
	
	if AttackRaycast.is_colliding():
		var collider = AttackRaycast.get_collider()
		if collider == target:
			can_attack = true
			if AttackTimer.is_stopped():
				AttackTimer.start()
	else:
		can_attack = false
		AttackTimer.stop()


func attack():
	target.hurt(damage)


func _on_AttackTimer_timeout():
	attack()

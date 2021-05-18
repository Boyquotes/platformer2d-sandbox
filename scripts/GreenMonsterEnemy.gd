extends "res://scripts/Enemy.gd"

onready var ASprite = $AnimatedSprite
onready var AttackRaycast = $AttackRaycast
onready var Healthbar = $Healthbar

func do_on_attack():
	if target:
		if AttackRaycast.is_colliding():
			var p = AttackRaycast.get_collider()
			if p == target:
				target.hurt(damage)


func do_on_hurt():
	Healthbar.value = health


func do_on_move():
	ASprite.play('walk')


func do_on_idle():
	ASprite.play('idle')

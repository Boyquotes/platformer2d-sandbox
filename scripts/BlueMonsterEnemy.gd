extends KinematicBody2D


var target:Player = null
var health = 100
var can_attack = false

var fireball = preload("res://objects/Fireball.tscn")

onready var DetectionRaycast = $DetectionRaycast
onready var AttackTimer = $AttackTimer

func _ready():
	add_to_group('Enemies')


func attack():
	var fb = fireball.instance()
	get_tree().current_scene.add_child(fb)
	fb.global_position = self.global_position
	fb.look_at(target.position)


func hurt(damage):
	if health >= damage:
		health -= damage
		print('Enemy health: ' + str(health))
	else:
		print('Blue monster died')
		queue_free()


func _physics_process(delta):
	if DetectionRaycast.is_colliding():
		if not target:
			var collider = DetectionRaycast.get_collider() as Player
			target = collider
		if AttackTimer.is_stopped():
			AttackTimer.start()
	else:
		target = null
		AttackTimer.stop()


func _on_AttackTimer_timeout():
	attack()

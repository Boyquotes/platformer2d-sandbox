extends KinematicBody2D


export var attack_range = 100
export var damage = 10
export var speed = 50
export var attack_interval = 1
export var can_move = true

var health = 100
var target: Player = null
var motion: Vector2
var is_moving: bool = false

onready var DetectionRaycast: RayCast2D
onready var AttackTimer:Timer

func do_on_idle():
	pass


func do_on_move():
	pass


func do_on_attack():
	pass


func do_on_hurt():
	print('My health: ' + str(health))


func do_on_die():
	print('I am dead')


func _ready():
	# Create detection raycast
	DetectionRaycast = RayCast2D.new()
	DetectionRaycast.cast_to.x = -(attack_range)
	DetectionRaycast.cast_to.y = 0
	DetectionRaycast.enabled = true
	DetectionRaycast.exclude_parent = true
	add_child(DetectionRaycast)
	
	# create attack timer
	AttackTimer = Timer.new()
	AttackTimer.set_one_shot(false)
	AttackTimer.set_wait_time(attack_interval)
	AttackTimer.connect("timeout", self, "attack")
	add_child(AttackTimer)
	
	add_to_group('Enemies')

func die():
	do_on_die()
	queue_free()


func attack():
	if target:
		do_on_attack()


func chase_player(delta):
	var direction = motion.direction_to(target.position) * speed
	motion.x = -(direction.x)
	motion.y = 0
	is_moving = true
	move_and_slide(motion)


func hurt(dmg):
	if health >= dmg:
		health -= dmg
		do_on_hurt()
	else:
		die()


func _physics_process(delta):
	if DetectionRaycast.is_colliding():
		var collider = DetectionRaycast.get_collider()
		if collider is Player:
			if not target:
				var p = collider as Player
				target = p
			if AttackTimer.is_stopped():
				AttackTimer.start()
			if can_move and target:
					chase_player(delta)
	else:
		target = null
		AttackTimer.stop()
		is_moving = false
		
	if is_moving:
		do_on_move()
	else:
		do_on_idle()

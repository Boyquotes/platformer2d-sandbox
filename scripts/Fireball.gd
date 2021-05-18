extends Area2D


export var speed = 100
export var damage = 15

func _on_Fireball_body_entered(body):
	if body is Player:
		var player = body as Player
		player.hurt(damage)
	queue_free()


func _on_Fireball_area_entered(area):
	queue_free()


func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += speed * direction * delta


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

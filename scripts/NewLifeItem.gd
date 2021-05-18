extends Sprite



func _on_Area_body_entered(body):
	if body is Player:
		var player = body as Player
		if player.health < 90:
			player.capture_life()
			queue_free()

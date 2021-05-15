extends Sprite



func _on_Area2D_body_entered(body):
	if body is Player:
		print('player captures diamond')
		get_tree().call_group('Player', 'capture_diamond')
		queue_free()

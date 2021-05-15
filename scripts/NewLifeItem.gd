extends Sprite



func _on_Area_body_entered(body):
	if body is Player:
		print('Player captures new life')
		get_tree().call_group('Player', 'capture_life')
		queue_free()

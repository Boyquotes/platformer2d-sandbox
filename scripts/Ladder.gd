extends Area2D



func _on_Ladder_body_entered(body):
	if body is Player:
		print('Climb')
		var p = body as Player
		if not p.is_climbing:
			p.is_climbing = true


func _on_Ladder_body_exited(body):
	if body is Player:
		print('Not climb')
		var p = body as Player
		p.is_climbing = false

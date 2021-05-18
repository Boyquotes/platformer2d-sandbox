extends "res://scripts/Enemy.gd"

var fireball = preload("res://objects/Fireball.tscn")


func shoot_fireball():
	var fb = fireball.instance()
	get_tree().current_scene.add_child(fb)
	fb.global_position = self.global_position
	fb.look_at(target.position)


func do_on_attack():
	shoot_fireball()

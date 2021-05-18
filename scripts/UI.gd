extends Control


onready var Healthbar = $Healthbar


func _ready():
	add_to_group('UI')


func display_health(health):
	Healthbar.value = health

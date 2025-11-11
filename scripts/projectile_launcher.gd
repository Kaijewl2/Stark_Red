extends Node3D

const PROJECTILE = preload("uid://6h462v3iywp3")

@onready var timer: Timer = $Timer
	
func shoot():
	if timer.is_stopped():
		timer.start(0.1)
		var attack = PROJECTILE.instantiate()
		add_child(attack)
		attack.global_transform = global_transform

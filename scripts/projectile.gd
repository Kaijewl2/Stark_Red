extends RayCast3D

@export var speed := 50.0
@export var damage := 5

func _physics_process(delta: float) -> void:
	position += global_basis * Vector3.FORWARD * speed * delta
	target_position = Vector3.FORWARD * speed * delta
	force_raycast_update()
	
	if is_colliding():
		var collider = get_collider()
		if collider.has_method("hit"):
			collider.hit(damage)
			
		global_position = get_collision_point()
		set_physics_process(false)
		queue_free()

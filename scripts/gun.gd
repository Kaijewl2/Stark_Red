extends Node3D

@export var damage = 1.0

@onready var anim = $AnimationPlayer
@onready var shot_sound = $shot_sound
@onready var raycast = $RayCast3D

var can_shoot = false

func _process(delta: float) -> void:
	if Input.is_action_pressed("hit") and can_shoot and not anim.is_playing():
		anim.play("shoot")
		shot_sound.play()
		can_shoot = false
		if raycast.is_colliding():
			if raycast.get_collider().is_in_group("enemy"):
				raycast.get_collider().hit(damage)
				$hit_indicator.play()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "shoot":
		can_shoot = true
	elif anim_name == "equip":
		can_shoot = true
	if anim_name == "unequip":
		can_shoot = true
		visible = false
		

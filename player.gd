extends Area2D
signal hit
@export var speed = 400
var screen_size

func _ready() -> void:
	screen_size = get_viewport_rect().size

func _process(delta: float) -> void:
	var velo = Vector2.ZERO
	if Input.is_action_pressed("down"):
		velo.y += 1
	if Input.is_action_pressed("up"):
		velo.y -= 1
	if Input.is_action_pressed("right"):
		velo.x += 1
	if Input.is_action_pressed("left"):
		velo.x -= 1
		
	if velo.length() > 0:
		velo = velo.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
		
	if velo.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velo.x < 0
	elif velo.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velo.y > 0
	
	position += velo * delta
	position = position.clamp(Vector2.ZERO, screen_size)


func _on_body_entered(_body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled",true)
	

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func _on_hit() -> void:
	pass # Replace with function body.
